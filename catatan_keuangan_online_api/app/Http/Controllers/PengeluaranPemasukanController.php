<?php

namespace App\Http\Controllers;

use App\Models\PengeluaranPemasukan;
use App\Models\Rekening;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PengeluaranPemasukanController extends Controller
{
    public function store(Request $request)
    {
        try{
            $rekening = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($request->id_rekening);
            if (empty($rekening)) return response()->json([
                'message' => 'Rekening tidak ditemukan'
            ], 401);

            // check saldo
            $saldo = $rekening->saldo;
            if ($request->pengeluaran){
                $saldo -= $request->nilai;
            }else{
                $saldo += $request->nilai;
            }
            if ($saldo < 0) return response()->json([
                'message' => 'Saldo kurang'
            ], 401);

            DB::beginTransaction();

            $model = new PengeluaranPemasukan;
            $model->id_perusahaan = $request->perusahaan->id;
            $model->id_user_create = $request->user->id;
            $model->id_perusahaan_user = $request->id_perusahaan_user;
            $model->id_jenis_pengeluaran_pemasukan = $request->id_jenis_pengeluaran_pemasukan;
            $model->id_rekening = $request->id_rekening;
            $model->tanggal = $request->tanggal;
            $model->nilai = $request->nilai;
            $model->catatan = $request->catatan;
            $model->pengeluaran = $request->pengeluaran;
            $model->save();

            $rekening->saldo = $saldo;
            $model->save();

            DB::commit();
            return response()->json(['id' => $model->id], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 500);
        }
    }

    public function show(Request $request, $id)
    {
        try{
            $model = PengeluaranPemasukan::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
            if (empty($model)) return response()->json([
                'message' => 'Data tidak ditemukan'
            ], 401);

            return response()->json($model, 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 500);
        }
    }

    public function update(Request $request, $id)
    {
        try{
            $model = PengeluaranPemasukan::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
            if (empty($model)) return response()->json([
                'message' => 'Data tidak ditemukan'
            ], 401);

            $rekening_old = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($model->id_rekening);
            if (empty($rekening)) return response()->json([
                'message' => 'Rekening tidak ditemukan'
            ], 401);

            $rekening;
            if ($model->id_rekening != $request->id_rekening){
                $rekening = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($request->id_rekening);
                if (empty($rekening)) return response()->json([
                    'message' => 'Rekening tidak ditemukan'
                ], 401);
            }

            // check saldo old
            $saldo_new = null;
            $saldo_old = $rekening_old->saldo;
            if ($model->pengeluaran){
                $saldo_old += $model->nilai;
            }else{
                $saldo_old -= $model->nilai;
            }
            if (empty($rekening)){
                if ($model->pengeluaran){
                    $saldo_old -= $request->nilai;
                }else{
                    $saldo_old += $request->nilai;
                }
            }
            if ($saldo_old < 0) return response()->json([
                'message' => 'Saldo kurang'
            ], 401);
            if (!empty($rekening)){
                $saldo_new = $rekening->saldo;
                if ($model->pengeluaran){
                    $saldo_new -= $request->nilai;
                }else{
                    $saldo_new += $request->nilai;
                }
            }

            DB::beginTransaction();

            $model->id_perusahaan_user = $request->id_perusahaan_user;
            $model->id_jenis_pengeluaran_pemasukan = $request->id_jenis_pengeluaran_pemasukan;
            $model->id_rekening = $request->id_rekening;
            $model->tanggal = $request->tanggal;
            $model->nilai = $request->nilai;
            $model->catatan = $request->catatan;
            $model->pengeluaran = $request->pengeluaran;
            $model->save();

            $rekening_old->saldo = $saldo_old;
            if (!empty($rekening)){
                $rekening->saldo = $saldo_new;
            }

            $model->save();
            DB::commit();
            return response()->json(['id' => $model->id], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 500);
        }
    }

    public function destroy(Request $request, $id)
    {
        try{
            $model = PengeluaranPemasukan::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
            if (empty($model)) return response()->json([
                'message' => 'Data tidak ditemukan'
            ], 401);

            $rekening = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($model->id_rekening);
            if (empty($rekening)) return response()->json([
                'message' => 'Rekening tidak ditemukan'
            ], 401);

            // check saldo
            $saldo = $rekening->saldo;
            if ($request->pengeluaran){
                $saldo += $request->nilai;
            }else{
                $saldo -= $request->nilai;
            }
            if ($saldo < 0) return response()->json([
                'message' => 'Saldo kurang'
            ], 401);

            DB::beginTransaction();

            $model->delete();

            $rekening->saldo = $saldo;
            $model->save();

            DB::commit();
            return response()->json(['id' => $model->id], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 500);
        }
    }
}
