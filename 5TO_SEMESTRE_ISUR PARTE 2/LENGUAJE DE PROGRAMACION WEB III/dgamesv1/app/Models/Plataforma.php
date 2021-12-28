<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Plataforma extends Model
{
    protected $table = 'plataforma';
    protected $primaryKey = 'idplataforma';
    protected $perPage = 10;

    protected $fillable = ['nombreplataforma'];

    public function Juegos(){
        return $this->belongsToMany(Juego::class);
    }
//    use HasFactory;
}
