import 'package:catatan_keuangan_online/app/mahas/components/mahas_themes.dart';
import 'package:catatan_keuangan_online/app/mahas/services/mahas_format.dart';
import 'package:catatan_keuangan_online/app/models/transaksi_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../mahas/components/others/list_component.dart';
import '../controllers/transaksi_controller.dart';

class TransaksiView extends GetView<TransaksiController> {
  const TransaksiView({
    Key? key,
    TransaksiController? controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transaksi'),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: controller.searchOnPress,
                child: const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 22,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: controller.addOnPress,
                child: const Icon(
                  FontAwesomeIcons.circlePlus,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
        body: ListComponent(
          controller: controller.listCon,
          itemBuilder: (TransaksiModel e) {
            return ListTile(
              leading: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Icon(controller.getIcon(e.tipe)),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(e.jenis ?? "-"),
                  Text(
                    MahasFormat.toCurrency(e.nilai),
                    style: MahasThemes.muted,
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(MahasFormat.displayDate(e.tanggal)),
                  Text(MahasFormat.displayTime(
                      TimeOfDay.fromDateTime(e.tanggal!))),
                ],
              ),
              onTap: () => controller.itemOnTab(e),
            );
          },
        ),
      ),
    );
  }
}
