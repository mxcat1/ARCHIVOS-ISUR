<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateJuegosGaleriaTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('juego_galeria', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('juegoid');
            $table->unsignedBigInteger('imagengaleriaid')->nullable();
            $table->timestamp('created_at')->nullable();

            $table->foreign('juegoid')->references('idJuego')->on('juego')->onDelete('cascade');
            $table->foreign('imagengaleriaid')->references('idgaleriaimagen')->on('galeriaimagen')->nullOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('juego_galeria');
    }
}
