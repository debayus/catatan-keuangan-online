<?php

namespace App\Http\Controllers;

use App\Models\HutangPiutang;
use App\Models\MutasiRekening;
use App\Models\PengeluaranPemasukan;
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
            $pengeluaran_pemasukan = PengeluaranPemasukan::where('id_rekening', '=', $id)->count();
            $hutang_piutang = HutangPiutang::where('id_rekening', '=', $id)->count();
            $mutasi_rekening_dari = MutasiRekening::where('id_rekening_dari', '=', $id)->count();
            $mutasi_rekening_tujuan = MutasiRekening::where('id_rekening_tujuan', '=', $id)->count();
            if ($pengeluaran_pemasukan > 0 || $hutang_piutang > 0 || $mutasi_rekening_dari > 0 || $mutasi_rekening_tujuan > 0){
                return response()->json('Terdapat transaksi yang menggunakan data ini', 400);
            }

            $model = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
            if (empty($model)) return response()->json('Data tidak ditemukan', 400);

            $model->delete();

            return response()->json(['id' => $model->id], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }
}
