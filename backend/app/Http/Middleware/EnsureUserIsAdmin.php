<?php

namespace App\Http\Middleware;

use App\Models\User;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class EnsureUserIsAdmin
{
    /**
     * Handle an incoming request.
     *
     * @param  Closure(Request): (Response)  $next
     */
    public function handle(Request $request, Closure $next)
    {
        /** @var User|null $user */
        $user = Auth::guard('api')->user();

        if (!$user || !$user->isAdmin()) {
            return response()->json([
                'error' => 'Forbidden. Admin access required.',
            ], 403);
        }

        return $next($request);
    }
}
