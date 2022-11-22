import 'package:catatan_keuangan_online/app/mahas/components/inputs/input_dropdown_component.dart';
import 'package:catatan_keuangan_online/app/mahas/components/others/shimmer_component.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../mahas/components/chart/line_chart_component.dart';
import '../../../mahas/components/chart/pie_chart_component.dart';
import '../../../mahas/components/inputs/input_datetime_component.dart';
import '../controllers/grafik_controller.dart';

class GrafikView extends GetView<GrafikController> {
  const GrafikView({
    Key? key,
    GrafikController? controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grafik'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshData,
        child: Obx(
          () => controller.isRefresh.isTrue
              ? const ShimmerComponent()
              : SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                child: InputDatetimeComponent(
                                  controller: controller.tanggalCon,
                                  required: true,
                                  label: 'Tanggal',
                                ),
                              ),
                              const Padding(padding: EdgeInsets.all(5)),
                              Expanded(
                                child: InputDropdownComponent(
                                  controller: controller.periodeCon,
                                  required: true,
                                  label: 'Periode Kebelakang',
                                ),
                              ),
                            ],
                          ),
                        ),
                        PieChartComponent(
                          title: "Pengeluaran",
                          data: controller.piePengeluaran,
                        ),
                        LineChartComponent(
                          title: "Pengeluaran",
                          data: controller.linePengeluaran,
                        ),
                        PieChartComponent(
                          title: "Pemasukan",
                          data: controller.piePemasukan,
                        ),
                        // LineChartComponent(
                        //   title: "Pemasukan",
                        //   data: controller.linePemasukan,
                        // ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
