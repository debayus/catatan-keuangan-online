import 'package:get/get.dart';

import '../modules/error/bindings/error_binding.dart';
import '../modules/error/views/error_view.dart';
import '../modules/grafik/bindings/grafik_binding.dart';
import '../modules/grafik/views/grafik_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/hutang_piutang/bindings/hutang_piutang_binding.dart';
import '../modules/hutang_piutang/views/hutang_piutang_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/pengaturan/bindings/pengaturan_binding.dart';
import '../modules/pengaturan/views/pengaturan_view.dart';
import '../modules/pengaturan_icon/bindings/pengaturan_icon_binding.dart';
import '../modules/pengaturan_icon/views/pengaturan_icon_view.dart';
import '../modules/pengaturan_jenis_pemasukan/bindings/pengaturan_jenis_pemasukan_binding.dart';
import '../modules/pengaturan_jenis_pemasukan/views/pengaturan_jenis_pemasukan_view.dart';
import '../modules/pengaturan_jenis_pengeluaran/bindings/pengaturan_jenis_pengeluaran_binding.dart';
import '../modules/pengaturan_jenis_pengeluaran/views/pengaturan_jenis_pengeluaran_view.dart';
import '../modules/pengaturan_rekening/bindings/pengaturan_rekening_binding.dart';
import '../modules/pengaturan_rekening/views/pengaturan_rekening_view.dart';
import '../modules/pengaturan_rekening_setup/bindings/pengaturan_rekening_setup_binding.dart';
import '../modules/pengaturan_rekening_setup/views/pengaturan_rekening_setup_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/trasaksi/bindings/trasaksi_binding.dart';
import '../modules/trasaksi/views/trasaksi_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ERROR,
      page: () => const ErrorView(),
      binding: ErrorBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.TRASAKSI,
      page: () => const TrasaksiView(),
      binding: TrasaksiBinding(),
    ),
    GetPage(
      name: _Paths.GRAFIK,
      page: () => const GrafikView(),
      binding: GrafikBinding(),
    ),
    GetPage(
      name: _Paths.HUTANG_PIUTANG,
      page: () => const HutangPiutangView(),
      binding: HutangPiutangBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN,
      page: () => const PengaturanView(),
      binding: PengaturanBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN_REKENING,
      page: () => const PengaturanRekeningView(),
      binding: PengaturanRekeningBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN_JENIS_PEMASUKAN,
      page: () => const PengaturanJenisPemasukanView(),
      binding: PengaturanJenisPemasukanBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN_JENIS_PENGELUARAN,
      page: () => const PengaturanJenisPengeluaranView(),
      binding: PengaturanJenisPengeluaranBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN_REKENING_SETUP,
      page: () => const PengaturanRekeningSetupView(),
      binding: PengaturanRekeningSetupBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN_ICON,
      page: () => const PengaturanIconView(),
      binding: PengaturanIconBinding(),
    ),
  ];
}
