<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateJuegosGenerosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('juego_genero', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('juegoid');
            $table->unsignedBigInteger('generoid')->nullable();
            $table->timestamp('created_at')->nullable();

            $table->foreign('juegoid')->references('idJuego')->on('juego')->onDelete('cascade');
            $table->foreign('generoid')->references('idGenero')->on('genero')->nullOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('juego_genero');
    }
}
