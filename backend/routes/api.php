<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\TaskController;
use App\Models\User;
use Illuminate\Support\Facades\Route;

Route::prefix('auth')->group(function () {
    Route::post('register', [AuthController::class, 'register']);
    Route::post('login', [AuthController::class, 'login']);
});



Route::middleware('auth:api')->group(function () {
    Route::get('me',       [AuthController::class, 'me']);
    Route::post('logout',  [AuthController::class, 'logout']);
    Route::post('refresh', [AuthController::class, 'refresh']);
    
    Route::apiResource('tasks', TaskController::class);

    Route::middleware('admin')->group(function () {
        Route::get('/admin/users', function () {
            return response()->json(
                User::select('id', 'name', 'email', 'role')->get()
            );
        });
    });
});