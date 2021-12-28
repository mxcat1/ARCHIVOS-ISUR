<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Genero extends Model
{
    use HasFactory;
    protected $table = 'genero';
    protected $primaryKey = 'idGenero';
    protected $perPage = 10;

    protected $fillable = ['nombreGenero'];

    public function Juegos(){
        return $this->belongsToMany(Juego::class);
    }
}
