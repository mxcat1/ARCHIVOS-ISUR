<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreJuegoPost;
use App\Models\Juego;
use Illuminate\Http\Request;

class JuegoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $listaJuegos = Juego::paginate();

        return view('dgamesv1.juegoviews.index', compact('listaJuegos'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
//        if(isset($request)){
//            $Datos=$request->all();
//        }
        return view('dgamesv1.juegoviews.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreJuegoPost $request)
    {
//        $request->validate([
//            'nombreJuego' => 'required|min:1|max:255',
//            'descripcionJuego' => 'required|min:10',
//            'fechalanzamientoJuego' => 'required',
//            'desarrolladoraJuego' => 'required|min:5|max:255',
//            'imagenJuego' => 'required'
//        ]);

        $request->validated();
        $nuevojuego = $request->all();
        if ($imagen = $request->file('imagenJuego')) {
            $destino = 'imagenes/';
            $nombreimagen = $request->nombreJuego . date('YmdHis') . '.' . $imagen->getClientOriginalExtension();
            $imagen->move($destino, $nombreimagen);
            $nuevojuego['imagenJuego'] = "$nombreimagen";
        }

        Juego::create($nuevojuego);

        return redirect()->route('Juego.index')->with('success', 'Nuevo Juego Agregado');
    }

    /**
     * Display the specified resource.
     *
     * @param \App\Models\Juego $juego
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $juego=Juego::find($id);

        return view('dgamesv1.juegoviews.show',compact('juego'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * //     * @param \App\Models\Juego $juego
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $juego = Juego::find($id);
        return view('dgamesv1.juegoviews.edit', compact('juego'));
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
        $request->validate([
            'nombreJuego' => 'required|min:1|max:255',
            'descripcionJuego' => 'required|min:10',
            'fechalanzamientoJuego' => 'required',
            'desarrolladoraJuego' => 'required|min:5|max:255',
        ]);
        $juego=Juego::find($request->idJuego);
        $editarjuego = $request->all();
        if ($imagen = $request->file('imagenJuego')) {
            $destino = 'imagenes/';
            $nombreimagen = $request->nombreJuego . date('YmdHis') . '.' . $imagen->getClientOriginalExtension();
            $imagen->move($destino, $nombreimagen);
            $editarjuego['imagenJuego'] = "$nombreimagen";
            if(file_exists($destino.$juego->imagenJuego)){
                unlink($destino.$juego->imagenJuego);
            }
        }else{
            unset($editarjuego['imagenJuego']);
        }

        $juego->update($editarjuego);

        return redirect()->route('Juego.index')->with('success', 'Datos del Juego Actualizados con Exito');
    }

    /**
     * Remove the specified resource from storage.
     *
//     * @param \App\Models\Juego $juego
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(int $id)
    {
        $juego=Juego::find($id);
        $destino = 'imagenes/';
        if(file_exists($destino.$juego->imagenJuego)){
            unlink($destino.$juego->imagenJuego);
        }
        $juego->delete();
        return redirect()->route('Juego.index')->with('success', 'Juego Eliminado Con Exito');

    }
}
