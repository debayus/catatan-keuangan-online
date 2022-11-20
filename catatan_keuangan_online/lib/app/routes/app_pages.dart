import 'package:get/get.dart';

import '../modules/error/bindings/error_binding.dart';
import '../modules/error/views/error_view.dart';
import '../modules/grafik/bindings/grafik_binding.dart';
import '../modules/grafik/views/grafik_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/hutang_piutang/bindings/hutang_piutang_binding.dart';
import '../modules/hutang_piutang/views/hutang_piutang_view.dart';
import '../modules/hutang_piutang_pembayaran/bindings/hutang_piutang_pembayaran_binding.dart';
import '../modules/hutang_piutang_pembayaran/views/hutang_piutang_pembayaran_view.dart';
import '../modules/hutang_piutang_pembayaran_setup/bindings/hutang_piutang_pembayaran_setup_binding.dart';
import '../modules/hutang_piutang_pembayaran_setup/views/hutang_piutang_pembayaran_setup_view.dart';
import '../modules/hutang_piutang_setup/bindings/hutang_piutang_setup_binding.dart';
import '../modules/hutang_piutang_setup/views/hutang_piutang_setup_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/pengaturan/bindings/pengaturan_binding.dart';
import '../modules/pengaturan/views/pengaturan_view.dart';
import '../modules/pengaturan_icon/bindings/pengaturan_icon_binding.dart';
import '../modules/pengaturan_icon/views/pengaturan_icon_view.dart';
import '../modules/pengaturan_jenis_pemasukan/bindings/pengaturan_jenis_pemasukan_binding.dart';
import '../modules/pengaturan_jenis_pemasukan/views/pengaturan_jenis_pemasukan_view.dart';
import '../modules/pengaturan_jenis_pemasukan_setup/bindings/pengaturan_jenis_pemasukan_setup_binding.dart';
import '../modules/pengaturan_jenis_pemasukan_setup/views/pengaturan_jenis_pemasukan_setup_view.dart';
import '../modules/pengaturan_jenis_pengeluaran/bindings/pengaturan_jenis_pengeluaran_binding.dart';
import '../modules/pengaturan_jenis_pengeluaran/views/pengaturan_jenis_pengeluaran_view.dart';
import '../modules/pengaturan_jenis_pengeluaran_setup/bindings/pengaturan_jenis_pengeluaran_setup_binding.dart';
import '../modules/pengaturan_jenis_pengeluaran_setup/views/pengaturan_jenis_pengeluaran_setup_view.dart';
import '../modules/pengaturan_rekening/bindings/pengaturan_rekening_binding.dart';
import '../modules/pengaturan_rekening/views/pengaturan_rekening_view.dart';
import '../modules/pengaturan_rekening_setup/bindings/pengaturan_rekening_setup_binding.dart';
import '../modules/pengaturan_rekening_setup/views/pengaturan_rekening_setup_view.dart';
import '../modules/pengaturan_user/bindings/pengaturan_user_binding.dart';
import '../modules/pengaturan_user/views/pengaturan_user_view.dart';
import '../modules/pengaturan_user_setup/bindings/pengaturan_user_setup_binding.dart';
import '../modules/pengaturan_user_setup/views/pengaturan_user_setup_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/transaksi/bindings/transaksi_binding.dart';
import '../modules/transaksi/views/transaksi_view.dart';
import '../modules/transaksi_mutasi_rekening/bindings/transaksi_mutasi_rekening_binding.dart';
import '../modules/transaksi_mutasi_rekening/views/transaksi_mutasi_rekening_view.dart';
import '../modules/transaksi_setup/bindings/transaksi_setup_binding.dart';
import '../modules/transaksi_setup/views/transaksi_setup_view.dart';
import '../modules/xsample/bindings/xsample_binding.dart';
import '../modules/xsample/views/xsample_view.dart';
import '../modules/xsample_checkbox_radio/bindings/xsample_checkbox_radio_binding.dart';
import '../modules/xsample_checkbox_radio/views/xsample_checkbox_radio_view.dart';
import '../modules/xsample_date_time/bindings/xsample_date_time_binding.dart';
import '../modules/xsample_date_time/views/xsample_date_time_view.dart';
import '../modules/xsample_detail/bindings/xsample_detail_binding.dart';
import '../modules/xsample_detail/views/xsample_detail_view.dart';
import '../modules/xsample_dropdown/bindings/xsample_dropdown_binding.dart';
import '../modules/xsample_dropdown/views/xsample_dropdown_view.dart';
import '../modules/xsample_input/bindings/xsample_input_binding.dart';
import '../modules/xsample_input/views/xsample_input_view.dart';
import '../modules/xsample_list/bindings/xsample_list_binding.dart';
import '../modules/xsample_list/views/xsample_list_view.dart';
import '../modules/xsample_setup/bindings/xsample_setup_binding.dart';
import '../modules/xsample_setup/views/xsample_setup_view.dart';

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
      name: _Paths.PENGATURAN_JENIS_PENGELUARAN_SETUP,
      page: () => const PengaturanJenisPengeluaranSetupView(),
      binding: PengaturanJenisPengeluaranSetupBinding(),
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
    GetPage(
      name: _Paths.XSAMPLE,
      page: () => const XsampleView(),
      binding: XsampleBinding(),
    ),
    GetPage(
      name: _Paths.XSAMPLE_CHECKBOX_RADIO,
      page: () => const XsampleCheckboxRadioView(),
      binding: XsampleCheckboxRadioBinding(),
    ),
    GetPage(
      name: _Paths.XSAMPLE_DATE_TIME,
      page: () => const XsampleDateTimeView(),
      binding: XsampleDateTimeBinding(),
    ),
    GetPage(
      name: _Paths.XSAMPLE_DETAIL,
      page: () => const XsampleDetailView(),
      binding: XsampleDetailBinding(),
    ),
    GetPage(
      name: _Paths.XSAMPLE_DROPDOWN,
      page: () => const XsampleDropdownView(),
      binding: XsampleDropdownBinding(),
    ),
    GetPage(
      name: _Paths.XSAMPLE_INPUT,
      page: () => const XsampleInputView(),
      binding: XsampleInputBinding(),
    ),
    GetPage(
      name: _Paths.XSAMPLE_LIST,
      page: () => const XsampleListView(),
      binding: XsampleListBinding(),
    ),
    GetPage(
      name: _Paths.XSAMPLE_SETUP,
      page: () => const XsampleSetupView(),
      binding: XsampleSetupBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN_JENIS_PEMASUKAN_SETUP,
      page: () => const PengaturanJenisPemasukanSetupView(),
      binding: PengaturanJenisPemasukanSetupBinding(),
    ),
    GetPage(
      name: _Paths.TRANSAKSI,
      page: () => const TransaksiView(),
      binding: TransaksiBinding(),
    ),
    GetPage(
      name: _Paths.TRANSAKSI_SETUP,
      page: () => const TransaksiSetupView(),
      binding: TransaksiSetupBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN_USER,
      page: () => const PengaturanUserView(),
      binding: PengaturanUserBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN_USER_SETUP,
      page: () => const PengaturanUserSetupView(),
      binding: PengaturanUserSetupBinding(),
    ),
    GetPage(
      name: _Paths.TRANSAKSI_MUTASI_REKENING,
      page: () => const TransaksiMutasiRekeningView(),
      binding: TransaksiMutasiRekeningBinding(),
    ),
    GetPage(
      name: _Paths.HUTANG_PIUTANG_SETUP,
      page: () => const HutangPiutangSetupView(),
      binding: HutangPiutangSetupBinding(),
    ),
    GetPage(
      name: _Paths.HUTANG_PIUTANG_PEMBAYARAN,
      page: () => const HutangPiutangPembayaranView(),
      binding: HutangPiutangPembayaranBinding(),
    ),
    GetPage(
      name: _Paths.HUTANG_PIUTANG_PEMBAYARAN_SETUP,
      page: () => const HutangPiutangPembayaranSetupView(),
      binding: HutangPiutangPembayaranSetupBinding(),
    ),
  ];
}
