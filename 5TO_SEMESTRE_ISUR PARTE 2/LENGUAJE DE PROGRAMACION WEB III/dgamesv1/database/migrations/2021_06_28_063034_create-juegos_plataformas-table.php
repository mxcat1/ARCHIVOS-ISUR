<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateJuegosPlataformasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('juego_plataforma', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('juegoid');
            $table->unsignedBigInteger('plataformaid')->nullable();
            $table->timestamp('created_at')->nullable();

            $table->foreign('juegoid')->references('idJuego')->on('juego')->onDelete('cascade');
            $table->foreign('plataformaid')->references('idplataforma')->on('plataforma')->nullOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('juego_plataforma');
    }
}
