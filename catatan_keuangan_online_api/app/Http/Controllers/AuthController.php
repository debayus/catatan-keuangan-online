<?php

namespace App\Http\Controllers;

use App\Models\JenisPengeluaranPemasukan;
use App\Models\Perusahaan;
use App\Models\Rekening;
use App\Models\User;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AuthController extends Controller
{
    public function index(Request $request)
    {
        try{
            return response()->json([
                'perusahaan' => $request->perusahaan->nama,
                'id' => $request->user->id,
                'nama' => $request->user->nama,
                'super_user' => $request->user->super_user
            ]);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }

    public function store(Request $request)
    {
        try{
            if (empty($request->perusahaan)){
                DB::beginTransaction();

                // create perusahan
                $perusahaan = new Perusahaan;
                $perusahaan->nama = $request->firebase_user->email;
                $perusahaan->save();

                // create user
                $user = new User;
                $user->id_firebase = $request->firebase_user->uid;
                $user->nama = $request->firebase_user->email;
                $user->email = $request->firebase_user->email;
                $user->super_user = true;
                $user->pemilik = true;
                $user->id_perusahaan = $perusahaan->id;
                $user->save();

                // rekening
                $rekenings = [
                    ['nama' => 'Bank', 'icon' => 'landmark' ],
                    ['nama' => 'Cash', 'icon' => 'moneyBill' ],
                ];
                for($i = 0; $i < count($rekenings); $i++){
                    $item = $rekenings[$i];
                    $rekening = new Rekening;
                    $rekening->id_perusahaan = $perusahaan->id;
                    $rekening->nama = $item['nama'];
                    $rekening->icon = $item['icon'];
                    $rekening->saldo = 1000000;
                    $rekening->save();
                }

                // pemasukan
                $jenis_pengeluaran_pemasukans = [
                    ['nama' => 'Gaji', 'icon' => 'sackDollar', 'pengeluaran' => false ],
                    ['nama' => 'Bonus', 'icon' => 'sackDollar', 'pengeluaran' => false ],
                    ['nama' => 'Makanan', 'icon' => 'utensils', 'pengeluaran' => true ],
                    ['nama' => 'Kendaraan', 'icon' => 'carSide', 'pengeluaran' => true ],
                    ['nama' => 'Pendidikan', 'icon' => 'userGraduate', 'pengeluaran' => true ],
                    ['nama' => 'Olahraga', 'icon' => 'dumbbell', 'pengeluaran' => true ],
                    ['nama' => 'Kesehanan', 'icon' => 'pills', 'pengeluaran' => true ],
                    ['nama' => 'Peliharaan', 'icon' => 'paw', 'pengeluaran' => true ],
                    ['nama' => 'Hobi', 'icon' => 'music', 'pengeluaran' => true ],
                ];
                for($i = 0; $i < count($jenis_pengeluaran_pemasukans); $i++){
                    $item = $jenis_pengeluaran_pemasukans[$i];
                    $jenis = new JenisPengeluaranPemasukan();
                    $jenis->id_perusahaan = $perusahaan->id;
                    $jenis->nama = $item['nama'];
                    $jenis->icon = $item['icon'];
                    $jenis->pengeluaran = $item['pengeluaran'];
                    $jenis->save();
                }

                DB::commit();
            }
            return response()->json(['success' => true], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }

    public function destroy(Request $request)
    {
        try{
            // update user
            $user = User::find($request->user->id);
            $user->email = null;
            $user->id_firebase = null;
            $user->save();

            return response()->json(['success' => true], 200);
        }catch(Exception $ex){
            return response()->json($ex->getMessage(), 400);
        }
    }
}
