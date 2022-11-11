<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\RekeningController;
use App\Http\Controllers\TestController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::group(['middleware' => ['firebase.auth']], function(){
    Route::get('/test', [TestController::class, 'index']);

    Route::get('/auth', [AuthController::class, 'index']);
    Route::post('/auth', [AuthController::class, 'store']);
    Route::delete('/auth', [AuthController::class, 'destroy']);

    Route::prefix('/rekening')->controller(RekeningController::class)->group(function () {
        Route::get('/', 'index');
        Route::get('/{id}', 'show');
        Route::post('/','store');
        Route::put('/{id}','update');
        Route::delete('/{id}', 'destroy');
    });

});

Route::prefix('/test')->controller(TestController::class)->group(function () {
    Route::get('/', 'index');
    Route::get('/{id}', 'show');
    Route::post('/','store');
    Route::put('/{id}','update');
    Route::delete('/{id}', 'destroy');
});
