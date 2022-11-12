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

            return $next($request);
        } catch (Exception $ex){
            return response($ex->getMessage(), 401);
        }
    }
}
