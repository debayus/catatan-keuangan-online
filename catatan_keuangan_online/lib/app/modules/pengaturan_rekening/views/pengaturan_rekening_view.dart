import 'package:catatan_keuangan_online/app/mahas/services/mahas_format.dart';
import 'package:catatan_keuangan_online/app/models/master_icon_model.dart';
import 'package:catatan_keuangan_online/app/models/rekening_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../mahas/components/others/list_component.dart';
import '../controllers/pengaturan_rekening_controller.dart';

class PengaturanRekeningView extends GetView<PengaturanRekeningController> {
  const PengaturanRekeningView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rekening'),
        centerTitle: true,
        actions: <Widget>[
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
        itemBuilder: (RekeningModel e) {
          return ListTile(
            leading: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Icon(MasterIconModel.getIcon(e.icon!)),
            ),
            title: Text(e.nama!),
            subtitle: Text(MahasFormat.toCurrency(e.saldo)),
            onTap: () => controller.itemOnTab(e.id!),
          );
        },
      ),
    );
  }
}
