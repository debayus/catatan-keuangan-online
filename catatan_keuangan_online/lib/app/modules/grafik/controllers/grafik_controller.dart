import 'dart:convert';
import 'package:catatan_keuangan_online/app/mahas/components/chart/line_chart_component.dart';
import 'package:catatan_keuangan_online/app/mahas/mahas_colors.dart';
import 'package:catatan_keuangan_online/app/mahas/services/helper.dart';
import 'package:catatan_keuangan_online/app/mahas/services/http_api.dart';
import 'package:catatan_keuangan_online/app/mahas/services/mahas_format.dart';
import 'package:catatan_keuangan_online/app/models/grafik_item_model.dart';
import 'package:get/get.dart';
import '../../../mahas/components/chart/pie_chart_component.dart';
import '../../../mahas/components/inputs/input_datetime_component.dart';
import '../../../mahas/components/inputs/input_dropdown_component.dart';

class GrafikController extends GetxController {
  var isRefresh = false.obs;
  late InputDatetimeController tanggalCon;
  late InputDropdownController periodeCon;

  RxList<PieChartItem> piePengeluaran = <PieChartItem>[].obs;
  RxList<PieChartItem> piePemasukan = <PieChartItem>[].obs;
  RxList<LineChartItem> linePemasukan = <LineChartItem>[].obs;
  RxList<LineChartItem> linePengeluaran = <LineChartItem>[].obs;

  Future refreshData({bool isOnInit = false}) async {
    if (isRefresh.isTrue) return;
    if (!isOnInit) {
      if (!tanggalCon.isValid) return;
      if (!periodeCon.isValid) return;
    }
    isRefresh.value = true;
    DateTime sampaiTanggal = isOnInit ? DateTime.now() : tanggalCon.value;
    DateTime dariTanggal = DateTime(sampaiTanggal.year,
        sampaiTanggal.month - (periodeCon.value as int), sampaiTanggal.day);
    var r = await HttpApi.get(
        '/api/grafik/pengeluaranpemasukan?dari_tanggal=${MahasFormat.dateToString(dariTanggal)}&sampai_tanggal=${MahasFormat.dateToString(sampaiTanggal)}');
    if (r.success) {
      var jsonData = json.decode(r.body);

      // pie pengeluaran
      piePengeluaran.clear();
      var index = 0;
      for (var item in jsonData['pie_pengeluaran']) {
        var data = GrafikPieItemModel.fromDynamic(item);
        piePengeluaran.add(PieChartItem(
          value: data.nilai!,
          text: data.nama!,
          color: MahasColors.grafikColors[index],
        ));
        index++;
        if (index >= MahasColors.grafikColors.length) {
          index = 0;
        }
      }

      // pie pemasukan
      piePemasukan.clear();
      for (var item in jsonData['pie_pemasukan']) {
        var data = GrafikPieItemModel.fromDynamic(item);
        piePemasukan.add(PieChartItem(
          value: data.nilai!,
          text: data.nama!,
          color: MahasColors.grafikColors[index],
        ));
        index++;
        if (index >= MahasColors.grafikColors.length) {
          index = 0;
        }
      }

      // line pengeluaran
      linePengeluaran.clear();
      for (var i = 0; i < jsonData['line_pengeluaran'].length; i++) {
        var data =
            GrafikLineItemModel.fromDynamic(jsonData['line_pengeluaran'][i]);
        linePengeluaran.add(LineChartItem(
          value: data.nilai!,
          x: i.toDouble(),
          color: MahasColors.grafikColors[index],
        ));
        index++;
        if (index >= MahasColors.grafikColors.length) {
          index = 0;
        }
      }

      // line pemasukan
      linePemasukan.clear();
      for (var i = 0; i < jsonData['line_pemasukan'].length; i++) {
        var data =
            GrafikLineItemModel.fromDynamic(jsonData['line_pemasukan'][i]);
        linePemasukan.add(LineChartItem(
          value: data.nilai!,
          x: i.toDouble(),
          color: MahasColors.grafikColors[index],
        ));
        index++;
        if (index >= MahasColors.grafikColors.length) {
          index = 0;
        }
      }
    } else {
      Helper.dialogWarning(r.message);
    }
    isRefresh.value = false;
  }

  @override
  void onInit() {
    super.onInit();

    tanggalCon = InputDatetimeController(
      onChanged: () {
        refreshData();
      },
    );
    periodeCon = InputDropdownController(
      items: [
        DropdownItem.init("1 Bulan", 1),
        DropdownItem.init("6 Bulan", 6),
        DropdownItem.init("12 Bulan", 12),
      ],
      onChanged: (val) {
        refreshData();
      },
    );

    tanggalCon.value = DateTime.now();
    periodeCon.value = 1;
    // refreshData(isOnInit: true);
  }
}
