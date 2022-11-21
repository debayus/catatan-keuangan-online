import 'package:catatan_keuangan_online/app/mahas/components/inputs/input_dropdown_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../mahas/components/inputs/input_datetime_component.dart';
import '../../../mahas/components/inputs/input_lookup_component.dart';
import '../controllers/transaksi_filter_controller.dart';

class TransaksiFilterView extends GetView<TransaksiFilterController> {
  const TransaksiFilterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InputDatetimeComponent(
                controller: controller.dariTanggalCon,
                label: 'Dari Tanggal',
              ),
              InputDatetimeComponent(
                controller: controller.sampaiTanggalCon,
                label: 'Smapai Tanggal',
              ),
              InputLookupComponent(
                controller: controller.rekeningCon,
                label: 'Rekening',
              ),
              InputDropdownComponent(
                controller: controller.tipeCon,
                label: 'Tipe',
              ),
              Obx(
                () => Visibility(
                  visible: controller.showJenis.value,
                  child: InputLookupComponent(
                    controller: controller.jenisCon,
                    label: 'Jenis',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: controller.cariOnPress,
                child: const Text("Cari"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
