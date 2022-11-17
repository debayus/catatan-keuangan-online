import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../mahas/components/others/list_component.dart';
import '../../../models/jenis_pengeluaran_pemasukan_model.dart';
import '../../../models/master_icon_model.dart';
import '../controllers/pengaturan_jenis_pemasukan_controller.dart';

class PengaturanJenisPemasukanView
    extends GetView<PengaturanJenisPemasukanController> {
  const PengaturanJenisPemasukanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jenis Pemasukan'),
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
        itemBuilder: (JenisPengeluaranPemasukanModel e) {
          return ListTile(
            leading: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Icon(MasterIconModel.getIcon(e.icon!)),
            ),
            title: Text(e.nama!),
            onTap: () => controller.itemOnTab(e.id!),
          );
        },
      ),
    );
  }
}
