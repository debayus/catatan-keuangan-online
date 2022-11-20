import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../mahas/components/inputs/input_datetime_component.dart';
import '../../../mahas/components/inputs/input_lookup_component.dart';
import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/components/pages/setup_page_component.dart';
import '../controllers/hutang_piutang_pembayaran_setup_controller.dart';

class HutangPiutangPembayaranSetupView
    extends GetView<HutangPiutangPembayaranSetupController> {
  const HutangPiutangPembayaranSetupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SetupPageComponent(
      controller: controller.formCon,
      title: 'Pembayaran',
      children: () => [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: InputDatetimeComponent(
                controller: controller.tanggalCon,
                editable: controller.formCon.editable,
                required: true,
                label: 'Tanggal',
              ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Expanded(
              child: InputDatetimeComponent(
                controller: controller.jamCon,
                editable: controller.formCon.editable,
                required: true,
                type: InputDatetimeType.time,
                label: 'Jam',
              ),
            ),
          ],
        ),
        InputLookupComponent(
          controller: controller.rekeningCon,
          editable: controller.formCon.editable,
          required: true,
          label: 'Rekening',
        ),
        InputTextComponent(
          label: 'Nilai',
          required: true,
          controller: controller.nilaiCon,
          editable: controller.formCon.editable,
        ),
        InputTextComponent(
          label: 'Catatan',
          controller: controller.catatanCon,
          editable: controller.formCon.editable,
        ),
      ],
    );
  }
}
