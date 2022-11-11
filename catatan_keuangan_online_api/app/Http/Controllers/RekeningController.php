<?php

namespace App\Http\Controllers;

use App\Models\Rekening;
use Illuminate\Http\Request;

class RekeningController extends Controller
{
    public function index(Request $request)
    {
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
    }

    public function store(Request $request)
    {
        $model = new Rekening;
        $model->id_perusahaan = $request->perusahaan->id;
        $model->nama = $request->nama;
        $model->icon = $request->icon;
        $model->saldo = $request->saldo;
        $model->save();

        return response()->json(['success' => true], 200);
    }

    public function show(Request $request, $id)
    {
        $model = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
        if (empty($model)) return response()->json([
            'message' => 'Data tidak ditemukan'
        ], 401);

        return response()->json($model, 200);
    }

    public function update(Request $request, $id)
    {
        $model = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
        if (empty($model)) return response()->json([
            'message' => 'Data tidak ditemukan'
        ], 401);

        $model->nama = $request->nama;
        $model->icon = $request->icon;
        $model->save();

        return response()->json(['success' => true], 200);
    }

    public function destroy(Request $request, $id)
    {
        $model = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
        if (empty($model)) return response()->json([
            'message' => 'Data tidak ditemukan'
        ], 401);

        $model->delete();

        return response()->json(['success' => true], 200);
    }
}
