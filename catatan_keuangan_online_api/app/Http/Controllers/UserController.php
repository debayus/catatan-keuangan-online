<?php

namespace App\Http\Controllers;

use App\Models\HutangPiutang;
use App\Models\MutasiRekening;
use App\Models\PengeluaranPemasukan;
use App\Models\User;
use Exception;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function index(Request $request)
    {
        try{
            $query = User::where('id_perusahaan', '=', $request->perusahaan->id);
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
            $model = new User;
            $model->id_perusahaan = $request->perusahaan->id;
            $model->nama = $request->nama;
            $model->email = $request->email;
            $model->super_user = $request->input_super_user;
            $model->pemilik = false;
            $model->save();
            return response()->json(['id' => $model->id], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }

    public function show(Request $request, $id)
    {
        try{
            $model = User::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
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
            $model = User::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
            if (empty($model)) return response()->json('Data tidak ditemukan', 400);

            $model->nama = $request->nama;
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
        if (!$request->user->super_user) return response()->json('unauthorized', 401);
        try{
            $pengeluaran_pemasukan = PengeluaranPemasukan::where('id_user_create', '=', $id)->count();
            $pengeluaran_pemasukan_user = PengeluaranPemasukan::where('id_user', '=', $id)->count();
            $hutang_piutang = HutangPiutang::where('id_user_create', '=', $id)->count();
            $mutasi_rekening = MutasiRekening::where('id_user_create', '=', $id)->count();
            if ($pengeluaran_pemasukan > 0 || $hutang_piutang > 0 || $pengeluaran_pemasukan_user > 0 || $mutasi_rekening > 0){
                return response()->json('Terdapat transaksi yang menggunakan data ini', 400);
            }

            $model = User::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
            if (empty($model)) return response()->json('Data tidak ditemukan', 400);

            $model->delete();

            return response()->json(['id' => $model->id], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }
}
