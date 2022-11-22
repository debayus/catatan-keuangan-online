import 'models/profile_model.dart';

class MahasConfig {
  static ProfileModel? profile;
  static String urlApi = 'http://192.168.1.8:8000';
  static bool isLaravelBackend = true;

  static bool refreshListTransaksi = false;
  static bool refreshListHutangPiutang = true;
  static bool refreshGrafik = true;
}
