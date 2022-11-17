<?php

namespace App\Http\Controllers;

use App\Models\HutangPiutang;
use App\Models\HutangPiutangPembayaran;
use App\Models\PerusahaanUser;
use App\Models\Rekening;
use App\Models\User;
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
            $rekening = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($request->id_rekening);
            if (empty($rekening)) return response()->json('Rekening tidak ditemukan', 401);

            // check saldo
            $saldo = $rekening->saldo;
            if ($request->hutang){
                $saldo -= $request->nilai;
            }else{
                $saldo += $request->nilai;
            }
            if ($saldo < 0) return response()->json('Saldo kurang', 401);

            DB::beginTransaction();

            $model = new HutangPiutang;
            $model->id_perusahaan = $request->perusahaan->id;
            $model->id_user_create = $request->user->id;
            $model->id_rekening = $request->id_rekening;
            $model->tanggal = $request->tanggal;
            $model->tanggal_tempo = $request->tanggal_tempo;
            $model->nilai = $request->nilai;
            $model->catatan = $request->catatan;
            $model->hutang = $request->hutang;
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
            $model = HutangPiutang::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
            if (empty($model)) return response()->json('Data tidak ditemukan', 401);

            return response()->json($model, 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }

    public function update(Request $request, $id)
    {
        try{
            $model = HutangPiutang::where('id_perusahaan', '=', $request->perusahaan->id)->find($id);
            if (empty($model)) return response()->json('Data tidak ditemukan', 401);

            if ($model->nilai != $request->nilai){
                $rekening = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($model->id_rekening);
                if (empty($rekening)) return response()->json('Sudah melakukan transaksi, tidak dapat mengubah nilai', 401);
            }

            $rekening_old = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($model->id_rekening);
            if (empty($rekening)) return response()->json('Rekening tidak ditemukan', 401);

            $rekening;
            if ($model->id_rekening != $request->id_rekening){
                $rekening = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($request->id_rekening);
                if (empty($rekening)) return response()->json('Rekening tidak ditemukan', 401);
            }

            // check saldo old
            $saldo_new = null;
            $saldo_old = $rekening_old->saldo;
            if ($model->hutang){
                $saldo_old += $model->nilai;
            }else{
                $saldo_old -= $model->nilai;
            }
            if (empty($rekening)){
                if ($model->hutang){
                    $saldo_old -= $request->nilai;
                }else{
                    $saldo_old += $request->nilai;
                }
            }
            if ($saldo_old < 0) return response()->json('Saldo kurang', 401);

            if (!empty($rekening)){
                $saldo_new = $rekening->saldo;
                if ($model->hutang){
                    $saldo_new -= $request->nilai;
                }else{
                    $saldo_new += $request->nilai;
                }
            }

            DB::beginTransaction();

            $model->id_rekening = $request->id_rekening;
            $model->tanggal = $request->tanggal;
            $model->tanggal_tempo = $request->tanggal_tempo;
            $model->nilai = $request->nilai;
            $model->catatan = $request->catatan;
            $model->hutang = $request->hutang;
            $model->save();

            $rekening_old->saldo = $saldo_old;
            if (!empty($rekening)){
                $rekening->saldo = $saldo_new;
                $rekening->save();
            }

            $rekening_old->save();
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
            if (empty($model)) return response()->json('Data tidak ditemukan', 401);

            $pembayaran = HutangPiutangPembayaran::where('id_hutang_piutang', '=', $request->perusahaan->id)->count();
            if ($pembayaran > 0) response()->json('Sudah melakukan transaksi', 401);

            $rekening = Rekening::where('id_perusahaan', '=', $request->perusahaan->id)->find($model->id_rekening);
            if (empty($rekening)) return response()->json('Sudah melakukan transaksi', 401);

            // check saldo
            $saldo = $rekening->saldo;
            if ($request->hutang){
                $saldo += $request->nilai;
            }else{
                $saldo -= $request->nilai;
            }
            if ($saldo < 0) return response()->json('Saldo kurang', 401);

            DB::beginTransaction();

            $model->delete();

            $rekening->saldo = $saldo;
            $rekening->save();

            DB::commit();
            return response()->json(['id' => $model->id], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }

    public function user(Request $request)
    {
        try{
            $query = PerusahaanUser::where('id_perusahaan', '=', $request->perusahaan->id)
            ->join('users', 'users.id', '=', 'perusahaan_users.id_user')
            ->select(
                'perusahaan_users.id',
                'users.nama'
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
}
