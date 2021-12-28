<?php

use App\Http\Controllers\API\JuegosController;
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

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('DgamesApi/Juegos/{apikey?}',[JuegosController::class,'index'])->name('DgamesApi.all');
Route::get('DgamesApi/Juegos/{apikey}/{id}',[JuegosController::class,'show'])->name('DgamesApi.show');
Route::get('DgamesApi/Juegos/{apikey}/juego/{name}',[JuegosController::class,'showName'])->name('DgamesApi.showName');
Route::get('DgamesApi/apiJuego',[JuegosController::class,'mostrar']);
