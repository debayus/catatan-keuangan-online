<?php

namespace App\Http\Controllers;

use App\Models\PengeluaranPemasukan;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class GrafikController extends Controller
{
    public function pengeluaran_pemasukan(Request $request)
    {
        try{
            $periode_dari = $request->dari_tanggal;
            $periode_sampai = $request->sampai_tanggal;

            $pie_pengeluaran = PengeluaranPemasukan::where('pengeluaran_pemasukans.id_perusahaan', '=', $request->perusahaan->id)
            ->join('jenis_pengeluaran_pemasukans', 'jenis_pengeluaran_pemasukans.id', 'pengeluaran_pemasukans.id_jenis_pengeluaran_pemasukan')
            ->whereRaw('DATE(pengeluaran_pemasukans.tanggal) >= ?', [$periode_dari])
            ->whereRaw('DATE(pengeluaran_pemasukans.tanggal) <= ?', [$periode_sampai])
            ->where('pengeluaran_pemasukans.pengeluaran', '=', 1)
            ->select(
                'jenis_pengeluaran_pemasukans.id',
                'jenis_pengeluaran_pemasukans.nama',
                DB::raw('sum(pengeluaran_pemasukans.nilai) as nilai')
            )
            ->groupBy(
                'jenis_pengeluaran_pemasukans.id',
                'jenis_pengeluaran_pemasukans.nama',
            )
            ->get();

            $pie_pemasukan = PengeluaranPemasukan::where('pengeluaran_pemasukans.id_perusahaan', '=', $request->perusahaan->id)
            ->join('jenis_pengeluaran_pemasukans', 'jenis_pengeluaran_pemasukans.id', 'pengeluaran_pemasukans.id_jenis_pengeluaran_pemasukan')
            ->whereRaw('DATE(pengeluaran_pemasukans.tanggal) >= ?', [$periode_dari])
            ->whereRaw('DATE(pengeluaran_pemasukans.tanggal) <= ?', [$periode_sampai])
            ->where('pengeluaran_pemasukans.pengeluaran', '=', 0)
            ->select(
                'jenis_pengeluaran_pemasukans.id',
                'jenis_pengeluaran_pemasukans.nama',
                DB::raw('sum(pengeluaran_pemasukans.nilai) as nilai')
            )
            ->groupBy(
                'jenis_pengeluaran_pemasukans.id',
                'jenis_pengeluaran_pemasukans.nama',
            )
            ->get();

            $line_pengeluaran = PengeluaranPemasukan::where('pengeluaran_pemasukans.id_perusahaan', '=', $request->perusahaan->id)
            ->join('jenis_pengeluaran_pemasukans', 'jenis_pengeluaran_pemasukans.id', 'pengeluaran_pemasukans.id_jenis_pengeluaran_pemasukan')
            ->whereRaw('DATE(pengeluaran_pemasukans.tanggal) >= ?', [$periode_dari])
            ->whereRaw('DATE(pengeluaran_pemasukans.tanggal) <= ?', [$periode_sampai])
            ->where('pengeluaran_pemasukans.pengeluaran', '=', true)
            ->select(
                'pengeluaran_pemasukans.tanggal',
                DB::raw('sum(pengeluaran_pemasukans.nilai) as nilai')
            )
            ->groupBy(
                'pengeluaran_pemasukans.tanggal',
            )
            ->get();

            $line_pemasukan = PengeluaranPemasukan::where('pengeluaran_pemasukans.id_perusahaan', '=', $request->perusahaan->id)
            ->join('jenis_pengeluaran_pemasukans', 'jenis_pengeluaran_pemasukans.id', 'pengeluaran_pemasukans.id_jenis_pengeluaran_pemasukan')
            ->whereRaw('DATE(pengeluaran_pemasukans.tanggal) >= ?', [$periode_dari])
            ->whereRaw('DATE(pengeluaran_pemasukans.tanggal) <= ?', [$periode_sampai])
            ->where('pengeluaran_pemasukans.pengeluaran', '=', false)
            ->select(
                'pengeluaran_pemasukans.tanggal',
                DB::raw('sum(pengeluaran_pemasukans.nilai) as nilai')
            )
            ->groupBy(
                'pengeluaran_pemasukans.tanggal',
            )
            ->get();

            return response()->json([
                'pie_pengeluaran' => $pie_pengeluaran,
                'pie_pemasukan' => $pie_pemasukan,
                'line_pengeluaran' => $line_pengeluaran,
                'line_pemasukan' => $line_pemasukan,
            ]);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }
}
