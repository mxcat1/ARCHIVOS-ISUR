<?php

namespace App\Http\Controllers;

use App\Models\Genero;
use App\Models\Juego;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class JuegoGeneroController extends Controller
{
    /**
     * Display the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function addJuegoGeneros($id)
    {
        $juego = Juego::find($id);
        $listageneros = Genero::whereNotIn('idGenero',Juego::find($id)->Generos()->select('generoid'))->get();
//        $listageneros = Genero::get();

        return view('dgamesv1.juegogeneroviews.AgregarGeneroJuego', compact('juego', 'listageneros'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function storeJuegoGeneros(Request $request)
    {
        $request->validate([
            'generoJuego'=>'required|min:1'
        ]);

        $input = $request->all();
        $juego = Juego::find($input['juego']);
        $juego->Generos()->attach($input['generoJuego']);

        return redirect()->route('Juego.show', $input['juego']);
    }
}
