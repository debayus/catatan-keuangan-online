<?php

namespace App\Http\Controllers;

use App\Models\HutangPiutang;
use App\Models\JenisPengeluaranPemasukan;
use App\Models\PengeluaranPemasukan;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TransaksiController extends Controller
{
    public function index(Request $request)
    {
        try{
            $hutangPiutang = HutangPiutang::where('id_perusahaan', '=', $request->perusahaan->id)
            ->join('rekenings', 'rekenings.id', '=', 'hutangpiutangs.id_rekening')
            ->select(
                'hutangpiutangs.id_rekening',
                'hutangpiutangs.tanggal',
                'hutangpiutangs.nilai',
                'hutangpiutangs.catatan',
                'CASE WHEN hutangpiutangs.hutang = 1 THEN "Hutang" ELSE "Piutang" END as jenis',
                'rekenings.nama as rekenings_nama'
            );

            $query = PengeluaranPemasukan::where('id_perusahaan', '=', $request->perusahaan->id)
            ->join('rekenings', 'rekenings.id', '=', 'pengeluaranpemasukans.id_rekening')
            ->select(
                'pengeluaranpemasukans.id_rekening',
                'pengeluaranpemasukans.tanggal',
                'pengeluaranpemasukans.nilai',
                'pengeluaranpemasukans.catatan',
                'CASE WHEN pengeluaranpemasukans.pengeluaran = 1 THEN "Pengeluaran" ELSE "Pemasukan" END as jenis',
                'rekenings.nama as rekenings_nama'
            )
            ->union($hutangPiutang);

            if (isset($request->filtertanggal)){
                $query = $query->where('tanggal', '=', $request->filtertanggal);
            }
            if (isset($request->filterjenis)){
                $query = $query->where('jenis', '=', $request->filterjenis);
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
