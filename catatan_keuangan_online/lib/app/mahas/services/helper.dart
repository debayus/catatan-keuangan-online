import 'package:catatan_keuangan_online/app/mahas/components/mahas_colors.dart';
import 'package:catatan_keuangan_online/app/mahas/components/mahas_themes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class Helper {
  static Future<bool?> dialogQuestion({
    String? message,
    IconData? icon,
    String? textConfirm,
    String? textCancel,
    Color? color,
  }) async {
    return await Get.dialog<bool?>(
      AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(MahasThemes.borderRadius))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? FontAwesomeIcons.question,
              color: color ?? MahasColors.blue,
              size: 40,
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Text(
              message ?? "",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        contentPadding:
            const EdgeInsets.only(bottom: 0, top: 20, right: 20, left: 20),
        actionsPadding:
            const EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 20),
        actions: [
          TextButton(
            child: Text(
              textCancel ?? "Close",
              style: const TextStyle(
                color: MahasColors.grey,
              ),
            ),
            onPressed: () {
              Get.back(result: false);
            },
          ),
          TextButton(
            child: Text(
              textConfirm ?? "OK",
              style: TextStyle(
                color: color ?? MahasColors.blue,
              ),
            ),
            onPressed: () {
              Get.back(result: true);
            },
          ),
        ],
      ),
    );
  }

  static Future dialogWarning(String? message) async {
    await Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              FontAwesomeIcons.triangleExclamation,
              color: MahasColors.yellow,
              size: 40,
            ),
            const Padding(padding: EdgeInsets.all(7)),
            Text(
              message ?? "-",
              maxLines: 2,
              style: const TextStyle(
                color: MahasColors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void backOnPress({
    dynamic result,
    bool questionBack = true,
    bool editable = false,
    dynamic parametes,
  }) async {
    if (questionBack && editable) {
      final r = await Helper.dialogQuestion(
        message: 'Anda yakin ingin kembali ?',
        textConfirm: 'Ya',
      );
      if (r != true) return;
    }
    Get.back(result: result);
  }

  static String idGenerator() {
    const uuid = Uuid();
    var r = uuid.v4();
    return r;
  }
}
