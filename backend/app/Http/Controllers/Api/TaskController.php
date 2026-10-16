<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Task;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class TaskController extends Controller
{
    public function index(Request $request)
    {
        /** @var User $user */
        $user = Auth::guard('api')->user();

        $validated = $request->validate([
            'search' => 'sometimes|nullable|string|max:255',
            'status' => 'sometimes|nullable|in:pending,in_progress,completed',
            'per_page' => 'sometimes|integer|min:1|max:100',
        ]);

        $tasks = Task::query()
            ->when(
                $user->isAdmin(),
                fn ($query) => $query->with('user:id,name,email'),
                fn ($query) => $query->where('user_id', $user->id)
            )
            ->filter($validated)
            ->latest()
            ->paginate($validated['per_page'] ?? 5);

        return response()->json([
            'data' => $tasks->items(),
            'meta' => [
                'current_page' => $tasks->currentPage(),
                'last_page' => $tasks->lastPage(),
                'total' => $tasks->total(),
            ],
        ]);
    }

    public function store(Request $request)
    {
        /** @var User $user */
        $user = Auth::guard('api')->user();

        $rules = [
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
        ];

        if ($user->isAdmin()) {
            $rules['user_id'] = 'required|exists:users,id';
        }

        $data = $request->validate($rules);

        $data['user_id'] = $user->isAdmin() ? $data['user_id'] : $user->id;

        $task = Task::create($data);

        return response()->json($task->load('user:id,name,email'), 201);
    }

    public function show(Task $task)
    {
        $this->authorizeView($task);
        return response()->json($task->load('user:id,name,email'));
    }

    public function update(Request $request, Task $task)
    {
        /** @var User $user */
        $user = Auth::guard('api')->user();

        if (!$user->isAdmin() && $task->user_id !== $user->id) {
            abort(403, 'You can only update your own tasks.');
        }

        $data = $request->validate([
            'title' => 'sometimes|string|max:255',
            'description' => 'nullable|string',
            'completed' => 'sometimes|boolean',
        ]);

        $task->update($data);

        return response()->json($task->load('user:id,name,email'));
    }

    public function destroy(Task $task)
    {
        /** @var User $user */
        $user = Auth::guard('api')->user();

        // Admin can delete any; user only their own
        if (!$user->isAdmin() && $task->user_id !== $user->id) {
            abort(403, 'You can only delete your own tasks.');
        }

        $task->delete();

        return response()->json(['message' => 'Task deleted']);
    }

    private function authorizeView(Task $task)
    {
        /** @var User $user */
        $user = Auth::guard('api')->user();

        if (!$user->isAdmin() && $task->user_id !== $user->id) {
            abort(403, 'You are not allowed to view this task.');
        }
    }
}