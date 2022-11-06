<?php

namespace App\Http\Controllers;

use App\Models\Perusahaan;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AuthController extends Controller
{
    public function index(Request $request)
    {
        return response()->json([
            'perusahaan' => $request->perusahaan
        ]);
    }

    public function store(Request $request)
    {
        if (empty($request->perusahaan)){
            DB::beginTransaction();

            // create user
            $user = new User;
            $user->id_firebase = $request->firebase_user->uid;
            $user->nama = $request->firebase_user->email;
            $user->email = $request->firebase_user->email;
            $user->save();

            // create perusahan
            $perusahaan = new Perusahaan;
            $perusahaan->id_user = $user->id;
            $perusahaan->nama = $request->firebase_user->email;
            $perusahaan->save();

            DB::commit();
        }
        return response()->json(['success' => 'success'], 200);
    }
}
