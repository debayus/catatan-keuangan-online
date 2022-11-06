<?php

namespace App\Http\Middleware;

use App\Models\Perusahaan;
use App\Models\PerusahaanUser;
use App\Models\User;
use Closure;
use Exception;
use Illuminate\Http\Request;
use Kreait\Firebase\Factory;

class FirebaseAuth
{
    public function handle(Request $request, Closure $next)
    {
        try{

            // firebase
            $idToken = $request->bearerToken();
            $auth = (new Factory)->withServiceAccount(base_path('firebase-adminsdk.json'))->createAuth();
            $verifiedIdToken = $auth->verifyIdToken($idToken);
            $uid = $verifiedIdToken->claims()->get('sub');
            $firebase_user = $auth->getUser($uid);
            $request->firebase_user = $firebase_user;

            // user
            $user = User::where('id_firebase', '=', $uid)->first();
            $request->user = $user;

            // perusahaan
            if (!empty($user)){
                $perusahaan = Perusahaan::where('id_user', '=', $user->id)->first();
                if (empty($perusahaan)){
                    $perusahaanUser = PerusahaanUser::where(function ($query) use($firebase_user) {
                        $query
                        ->where('id_user', '=', $firebase_user->uid)
                        ->orWhere('email', '=', $firebase_user->email);
                    })->first();
                    if (empty($perusahaan)){
                        $perusahaan = Perusahaan::find($perusahaanUser->id_perusahaan);
                    }
                }
                $request->perusahaan = $perusahaan;
            }

            return $next($request);
        } catch (Exception $ex){
            return response($ex->getMessage(), 401);
        }
    }
}
