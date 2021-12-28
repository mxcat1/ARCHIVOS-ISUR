<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateJuegosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('juego', function (Blueprint $table) {
            $table->id('idJuego');
            $table->string('nombreJuego')->unique();
            $table->text('descripcionJuego');
            $table->date('fechalanzamientoJuego');
            $table->string('desarrolladoraJuego');
            $table->string('imagenJuego');
            $table->string('videoJuego')->nullable();;
            $table->decimal('precioJuego')->nullable();
            $table->bigInteger('stockJuego')->nullable();
            $table->enum('estadoJuego',['Activo','Inactivo','Descontinuado','Sin Especificar'])->default('Sin Especificar');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('juego');
    }
}
