<?php

namespace App\Http\Controllers;

use App\Models\Plataforma;
use Illuminate\Http\Request;

class PlataformaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $listaplataformas=Plataforma::paginate();

        return view('dgamesv1.plataformaviews.index',compact('listaplataformas'));

    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('dgamesv1.plataformaviews.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request->validate([
            'nombreplataforma'=>'required|min:5|max:255|unique:App\Models\Plataforma'
        ]);
        $nuevaplataforma=$request->all();

        Plataforma::create($nuevaplataforma);
        return redirect()->route('Plataforma.index')->with('success', 'Nueva Plataforma Agregada');
    }

    /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function show(int $id)
    {

    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Plataforma  $plataforma
     * @return \Illuminate\Http\Response
     */
    public function edit(int $id)
    {
        $plataforma = Plataforma::find($id);
        return view('dgamesv1.plataformaviews.edit', compact('plataforma'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Plataforma  $plataforma
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Plataforma $plataforma)
    {
        $plataforma = Plataforma::find($request->idplataforma);
        $editarplataforma = $request->all();
        $plataforma->update($editarplataforma);
        return redirect()->route('Plataforma.index')->with('success', 'Datos de la plataforma Actualizados con Exito');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Plataforma  $plataforma
     * @return \Illuminate\Http\Response
     */
    public function destroy(Plataforma $plataforma)
    {
        //
    }
}
