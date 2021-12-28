<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Juego extends Model
{
    protected $table = 'Juego';
    protected $primaryKey = 'idJuego';
    protected $perPage = 10;

    protected $fillable = ['nombreJuego','descripcionJuego','fechalanzamientoJuego','desarrolladoraJuego','imagenJuego','videoJuego','precioJuego','stockJuego','estadoJuego'];

    public function Generos(){
        return $this->belongsToMany(Genero::class,'juego_genero','juegoid','generoid');
    }
    public function Plataformas(){
        return $this->belongsToMany(Plataforma::class,'juego_plataforma','juegoid','plataformaid');
    }

}
