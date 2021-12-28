<?php

namespace App\Http\Controllers;

use App\Models\Genero;
use Illuminate\Http\Request;

class GeneroController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $listageneros = Genero::paginate();

        return view('dgamesv1.generoviews.index', compact('listageneros'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('dgamesv1.generoviews.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request->validate([
            'nombreGenero' => 'required|min:5|max:255|unique:App\Models\Genero'
        ]);
        $nuevogenero = $request->all();

        Genero::create($nuevogenero);
        return redirect()->route('Genero.index')->with('success', 'Nuevo Genero Agregado');
    }

    /**
     * Display the specified resource.
     *
     * @param \App\Models\Genero $genero
     * @return \Illuminate\Http\Response
     */
    public function show(Genero $genero)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function edit(int $id)
    {
        $genero = Genero::find($id);
        return view('dgamesv1.generoviews.edit', compact('genero'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param \App\Models\Genero $genero
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Genero $genero)
    {
        $genero = Genero::find($request->idGenero);
        $editargenero = $request->all();
        $genero->update($editargenero);
        return redirect()->route('Genero.index')->with('success', 'Datos del Genero Actualizados con Exito');

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(int $id)
    {
        $genero = Genero::find($id);
        $genero->delete();
        return redirect()->route('Genero.index')->with('success', 'Genero Eliminado Con Exito');
    }
}
