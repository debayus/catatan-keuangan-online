<?php

namespace App\Http\Middleware;

use Closure;
use Exception;
use Illuminate\Http\Request;
use Kreait\Firebase\Factory;
use Kreait\Firebase\Contract\Auth;

class FirebaseAuth
{
    public function handle(Request $request, Closure $next)
    {
        try{
            $idToken = $request->bearerToken();
            $auth = (new Factory)->withServiceAccount(base_path('firebase-adminsdk.json'))->createAuth();
            $verifiedIdToken = $auth->verifyIdToken($idToken);
            $uid = $verifiedIdToken->claims()->get('sub');
            $user = $auth->getUser($uid);
            $request->user = $user;
            return $next($request);
        } catch (Exception $ex){
            return response($ex->getMessage(), 401);
        }
    }
}
