<?php

namespace App\Http\Controllers;

use App\Models\Perusahaan;
use App\Models\PerusahaanUser;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AuthController extends Controller
{
    public function index(Request $request)
    {
        $perusahaan_user = PerusahaanUser::where('id_perusahaan', '=', $request->perusahaan->id)
            ->where('id_user', '=', $request->user->id)
            ->first();
        return response()->json([
            'perusahaan' => $request->perusahaan->nama,
            'id' => $request->user->id,
            'id_perusahaan_user' => $perusahaan_user->id,
            'nama' => $request->user->nama,
            'super_user' => $request->super_user
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

            // create perusahaan user
            $perusahaanuser = new PerusahaanUser;
            $perusahaanuser->id_perusahaan = $perusahaan->id;
            $perusahaanuser->id_user = $user->id;
            $perusahaanuser->email = $user->email;
            $perusahaanuser->super_user = true;
            $perusahaanuser->save();

            DB::commit();
        }
        return response()->json(['success' => true], 200);
    }

    public function destroy(Request $request)
    {
        DB::beginTransaction();

        if (empty($request->perusahaan)){
            if ($request->perusahaan->id_user == $request->user->id){

                // all delete perusahaanUsers
                PerusahaanUser::where('id_perusahaan', '=', $request->perusahaan->id)->delete();

            }else{

                // delete perusahaanUser
                PerusahaanUser::where('id_perusahaan', '=', $request->perusahaan->id)
                ->where('id_user', '=', $request->user->id)
                ->delete();

            }
        }

        // update user
        $user = User::find($request->user->id);
        $user->email = null;
        $user->id_firebase = null;
        $user->save();

        DB::commit();

        return response()->json(['success' => true], 200);
    }
}
