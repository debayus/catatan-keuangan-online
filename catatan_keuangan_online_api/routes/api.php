<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\GrafikController;
use App\Http\Controllers\HutangPiutangController;
use App\Http\Controllers\HutangPiutangPembayaranController;
use App\Http\Controllers\JenisPengeluaranPemasukanController;
use App\Http\Controllers\MutasiRekeningController;
use App\Http\Controllers\PengeluaranPemasukanController;
use App\Http\Controllers\RekeningController;
use App\Http\Controllers\TestController;
use App\Http\Controllers\TransaksiController;
use App\Http\Controllers\UserController;
use App\Models\HutangPiutang;
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
    Route::post('/auth', [AuthController::class, 'store']);
});

Route::group(['middleware' => ['firebase.admin']], function(){
    Route::prefix('/auth')->controller(AuthController::class)->group(function () {
        Route::get('/', 'index');
        Route::delete('/', 'destroy');
    });

    Route::prefix('/rekening')->controller(RekeningController::class)->group(function () {
        Route::get('/', 'index');
        Route::get('/{id}', 'show');
        Route::post('/','store');
        Route::put('/{id}','update');
        Route::delete('/{id}', 'destroy');
    });

    Route::prefix('/jenispengeluaranpemasukan')->controller(JenisPengeluaranPemasukanController::class)->group(function () {
        Route::get('/', 'index');
        Route::get('/{id}', 'show');
        Route::post('/','store');
        Route::put('/{id}','update');
        Route::delete('/{id}', 'destroy');
    });

    Route::prefix('/pengeluaranpemasukan')->controller(PengeluaranPemasukanController::class)->group(function () {
        Route::get('/user', 'user');
        Route::get('/{id}', 'show');
        Route::post('/','store');
        Route::put('/{id}','update');
        Route::delete('/{id}', 'destroy');
    });

    Route::prefix('/user')->controller(UserController::class)->group(function () {
        Route::get('/', 'index');
        Route::get('/{id}', 'show');
        Route::post('/','store');
        Route::put('/{id}','update');
        Route::delete('/{id}', 'destroy');
    });

    Route::prefix('/hutangpiutang')->controller(HutangPiutangController::class)->group(function () {
        Route::get('/', 'index');
        Route::get('/{id}', 'show');
        Route::post('/','store');
        Route::put('/{id}','update');
        Route::delete('/{id}', 'destroy');
    });

    Route::prefix('/mutasirekening')->controller(MutasiRekeningController::class)->group(function () {
        Route::get('/{id}', 'show');
        Route::post('/','store');
        Route::put('/{id}','update');
        Route::delete('/{id}', 'destroy');
    });

    Route::prefix('/transaksi')->controller(TransaksiController::class)->group(function () {
        Route::get('/', 'index');
    });

    Route::prefix('/hutangpiutangpembayaran')->controller(HutangPiutangPembayaranController::class)->group(function () {
        Route::get('/', 'index');
        Route::get('/{id}', 'show');
        Route::post('/','store');
        Route::put('/{id}','update');
        Route::delete('/{id}', 'destroy');
    });

    Route::prefix('/grafik')->controller(GrafikController::class)->group(function () {
        Route::get('/pengeluaranpemasukan', 'pengeluaran_pemasukan');
    });
});

Route::prefix('/test')->controller(TestController::class)->group(function () {
    Route::get('/', 'index');
    Route::get('/{id}', 'show');
    Route::post('/','store');
    Route::put('/{id}','update');
    Route::delete('/{id}', 'destroy');
});
