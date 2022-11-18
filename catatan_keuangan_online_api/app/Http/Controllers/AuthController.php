<?php

namespace App\Http\Controllers;

use App\Models\Perusahaan;
use App\Models\User;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AuthController extends Controller
{
    public function index(Request $request)
    {
        try{
            return response()->json([
                'perusahaan' => $request->perusahaan->nama,
                'id' => $request->user->id,
                'nama' => $request->user->nama,
                'super_user' => $request->user->super_user
            ]);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }

    public function store(Request $request)
    {
        try{
            if (empty($request->perusahaan)){
                DB::beginTransaction();

                // create user
                $user = new User;
                $user->id_firebase = $request->firebase_user->uid;
                $user->nama = $request->firebase_user->email;
                $user->email = $request->firebase_user->email;
                $user->super_user = true;
                $user->save();

                // create perusahan
                $perusahaan = new Perusahaan;
                $perusahaan->id_user = $user->id;
                $perusahaan->nama = $request->firebase_user->email;
                $perusahaan->save();

                // update user
                $user->id_perusahaan = $perusahaan->id;
                $user->save();

                DB::commit();
            }
            return response()->json(['success' => true], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }

    public function destroy(Request $request)
    {
        try{
            // update user
            $user = User::find($request->user->id);
            $user->email = null;
            $user->id_firebase = null;
            $user->save();

            return response()->json(['success' => true], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }
}
