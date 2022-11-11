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
            if (empty($user)) return response('unauthorized', 401);
            $request->user = $user;

            // perusahaan
            $perusahaan = Perusahaan::where('id_user', '=', $user->id)->first();
            if (empty($perusahaan)){
                $perusahaanUser = PerusahaanUser::where('id_user', '=', $firebase_user->uid)->first();
                if (empty($perusahaanUser)){
                    $perusahaanUser = PerusahaanUser::where('email', '=', $firebase_user->email)->first();
                    if(!empty($perusahaanUser)){
                        $perusahaanUser->id_user = $user->id;
                    }
                }
                if (empty($perusahaanUser)){
                    $perusahaan = Perusahaan::find($perusahaanUser->id_perusahaan);
                    $request->perusahaan = $perusahaanUser->super_user;
                }
            }else{
                $request->super_user = true;
            }
            $request->perusahaan = $perusahaan;

            return $next($request);
        } catch (Exception $ex){
            return response($ex->getMessage(), 401);
        }
    }
}
