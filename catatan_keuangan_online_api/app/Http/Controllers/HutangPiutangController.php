<?php

namespace App\Http\Controllers;

use App\Models\HutangPiutang;
use App\Models\HutangPiutangPembayaran;
use App\Models\Rekening;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class HutangPiutangController extends Controller
{
    public function index(Request $request)
    {
        try{
            $query = HutangPiutang::where('id_perusahaan', '=', $request->perusahaan->id);
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
        try{
            DB::beginTransaction();

            $rekening = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($request->id_rekening);
            if (empty($rekening)) return response()->json('Rekening tidak ditemukan', 400);

            // check saldo
            $saldo = $rekening->saldo;
            if ($request->hutang){
                $saldo += $request->nilai;
            }else{
                $saldo -= $request->nilai;
            }
            if ($saldo < 0) return response()->json('Saldo kurang', 400);

            $model = new HutangPiutang;
            $model->id_perusahaan = $request->perusahaan->id;
            $model->id_user_create = $request->user->id;
            $model->id_rekening = $request->id_rekening;
            $model->tanggal = $request->tanggal;
            $model->tanggal_tempo = $request->tanggal_tempo;
            $model->nilai = $request->nilai;
            $model->catatan = $request->catatan;
            $model->hutang = $request->hutang;
            $model->dibayar = 0;
            $model->save();

            $rekening->saldo = $saldo;
            $rekening->save();

            DB::commit();
            return response()->json(['id' => $model->id], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }

    public function show(Request $request, $id)
    {
        try{
            $model = HutangPiutang::where('hutang_piutangs.id_perusahaan', '=', $request->perusahaan->id)
            ->leftJoin('rekenings', 'rekenings.id', 'hutang_piutangs.id_rekening')
            ->select(
                'hutang_piutangs.*',
                'rekenings.nama as id_rekening_nama'
            )
            ->find($id);
            if (empty($model)) return response()->json('Data tidak ditemukan', 400);

            return response()->json($model, 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }

    public function update(Request $request, $id)
    {
        try{
            $model = HutangPiutang::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
            if (empty($model)) return response()->json('Data tidak ditemukan', 400);

            DB::beginTransaction();

            $rekening_old = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($model->id_rekening);
            if (empty($rekening_old)) return response()->json('Rekening tidak ditemukan', 400);
            if ($model->hutang){
                $rekening_old->saldo -= $model->nilai;
            }else{
                $rekening_old->saldo += $model->nilai;
            }
            if ($rekening_old->saldo < 0) return response()->json('Saldo kurang', 400);
            $rekening_old->save();

            $rekening = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($request->id_rekening);
            if (empty($rekening)) return response()->json('Rekening tidak ditemukan', 400);
            if ($request->hutang){
                $rekening->saldo += $request->nilai;
            }else{
                $rekening->saldo -= $request->nilai;
            }
            if ($rekening->saldo < 0) return response()->json('Saldo kurang', 400);
            $rekening->save();

            $model->id_rekening = $request->id_rekening;
            $model->tanggal = $request->tanggal;
            $model->tanggal_tempo = $request->tanggal_tempo;
            $model->nilai = $request->nilai;
            $model->catatan = $request->catatan;
            // $model->hutang = $request->hutang;
            $model->save();

            DB::commit();
            return response()->json(['id' => $model->id], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }

    public function destroy(Request $request, $id)
    {
        try{
            $model = HutangPiutang::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
            if (empty($model)) return response()->json('Data tidak ditemukan', 400);

            $transaksi = HutangPiutangPembayaran::where('id_hutang_piutang', '=', $id)->count();
            if ($transaksi > 0) return response()->json('Data ini masih memiliki transaksi', 400);

            $pembayaran = HutangPiutangPembayaran::where('id_hutang_piutang', '=', $request->perusahaan->id)->count();
            if ($pembayaran > 0) response()->json('Sudah melakukan transaksi', 400);

            DB::beginTransaction();

            $rekening_old = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($model->id_rekening);
            if (empty($rekening_old)) return response()->json('Rekening tidak ditemukan', 400);
            if ($model->hutang){
                $rekening_old->saldo -= $model->nilai;
            }else{
                $rekening_old->saldo += $model->nilai;
            }
            if ($rekening_old->saldo < 0) return response()->json('Saldo kurang', 400);
            $rekening_old->save();

            $model->delete();

            DB::commit();
            return response()->json(['id' => $model->id], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }
}
