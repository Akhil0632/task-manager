## Task Manager

A full-stack task management application with JWT authentication, role-based access control, and a modern React frontend backed by a Laravel REST API.

---

## Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [Database Setup](#database-setup)
- [Running the Application](#running-the-application)
- [Default Credentials](#default-credentials)
- [API Reference](#api-reference)
- [Testing](#testing)
  
---

## Features

- **JWT authentication** — stateless tokens via tymon/jwt-auth.
- **Secure password hashing** — bcrypt via Laravel's Hash::make() / bcrypt() cast.
- **Role-Based Access Control (RBAC)** — admin and user roles.
- **Rate-limited auth** — 6 attempts/minute on login/register endpoints.
- **No user enumeration** — configurable threshold; surfaced on the dashboard and via API.
- **Order History** — identical 401 responses for wrong-email and wrong-password.

---

## Tech Stack

- **Backend**
    Laravel 10 / 11
    tymon/jwt-auth
    MySQL
    PHP 8.1+

- **Frontend**
    React 18
    React Router v6
    Axios
    Context API for auth state
  
---

## Requirements

- PHP **8.1** or newer
- Composer **2.x**
- Node.js **18+** and npm
- MySQL **8+**
- Git

---

## Installation 

### 1. Clone the repository
git clone https://github.com/Akhil0632/task-manager/
cd task-manager

### 2. Backend setup
cd backend
composer install
cp .env.example .env
php artisan key:generate

**Install and configure JWT**
composer require tymon/jwt-auth
php artisan vendor:publish --provider="Tymon\JWTAuth\Providers\LaravelServiceProvider"
php artisan jwt:secret

### 3. Frontend setup
cd ../frontend
npm install

### 4. Generate the application key
php artisan key:generate

---

## Configuration

### 1.Backend — backend/.env
Create .env and copy .env.example - cp .env.example .env

- APP_NAME="Task Manager"
- APP_ENV=local
- APP_DEBUG=true
- APP_URL=http://localhost:8000
  
Database
- DB_CONNECTION=mysql
- DB_HOST=127.0.0.1
- DB_PORT=3306
- DB_DATABASE=store_billing
- DB_USERNAME=root
- DB_PASSWORD=

---

## Database Setup
- Create the database task_manager in XAMPP

### Run migrations and seed
cd backend
php artisan migrate:fresh --seed

---

## Running the Application
Open two terminals

### Terminal 1 — Backend
cd backend
php artisan serve

### Terminal 2 — Frontend
cd frontend
npm run dev

## URL of Project
- Visit the url http://localhost:5173/ to get into the application.

---

## Default Credentials

Role	  Email	              Password
Admin	  admin@example.com	  admin123
User	  alice@example.com	  alice123
User	  bob@example.com	    bob123

---

## API Reference
- All endpoints accept and return application/json. Base URL: http://localhost:8000/api.
- Authenticated endpoints require:
  Authorization: Bearer <access_token>

### Authentication
**POST /api/auth/register**
- Create a new user account.
  
  Body:

  {
    "name": "Alice Johnson",
    "email": "alice@example.com",
    "password": "secret123",
    "password_confirmation": "secret123"
  }

  Responses:
    201 — { user, access_token, token_type, expires_in }
  Errors:
    422 — validation errors
    429 — rate limit exceeded

**POST /api/auth/login**
- Authenticate and receive a JWT.

  Body:
    {
      "email": "alice@example.com",
      "password": "alice123"
    }
  Responses 200:
      200 — { user, access_token, token_type, expires_in }
  Errors:
    401 — invalid credentials
    422 — validation errors

### Tasks

**GET /api/tasks**
- List tasks (paginated, searchable, filterable).

  
Param	    Type	   Default	  Notes
search	  string	 —	        Partial title match
status	  enum	   —	        pending | in_progress | completed
page	    int	     1	        Page number
per_page	int	   10	        1–100

  Responses 200:
    {
      "data": [ { "id": 1, "title": "...", "status": "pending", "created_at": "...", "user": { ... } } ],
      "meta": { "current_page": 1, "per_page": 10, "total": 27, "last_page": 3, "from": 1, "to": 10 },
      "links": { "prev": null, "next": "http://localhost:8000/api/tasks?page=2" }
    }

  Errors: 401, 422
  
**POST /api/tasks**
- Create a task.

Field	      Type	  Required	  Notes
title	      string 	Yes         max 255
description	string  No	        max 5000
status	    enum	  No	        defaults to pending
user_id	    int	    Admin only	required for admins

  Responses:
    201 — created task
    401 — unauthenticated
    422 — validation errors

**PUT /api/tasks/:id**
- Update a task. All fields optional.
  
  Body: any subset of title, description, status.

  Responses:
    200 — updated task
    401 — unauthenticated
    403 — not the owner
    404 — task not found

**DELETE /api/tasks/:id**
- Delete a task.

  Responses:
  200 — { "message": "Task deleted" }
  401 — unauthenticated
  403 — not the owner
  404 — task not found

  ---
