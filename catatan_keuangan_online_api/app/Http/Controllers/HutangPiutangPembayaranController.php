<?php

namespace App\Http\Controllers;

use App\Models\HutangPiutang;
use App\Models\HutangPiutangPembayaran;
use App\Models\HutangPiutangPembayaranPembayaran;
use App\Models\Rekening;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class HutangPiutangPembayaranController extends Controller
{
    public function index(Request $request)
    {
        try{
            $query = HutangPiutangPembayaran::where('hutang_piutang_pembayarans.id_perusahaan', '=', $request->perusahaan->id)
            ->leftJoin('rekenings', 'rekenings.id', 'hutang_piutang_pembayarans.id_rekening')
            ->select(
                'hutang_piutang_pembayarans.*',
                'rekenings.nama as id_rekening_nama'
            );
            $query = $query->where('id_hutang_piutang', '=', $request->id_hutang_piutang);
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

            $hutangPiutang = HutangPiutang::where('id_perusahaan', '=', $request->perusahaan->id)->find($request->id_hutang_piutang);
            if (empty($hutangPiutang)) return response()->json('Rekening tidak ditemukan', 400);
            $hutangPiutang->dibayar += $request->nilai;
            $hutangPiutang->save();

            if ($hutangPiutang->hutang){
                $rekening->saldo -= $request->nilai;
            }else{
                $rekening->saldo += $request->nilai;
            }
            if ($rekening->saldo < 0) return response()->json('Saldo kurang', 400);
            $rekening->save();

            $model = new HutangPiutangPembayaran;
            $model->id_perusahaan = $request->perusahaan->id;
            $model->id_hutang_piutang = $hutangPiutang->id;
            $model->id_user_create = $request->user->id;
            $model->id_rekening = $request->id_rekening;
            $model->tanggal = $request->tanggal;
            $model->nilai = $request->nilai;
            $model->catatan = $request->catatan;
            $model->save();

            DB::commit();
            return response()->json(['id' => $model->id], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }

    public function show(Request $request, $id)
    {
        try{
            $model = HutangPiutangPembayaran::where('hutang_piutang_pembayarans.id_perusahaan', '=', $request->perusahaan->id)
            ->leftJoin('rekenings', 'rekenings.id', 'hutang_piutang_pembayarans.id_rekening')
            ->select(
                'hutang_piutang_pembayarans.*',
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
            $model = HutangPiutangPembayaran::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
            if (empty($model)) return response()->json('Data tidak ditemukan', 400);

            DB::beginTransaction();

            $hutangPiutang = HutangPiutang::where('id_perusahaan', '=', $request->perusahaan->id)->find($model->id_hutang_piutang);
            if (empty($hutangPiutang)) return response()->json('Rekening tidak ditemukan', 400);
            $hutangPiutang->dibayar -= $model->nilai;
            $hutangPiutang->dibayar += $request->nilai;
            $hutangPiutang->save();

            $rekening_old = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($model->id_rekening);
            if (empty($rekening_old)) return response()->json('Rekening tidak ditemukan', 400);
            if ($hutangPiutang->hutang){
                $rekening_old->saldo += $model->nilai;
            }else{
                $rekening_old->saldo -= $model->nilai;
            }
            if ($rekening_old->saldo < 0) return response()->json('Saldo kurang', 400);
            $rekening_old->save();

            $rekening = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($request->id_rekening);
            if (empty($rekening)) return response()->json('Rekening tidak ditemukan', 400);
            if ($hutangPiutang->hutang){
                $rekening->saldo -= $request->nilai;
            }else{
                $rekening->saldo += $request->nilai;
            }
            if ($rekening->saldo < 0) return response()->json('Saldo kurang', 400);
            $rekening->save();

            $model->id_rekening = $request->id_rekening;
            $model->tanggal = $request->tanggal;
            $model->nilai = $request->nilai;
            $model->catatan = $request->catatan;
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
            $model = HutangPiutangPembayaran::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
            if (empty($model)) return response()->json('Data tidak ditemukan', 400);

            DB::beginTransaction();

            $hutangPiutang = HutangPiutang::where('id_perusahaan', '=', $request->perusahaan->id)->find($model->id_hutang_piutang);
            if (empty($hutangPiutang)) return response()->json('Rekening tidak ditemukan', 400);
            $hutangPiutang->dibayar -= $model->nilai;
            $hutangPiutang->save();

            $rekening_old = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($model->id_rekening);
            if (empty($rekening_old)) return response()->json('Rekening tidak ditemukan', 400);
            if ($hutangPiutang->hutang){
                $rekening_old->saldo += $model->nilai;
            }else{
                $rekening_old->saldo -= $model->nilai;
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
