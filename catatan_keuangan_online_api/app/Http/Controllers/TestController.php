<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class TestController extends Controller
{
    public function index(Request $request)
    {
        return response()->json([
            'firebase_user' => $request->firebase_user,
            'user' => $request->user,
            'perusahaan' => $request->perusahaan,
        ]);
    }
}
