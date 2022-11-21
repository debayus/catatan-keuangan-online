import 'package:catatan_keuangan_online/app/models/hutang_piutang_pembayaran.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../mahas/components/others/list_component.dart';
import '../../../mahas/mahas_config.dart';
import '../../../mahas/services/mahas_format.dart';
import '../controllers/hutang_piutang_pembayaran_controller.dart';

class HutangPiutangPembayaranView
    extends GetView<HutangPiutangPembayaranController> {
  const HutangPiutangPembayaranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
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
        itemBuilder: (HutangPiutangPembayaranModel e) {
          return ListTile(
            title: Text(MahasFormat.displayDate(e.tanggal)),
            trailing: Text(MahasFormat.toCurrency(e.nilai)),
            subtitle: Text(e.idRekeningNama!),
            onTap: () => controller.itemOnTab(e.id!),
          );
        },
      ),
    );
  }
}
