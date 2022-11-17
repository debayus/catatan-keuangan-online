<?php

namespace App\Http\Controllers;

use App\Models\PerusahaanUser;
use App\Models\User;
use Exception;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function index(Request $request)
    {
        try{
            $query = PerusahaanUser::where('id_perusahaan', '=', $request->perusahaan->id)
            ->leftJoin('users', 'users.id', '=', 'perusahaan_users.id_user')
            ->select(
                'perusahaan_users.id',
                'users.nama',
                'perusahaan_users.email',
                'users.id_firebase',
                'perusahaan_users.super_user'
            );
            if (isset($request->filter)){
                $query = $query->where('nama', 'like', '%'.$request->filter.'%');
            }
            $totalRowCount = $query->count();
            $models = $query->simplePaginate(30);

            return response()->json([
                'data' => $models,
                'totalRowCount' => $totalRowCount
            ]);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }

    public function store(Request $request)
    {
        if (!$request->super_user) return response()->json('unauthorized', 401);
        try{
            $model = new PerusahaanUser;
            $model->id_perusahaan = $request->perusahaan->id;
            $model->email = $request->email;
            $model->super_user = $request->input_super_user;
            $model->save();
            return response()->json(['id' => $model->id], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }

    public function show(Request $request, $id)
    {
        try{
            $model = $query = PerusahaanUser::where('id_perusahaan', '=', $request->perusahaan->id)
            ->leftJoin('users', 'users.id', '=', 'perusahaan_users.id_user')
            ->select(
                'perusahaan_users.id',
                'users.nama',
                'perusahaan_users.email',
                'users.id_firebase',
                'perusahaan_users.super_user'
            )->find($id);
            if (empty($model)) return response()->json([
                'message' => 'Data tidak ditemukan'
            ], 401);

            return response()->json($model, 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }

    public function update(Request $request, $id)
    {
        if (!$request->super_user) return response()->json('unauthorized', 401);
        try{
            $model = PerusahaanUser::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
            if (empty($model)) return response()->json([
                'message' => 'Data tidak ditemukan'
            ], 401);
            $modelUser = User::find($model->id_user);
            if (!empty($modelUser)){
                $modelUser->nama = $request->nama;
                $modelUser->save();
            }

            $model->email = $request->email;
            $model->super_user = $request->input_super_user;
            $model->save();

            return response()->json(['id' => $model->id], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }

    public function destroy(Request $request, $id)
    {
        if (!$request->super_user) return response()->json('unauthorized', 401);
        try{
            $model = PerusahaanUser::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
            if (empty($model)) return response()->json([
                'message' => 'Data tidak ditemukan'
            ], 401);

            $model->delete();

            return response()->json(['id' => $model->id], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }
}
