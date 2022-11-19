import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../mahas/components/inputs/input_datetime_component.dart';
import '../../../mahas/components/inputs/input_lookup_component.dart';
import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/components/pages/setup_page_component.dart';
import '../controllers/transaksi_mutasi_rekening_controller.dart';

class TransaksiMutasiRekeningView
    extends GetView<TransaksiMutasiRekeningController> {
  const TransaksiMutasiRekeningView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SetupPageComponent(
      controller: controller.formCon,
      title: 'Mutasi Rekening',
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
          controller: controller.rekeningDariCon,
          editable: controller.formCon.editable,
          required: true,
          label: 'Rekening Dari',
        ),
        InputLookupComponent(
          controller: controller.rekeningTujuanCon,
          editable: controller.formCon.editable,
          required: true,
          label: 'Rekening Tujuan',
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
