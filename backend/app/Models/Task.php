<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Task extends Model
{
    use HasFactory;

    const STATUSES = ['pending', 'in_progress', 'completed'];

    protected $fillable = ['title', 'description', 'status', 'user_id'];

    public function user()
    {
        return $this->belongsTo(User::class);
    }


    public function scopeFilter($query, array $filters)
    {
        $query->when($filters['search'] ?? null, function ($q, $search) {
            $q->where('title', 'like', '%' . $search . '%');
        });

        $query->when($filters['status'] ?? null, function ($q, $status) {
            if (in_array($status, self::STATUSES, true)) {
                $q->where('status', $status);
            }
        });

        return $query;
    }
}