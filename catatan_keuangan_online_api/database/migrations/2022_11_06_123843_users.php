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
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('id_firebase')->nullable();
            $table->unsignedBigInteger('id_perusahaan')->nullable();
            $table->string('nama');
            $table->string('email');
            $table->boolean('super_user');
            $table->foreign('id_perusahaan')->references('id')->on('perusahaans');
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
        //
    }
};
