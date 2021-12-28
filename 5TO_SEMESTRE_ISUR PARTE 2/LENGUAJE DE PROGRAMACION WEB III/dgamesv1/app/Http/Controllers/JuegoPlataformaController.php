<?php

namespace App\Http\Controllers;

use App\Models\Juego;
use App\Models\Plataforma;
use Illuminate\Http\Request;

class JuegoPlataformaController extends Controller
{
    /**
     * Display the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function addJuegoPlataformas($id)
    {
        $juego = Juego::find($id);
        $listaPlataformas = Plataforma::whereNotIn('idplataforma',Juego::find($id)->Plataformas()->select('plataformaid'))->get();

        return view('dgamesv1.juegoplataformaviews.AgregarPlataformaJuego', compact('juego', 'listaPlataformas'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function storeJuegoPlataformas(Request $request)
    {
        $request->validate([
            'plataformaJuego'=>'required|min:1'
        ]);

        $input = $request->all();
        $juego = Juego::find($input['juego']);
        $juego->Plataformas()->attach($input['plataformaJuego']);

        return redirect()->route('Juego.show', $input['juego']);
    }
}
