<?php

use App\Http\Controllers\GeneroController;
use App\Http\Controllers\JuegoController;
use App\Http\Controllers\JuegoGeneroController;
use App\Http\Controllers\JuegoPlataformaController;
use App\Http\Controllers\PlataformaController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

//Route::get('/dashboard', function () {
//    return view('dashboard');
//})->middleware(['auth'])->name('dashboard');

require __DIR__.'/auth.php';

Route::resource('Juego',JuegoController::class)->middleware(['rol']);
Route::resource('Genero',GeneroController::class)->middleware(['rol']);
Route::resource('Plataforma',PlataformaController::class)->middleware(['rol']);

Route::get('AgregarGenero/{id}',[JuegoGeneroController::class,'addJuegoGeneros'])->name('AñadirGenero')->middleware(['rol']);
Route::post('AgregarGenero/',[JuegoGeneroController::class,'storeJuegoGeneros'])->name('AñadirGenero.store')->middleware(['rol']);

Route::get('AgregarPlataforma/{id}',[JuegoPlataformaController::class,'addJuegoPlataformas'])->name('AñadirPlataforma')->middleware(['rol']);
Route::post('AgregarPlataforma/',[JuegoPlataformaController::class,'storeJuegoPlataformas'])->name('AñadirPlataforma.store')->middleware(['rol']);

Route::get('/perfiluser',function(){return view('auth/profile');})->middleware(['auth'])->name('User.Perfil');
