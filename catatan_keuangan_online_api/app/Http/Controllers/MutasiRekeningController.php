<?php

namespace App\Http\Controllers;

use App\Models\MutasiRekening;
use App\Models\MutasiRekeningPembayaran;
use App\Models\Rekening;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MutasiRekeningController extends Controller
{
    public function store(Request $request)
    {
        try{
            $rekening_dari = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($request->id_rekening_dari);
            if (empty($rekening_dari)) return response()->json('Rekening tidak ditemukan', 401);
            if ($rekening_dari->saldo < $request->nilai)return response()->json('Saldo kurang', 401);

            DB::beginTransaction();

            $model = new MutasiRekening;
            $model->id_user_create = $request->user->id;
            $model->id_perusahaan = $request->perusahaan->id;
            $model->id_rekening_dari = $request->id_rekening_dari;
            $model->id_rekening_tujuan = $request->id_rekening_tujuan;
            $model->tanggal = $request->tanggal;
            $model->nilai = $request->nilai;
            $model->catatan = $request->catatan;
            $model->save();

            $rekening_dari->saldo -= $request->nilai;
            $rekening_dari->save();

            $rekening_tujuan = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($request->id_rekening_tujuan);
            if (empty($rekening_tujuan)) return response()->json('Rekening tidak ditemukan', 401);

            $rekening_tujuan->saldo += $request->nilai;
            $rekening_tujuan->save();

            DB::commit();
            return response()->json(['id' => $model->id], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }

    public function show(Request $request, $id)
    {
        try{
            $model = MutasiRekening::where('mutasi_rekenings.id_perusahaan', '=', $request->perusahaan->id)
            ->leftJoin('rekenings as dari', 'dari.id', 'mutasi_rekenings.id_rekening_dari')
            ->leftJoin('rekenings as tujuan', 'tujuan.id', 'mutasi_rekenings.id_rekening_tujuan')
            ->select(
                'mutasi_rekenings.*',
                'dari.nama as id_rekening_dari_nama',
                'tujuan.nama as id_rekening_tujuan_nama',
            )
            ->find($id);
            if (empty($model)) return response()->json('Data tidak ditemukan', 401);

            return response()->json($model, 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }

    public function update(Request $request, $id)
    {
        try{
            $model = MutasiRekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
            if (empty($model)) return response()->json('Data tidak ditemukan', 401);

            $rekening_dari_old = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($model->id_rekening_dari);

            DB::beginTransaction();

            $rekening_dari_old->saldo += $model->nilai;
            $rekening_dari_old->save();

            $rekening_tujuan_old = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($model->id_rekening_tujuan);
            $rekening_tujuan_old->saldo -= $model->nilai;
            if ($model->id_rekening_tujuan != $request->id_rekening_tujuan && $rekening_tujuan_old->saldo < 0) return response()->json('Saldo kurang', 401);
            $rekening_tujuan_old->save();

            $model->id_rekening_dari = $request->id_rekening_dari;
            $model->id_rekening_tujuan = $request->id_rekening_tujuan;
            $model->tanggal = $request->tanggal;
            $model->nilai = $request->nilai;
            $model->catatan = $request->catatan;
            $model->save();

            $rekening_dari = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($request->id_rekening_dari);
            if (empty($rekening_dari)) return response()->json('Rekening tidak ditemukan', 401);
            $rekening_dari->saldo -= $model->nilai;
            if ($rekening_dari->saldo < 0)return response()->json('Saldo kurang', 401);
            $rekening_dari->save();

            $rekening_tujuan = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($request->id_rekening_tujuan);
            if (empty($rekening_tujuan)) return response()->json('Rekening tidak ditemukan', 401);
            $rekening_tujuan->saldo += $model->nilai;
            if ($rekening_tujuan->saldo < 0)return response()->json('Saldo kurang', 401);
            $rekening_tujuan->save();

            DB::commit();

            return response()->json(['id' => $model->id], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }

    public function destroy(Request $request, $id)
    {
        try{
            $model = MutasiRekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
            if (empty($model)) return response()->json('Data tidak ditemukan', 401);

            $rekening_dari_old = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($model->id_rekening_dari);

            DB::beginTransaction();

            $rekening_dari_old->saldo += $model->nilai;
            $rekening_dari_old->save();

            $rekening_tujuan_old = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($model->id_rekening_tujuan);
            $rekening_tujuan_old->saldo -= $model->nilai;
            if ($rekening_tujuan_old->saldo < 0) return response()->json('Saldo kurang', 401);
            $rekening_tujuan_old->save();

            $model->delete();

            DB::commit();
            return response()->json(['id' => $model->id], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }
}
