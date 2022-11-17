import 'package:catatan_keuangan_online/app/models/rekening_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../mahas/components/inputs/input_datetime_component.dart';
import '../../../mahas/components/inputs/input_lookup_component.dart';
import '../../../mahas/components/inputs/input_radio_component.dart';
import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/components/pages/setup_page_component.dart';
import '../controllers/transaksi_setup_controller.dart';

class TransaksiSetupView extends GetView<TransaksiSetupController> {
  const TransaksiSetupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SetupPageComponent(
      controller: controller.formCon,
      title: 'Transaksi',
      children: () => [
        InputLookupComponent<RekeningModel>(
          controller: controller.userCon,
          editable: controller.formCon.editable,
          required: true,
          label: 'User',
        ),
        InputRadioComponent(
          controller: controller.tipeCon,
          editable: controller.formCon.editable,
          required: true,
          label: 'Tipe',
        ),
        InputLookupComponent<RekeningModel>(
          controller: controller.jenisCon,
          editable: controller.formCon.editable,
          required: true,
          label: 'Jenis',
        ),
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
        InputLookupComponent<RekeningModel>(
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
