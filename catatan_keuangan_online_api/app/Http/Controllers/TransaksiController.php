<?php

namespace App\Http\Controllers;

use App\Models\HutangPiutang;
use App\Models\HutangPiutangPembayaran;
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
            $tipe = $request->tipe;

            $hutang_piutang = HutangPiutang::where('hutang_piutangs.id_perusahaan', '=', $request->perusahaan->id)
            ->select(
                'hutang_piutangs.id',
                'hutang_piutangs.tanggal',
                'hutang_piutangs.nilai',
                'hutang_piutangs.catatan',
                DB::raw('CASE WHEN hutang_piutangs.hutang = 1 THEN "Hutang" ELSE "Piutang" END as jenis'),
                DB::raw('"Hutang Piutang" as tipe'),
            );
            if (isset($request->dari_tanggal)){
                $hutang_piutang = $hutang_piutang->whereRaw('DATE(hutang_piutangs.tanggal) >= ?', [$request->dari_tanggal]);
            }
            if (isset($request->sampai_tanggal)){
                $hutang_piutang = $hutang_piutang->whereRaw('DATE(hutang_piutangs.tanggal) <= ?', [$request->sampai_tanggal]);
            }
            if (isset($request->rekening)){
                $hutang_piutang = $hutang_piutang->where('hutang_piutangs.id_rekening', '=', $request->rekening);
            }
            if (isset($tipe)){
                $hutang_piutang = $hutang_piutang->where('hutang_piutangs.hutang', '=', $tipe == 'Hutang');
            }

            $hutang_piutang_pembayaran = HutangPiutangPembayaran::where('hutang_piutang_pembayarans.id_perusahaan', '=', $request->perusahaan->id)
            ->join('hutang_piutangs', 'hutang_piutangs.id', '=', 'hutang_piutang_pembayarans.id_hutang_piutang')
            ->select(
                'hutang_piutang_pembayarans.id',
                'hutang_piutang_pembayarans.tanggal',
                'hutang_piutang_pembayarans.nilai',
                'hutang_piutang_pembayarans.catatan',
                DB::raw('CASE WHEN hutang_piutangs.hutang = 1 THEN "Pembayaran Hutang" ELSE "Pembayaran Piutang" END as jenis'),
                DB::raw('"Pembayaran Hutang Piutang" as tipe'),
            );
            if (isset($request->dari_tanggal)){
                $hutang_piutang_pembayaran = $hutang_piutang_pembayaran->whereRaw('DATE(hutang_piutang_pembayarans.tanggal) >= ?', [$request->dari_tanggal]);
            }
            if (isset($request->sampai_tanggal)){
                $hutang_piutang_pembayaran = $hutang_piutang_pembayaran->whereRaw('DATE(hutang_piutang_pembayarans.tanggal) <= ?', [$request->sampai_tanggal]);
            }
            if (isset($request->rekening)){
                $hutang_piutang_pembayaran = $hutang_piutang_pembayaran->where('hutang_piutang_pembayarans.id_rekening', '=', $request->rekening);
            }
            if (isset($tipe)){
                $hutang_piutang_pembayaran = $hutang_piutang_pembayaran->where('hutang_piutangs.hutang', '=', $tipe == 'Hutang');
            }

            $mutasi_rekening = MutasiRekening::where('id_perusahaan', '=', $request->perusahaan->id)
            ->select(
                'id',
                'tanggal',
                'nilai',
                'catatan',
                DB::raw('"Mutasi Rekening" as jenis'),
                DB::raw('"Mutasi Rekening" as tipe'),
            );
            if (isset($request->dari_tanggal)){
                $mutasi_rekening = $mutasi_rekening->whereRaw('DATE(mutasi_rekenings.tanggal) >= ?', [$request->dari_tanggal]);
            }
            if (isset($request->sampai_tanggal)){
                $mutasi_rekening = $mutasi_rekening->whereRaw('DATE(mutasi_rekenings.tanggal) <= ?', [$request->sampai_tanggal]);
            }
            if (isset($request->rekening)){
                $mutasi_rekening = $mutasi_rekening->where(function ($_query) use ($request){
                    $_query->where('mutasi_rekenings.id_rekening_dari', '=', $request->rekening)
                    ->orWhere('mutasi_rekenings.id_rekening_tujuan', '=', $request->rekening);
                });
            }

            $pengeluaran_pemasukan = PengeluaranPemasukan::where('pengeluaran_pemasukans.id_perusahaan', '=', $request->perusahaan->id)
            ->join('jenis_pengeluaran_pemasukans', 'jenis_pengeluaran_pemasukans.id', '=', 'pengeluaran_pemasukans.id_jenis_pengeluaran_pemasukan')
            ->select(
                'pengeluaran_pemasukans.id',
                'pengeluaran_pemasukans.tanggal',
                'pengeluaran_pemasukans.nilai',
                'pengeluaran_pemasukans.catatan',
                'jenis_pengeluaran_pemasukans.nama as jenis',
                DB::raw('CASE WHEN pengeluaran_pemasukans.pengeluaran = 1 THEN "Pengeluaran" ELSE "Pemasukan" END as tipe'),
            );
            if (isset($request->dari_tanggal)){
                $pengeluaran_pemasukan = $pengeluaran_pemasukan->whereRaw('DATE(pengeluaran_pemasukans.tanggal) >= ?', [$request->dari_tanggal]);
            }
            if (isset($request->sampai_tanggal)){
                $pengeluaran_pemasukan = $pengeluaran_pemasukan->whereRaw('DATE(pengeluaran_pemasukans.tanggal) <= ?', [$request->sampai_tanggal]);
            }
            if (isset($request->rekening)){
                $pengeluaran_pemasukan = $pengeluaran_pemasukan->where('pengeluaran_pemasukans.id_rekening', '=', $request->rekening);
            }
            if (isset($request->jenis)){
                $pengeluaran_pemasukan = $pengeluaran_pemasukan->where('pengeluaran_pemasukans.id_jenis_pengeluaran_pemasukan', '=', $request->jenis);
            }
            if (isset($tipe)){
                $pengeluaran_pemasukan = $pengeluaran_pemasukan->where('pengeluaran_pemasukans.pengeluaran', '=', $tipe == 'Pengeluaran');
            }

            $query = null;
            if ($tipe == "Pemasukan" || $tipe == "Pengeluaran"){
                $query = $pengeluaran_pemasukan;
            } else if ($tipe == "Hutang" || $tipe == "Piutang"){
                $query = $hutang_piutang
                ->union($hutang_piutang_pembayaran);
            }else if ($tipe == "Mutasi Rekening"){
                $query = $mutasi_rekening;
            }else{
                $query = $pengeluaran_pemasukan
                ->union($hutang_piutang)
                ->union($mutasi_rekening)
                ->union($hutang_piutang_pembayaran);
            }

            $totalRowCount = $query->count();
            $models = $query->orderBy('tanggal', 'DESC')->simplePaginate(30);

            return response()->json([
                'data' => $models,
                'totalRowCount' => $totalRowCount
            ]);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }
}
