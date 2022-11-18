<?php

namespace App\Http\Middleware;

use App\Models\Perusahaan;
use App\Models\User;
use Closure;
use Exception;
use Illuminate\Http\Request;
use Kreait\Firebase\Factory;

class AdminAuth
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
            if (empty($user)) {

                // perusahaan user
                $user = User::where('email', '=', $firebase_user->email)->first();
                if (empty($user)) return response('unauthorized', 401);

                // update user
                $user->id_firebase = $firebase_user->uid;
                $user->save();

            }
            $request->user = $user;

            // perusahaan
            $perusahaan = Perusahaan::find($user->id_perusahaan);
            if (empty($perusahaan)){
                return response('unauthorized', 401);
            }
            $request->perusahaan = $perusahaan;

            return $next($request);
        } catch (Exception $ex){
            return response($ex->getMessage(), 401);
        }
    }
}
