<?php

namespace Database\Seeders;

use App\Models\Task;
use App\Models\User;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $admin = User::create([
            'name'              => 'Admin User',
            'email'             => 'admin@example.com',
            'email_verified_at' => now(),
            'role'              => 'admin',
            'password'          => bcrypt('admin123'),
        ]);

        $alice = User::create([
            'name'              => 'Alice Johnson',
            'email'             => 'alice@example.com',
            'email_verified_at' => now(),
            'role'              => 'user',
            'password'          => bcrypt('alice123'),
        ]);

        $bob = User::create([
            'name'              => 'Bob Smith',
            'email'             => 'bob@example.com',
            'email_verified_at' => now(),
            'role'              => 'user',
            'password'          => bcrypt('bob123'),
        ]);

        $randomUsers = User::factory()->count(5)->create();
        $randomAdmins = User::factory()->admin()->count(1)->create();

        $aliceTasks = [
            'inProgress'  => 8,
            'pending'     => 4,
            'completed'   => 3,
        ];
        foreach ($aliceTasks as $status => $count) {
            Task::factory()
                ->count($count)
                ->{$status}()          
                ->forUser($alice)
                ->create();
        }

        $bobTasks = [
            'completed'   => 7,
            'pending'     => 3,
            'inProgress'  => 2,
        ];
        foreach ($bobTasks as $status => $count) {
            Task::factory()
                ->count($count)
                ->{$status}()
                ->forUser($bob)
                ->create();
        }

        $randomUsers
            ->merge($randomAdmins)
            ->each(function (User $user) {
                Task::factory()
                    ->count(fake()->numberBetween(2, 5))
                    ->forUser($user)
                    ->create();
            });

        Task::factory()->count(3)->forUser($admin)->create();
    }
}