<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Juego;
use App\Models\User;
use Illuminate\Http\Request;

class JuegosController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @param string $apikey
     * @return \Illuminate\Http\Response
     */
    public function index(string $apikey='notoken')
    {
        if (User::select('api_token')->where('api_token',$apikey)->get()->count()>0) {
            $juegoslista = Juego::all();
            return response()->json(['data'=>$juegoslista], 201);
        }else {
            return response()->json(['message' => 'Error al consultar al API DE DGAMES'], 500);
        }
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * //     * @param \App\Models\Juego $juego
     * @param int $id
     * @param string $apikey
     * @return \Illuminate\Http\Response
     */
    public function show(string $apikey,int $id)
    {
        if (User::select('api_token')->where('api_token',$apikey)->get()->count()>0) {
            $juego = Juego::find($id);
            $juego->Generos;
            $juego->Plataformas;
            return response()->json(['data'=>$juego], 201);
        }else {
            return response()->json(['message' => 'Error al consultar al API DE DGAMES'], 500);
        }
    }

    /**
     * Display the specified resource.
     *
     * //     * @param \App\Models\Juego $juego
     * @param string $name
     * @param string $apikey
     * @return \Illuminate\Http\Response
     */
    public function showName(string $apikey,string $name)
    {
        if (User::select('api_token')->where('api_token',$apikey)->get()->count()>0) {
            $juego = Juego::where('nombreJuego','like',"$name%")->get();
            return response()->json(['data'=>$juego], 201);
        }else {
            return response()->json(['message' => 'Error al consultar al API DE DGAMES'], 500);
        }
    }
    /**
     * Display the specified resource.
     *
     * //     * @param \App\Models\Juego $juego
     * @param string $name
     * @param string $apikey
     * @return \Illuminate\Http\Response
     */
    public function mostrar(Request $request)
    {
        if (User::select('api_token')->where('api_token',$request->apikey)->get()->count()>0) {
            $juego = Juego::where('nombreJuego','like',"$request->juego%")->get();
            return response()->json(['data'=>$juego], 201);
        }else {
            return response()->json(['message' => 'Error al consultar al API DE DGAMES'], 500);
        }
    }


    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param \App\Models\Juego $juego
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Juego $juego)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param \App\Models\Juego $juego
     * @return \Illuminate\Http\Response
     */
    public function destroy(Juego $juego)
    {
        //
    }
}
