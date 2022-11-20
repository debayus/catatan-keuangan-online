<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('hutang_piutangs', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('id_perusahaan');
            $table->unsignedBigInteger('id_user_create');
            $table->unsignedBigInteger('id_rekening');
            $table->dateTime('tanggal');
            $table->dateTime('tanggal_tempo');
            $table->decimal('nilai', 19, 4);
            $table->decimal('dibayar', 19, 4);
            $table->string('catatan')->nullable();
            $table->boolean('hutang');
            $table->timestamps();
            $table->foreign('id_perusahaan')->references('id')->on('perusahaans');
            $table->foreign('id_user_create')->references('id')->on('users');
            $table->foreign('id_rekening')->references('id')->on('rekenings');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
};
