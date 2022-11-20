<?php

namespace App\Http\Controllers;

use App\Models\Rekening;
use Exception;
use Illuminate\Http\Request;

class RekeningController extends Controller
{
    public function index(Request $request)
    {
        try{
            $query = Rekening::where('id_perusahaan', '=', $request->perusahaan->id);
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
        if (!$request->user->super_user) return response()->json('unauthorized', 401);
        try{
            $model = new Rekening;
            $model->id_perusahaan = $request->perusahaan->id;
            $model->nama = $request->nama;
            $model->icon = $request->icon;
            $model->saldo = $request->saldo;
            $model->save();
            return response()->json(['id' => $model->id], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }

    public function show(Request $request, $id)
    {
        try{
            $model = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
            if (empty($model)) return response()->json('Data tidak ditemukan', 400);

            return response()->json($model, 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }

    public function update(Request $request, $id)
    {
        if (!$request->user->super_user) return response()->json('unauthorized', 401);
        try{
            $model = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
            if (empty($model)) return response()->json('Data tidak ditemukan', 400);

            $model->nama = $request->nama;
            $model->icon = $request->icon;
            $model->save();

            return response()->json(['id' => $model->id], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }

    public function destroy(Request $request, $id)
    {
        if (!$request->user->super_user) return response()->json('unauthorized', 401);
        try{
            $model = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
            if (empty($model)) return response()->json('Data tidak ditemukan', 400);

            $model->delete();

            return response()->json(['id' => $model->id], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }
}
