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
        Schema::create('pengeluaran_pemasukans', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('id_perusahaan');
            $table->unsignedBigInteger('id_user_create');
            $table->unsignedBigInteger('id_perusahaan_user');
            $table->unsignedBigInteger('id_jenis_pengeluaran_pemasukan');
            $table->unsignedBigInteger('id_rekening');
            $table->dateTime('tanggal');
            $table->decimal('nilai', 19, 4);
            $table->string('catatan')->nullable();
            $table->boolean('pengeluaran');
            $table->timestamps();
            $table->foreign('id_perusahaan')->references('id')->on('perusahaans');
            $table->foreign('id_user_create')->references('id')->on('users');
            $table->foreign('id_perusahaan_user')->references('id')->on('perusahaan_users');
            $table->foreign('id_jenis_pengeluaran_pemasukan')->references('id')->on('jenis_pengeluaran_pemasukans');
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
