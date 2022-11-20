import 'package:catatan_keuangan_online/app/mahas/components/mahas_themes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../mahas/components/others/list_component.dart';
import '../../../mahas/mahas_config.dart';
import '../../../mahas/services/mahas_format.dart';
import '../../../models/hutang_piutang_model.dart';
import '../controllers/hutang_piutang_controller.dart';

class HutangPiutangView extends GetView<HutangPiutangController> {
  const HutangPiutangView({
    Key? key,
    HutangPiutangController? controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hutang Piutang'),
        centerTitle: true,
        actions: <Widget>[
          Visibility(
            visible: MahasConfig.profile?.superUser == true,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: controller.addOnPress,
                child: const Icon(
                  FontAwesomeIcons.circlePlus,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListComponent(
        controller: controller.listCon,
        separatorBuilder: (context, index, length) => Container(
          height: index == length - 1 ? 10 : 0,
        ),
        itemBuilder: (HutangPiutangModel e) {
          return InkWell(
            onTap: () => controller.itemOnTab(e.id!),
            child: Container(
              margin: const EdgeInsets.only(
                  right: 10, left: 10, top: 10, bottom: 0),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(.2)),
                borderRadius: BorderRadius.all(
                  Radius.circular(MahasThemes.borderRadius),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            e.dibayar! >= e.nilai!
                                ? "Lunas"
                                : e.tanggalTempo!.isBefore(DateTime.now())
                                    ? "Jatuh Tempo"
                                    : "",
                            style: MahasThemes.title.copyWith(
                              color: e.dibayar! >= e.nilai!
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          Visibility(
                            visible: e.dibayar! >= e.nilai! ||
                                e.tanggalTempo!.isBefore(DateTime.now()),
                            child: const Padding(padding: EdgeInsets.all(2.5)),
                          ),
                          Text(e.hutang == true ? "Hutang" : "Piutang"),
                        ],
                      ),
                      Text(e.catatan ?? "-"),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(2.5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Nilai", style: MahasThemes.muted),
                      Text(MahasFormat.toCurrency(e.nilai)),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(2.5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Dibayar", style: MahasThemes.muted),
                      Text(MahasFormat.toCurrency(e.dibayar)),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(2.5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tanggal", style: MahasThemes.muted),
                      Text(MahasFormat.displayDate(e.tanggal)),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(2.5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tempo", style: MahasThemes.muted),
                      Text(MahasFormat.displayDate(e.tanggalTempo)),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => controller.historyOnTab(e.id!),
                          child: const Text("History"),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(2.5)),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => controller.itemPayOnTab(e.id!),
                          child: const Text("Pembayaran"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
