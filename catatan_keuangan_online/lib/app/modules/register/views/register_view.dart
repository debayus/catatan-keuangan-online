import 'package:catatan_keuangan_online/app/mahas/mahas_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../../mahas/components/mahas_themes.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MahasColors.primary,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding:
                const EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 20),
            decoration: MahasColors.decoration,
            child: Column(
              children: [
                Expanded(child: Container()),
                Text(
                  "Catatan Keuangan Online",
                  style: MahasThemes.h1,
                ),
                Expanded(child: Container()),
                const Center(
                  child: Text(
                    'Aplikasi ini dapat mencatat pengeluaran, pemasukan, hutang dan piutang.\n\n'
                    'Kelola data keuangan dengan teman kamu hanya dengan memasukan email.\n\n'
                    'Lihat laporan keuangan dengan teman kamu dengan mudah.\n\n'
                    'Klik Lanjutkan untuk memulai data baru',
                    textAlign: TextAlign.justify,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(),
                ),
                ElevatedButton(
                  onPressed: controller.lanjutkanOnPress,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Lanjutkan"),
                      Padding(padding: EdgeInsets.all(2.5)),
                      Icon(
                        FontAwesomeIcons.chevronRight,
                        size: 14,
                      )
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.all(2.5)),
                TextButton(
                  onPressed: controller.kembaliOnPress,
                  child: const Text("Kembali"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
