<?php

namespace App\Http\Controllers;

use App\Models\Test;
use Illuminate\Http\Request;

class TestController extends Controller
{
    public function index(Request $request)
    {
        $query = Test::query();
        if (isset($request->filter)){
            $query = $query->where('name', 'like', '%'.$request->filter.'%');
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
        $model = new Test;
        $model->name = $request->name;
        $model->save();

        return response()->json(['id' => $model->id], 200);
    }

    public function show($id)
    {
        $model = Test::find($id);
        if (empty($model)) return response()->json('Data tidak ditemukan', 400);

        return response()->json($model, 200);
    }

    public function update(Request $request, $id)
    {
        $model = Test::find($id);
        if (empty($model)) return response()->json('Data tidak ditemukan', 400);

        $model->name = $request->name;
        $model->save();

        return response()->json(['id' => $model->id], 200);
    }

    public function destroy($id)
    {
        $model = Test::find($id);
        if (empty($model)) return response()->json('Data tidak ditemukan', 400);

        $model->delete();

        return response()->json(['id' => $model->id], 200);
    }
}
