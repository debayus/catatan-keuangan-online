import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../../mahas/components/mahas_themes.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          decoration: MahasThemes.decoration,
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
                  'Lihat dan bagikan laporan keuangan kamu dengan mudah.\n\n'
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
              InkWell(
                onTap: controller.kembaliOnTab,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text("Kembali"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
