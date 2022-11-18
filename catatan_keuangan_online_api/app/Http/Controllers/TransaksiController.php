<?php

namespace App\Http\Controllers;

use App\Models\HutangPiutang;
use App\Models\JenisPengeluaranPemasukan;
use App\Models\MutasiRekening;
use App\Models\PengeluaranPemasukan;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TransaksiController extends Controller
{
    public function index(Request $request)
    {
        try{
            $hutang_piutang = HutangPiutang::where('hutang_piutangs.id_perusahaan', '=', $request->perusahaan->id)
            ->select(
                'hutang_piutangs.id',
                'hutang_piutangs.tanggal',
                'hutang_piutangs.nilai',
                'hutang_piutangs.catatan',
                'hutang_piutangs.catatan as jenis',
                DB::raw('CASE WHEN hutang_piutangs.hutang = 1 THEN "Hutang" ELSE "Piutang" END as tipe'),
            );

            $mutasi_rekening = MutasiRekening::where('id_perusahaan', '=', $request->perusahaan->id)
            ->select(
                'id',
                'tanggal',
                'nilai',
                'catatan',
                DB::raw('"Mutasi Rekening" as jenis'),
                DB::raw('"Mutasi Rekening" as tipe'),
            );

            $query = PengeluaranPemasukan::where('pengeluaran_pemasukans.id_perusahaan', '=', $request->perusahaan->id)
            ->join('jenis_pengeluaran_pemasukans', 'jenis_pengeluaran_pemasukans.id', '=', 'pengeluaran_pemasukans.id_jenis_pengeluaran_pemasukan')
            ->select(
                'pengeluaran_pemasukans.id',
                'pengeluaran_pemasukans.tanggal',
                'pengeluaran_pemasukans.nilai',
                'pengeluaran_pemasukans.catatan',
                'jenis_pengeluaran_pemasukans.nama as jenis',
                DB::raw('CASE WHEN pengeluaran_pemasukans.pengeluaran = 1 THEN "Pengeluaran" ELSE "Pemasukan" END as tipe'),
            )
            ->union($hutang_piutang)
            ->union($mutasi_rekening);

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
