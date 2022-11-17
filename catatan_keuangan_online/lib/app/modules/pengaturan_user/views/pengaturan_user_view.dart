import 'package:catatan_keuangan_online/app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../mahas/components/others/list_component.dart';
import '../controllers/pengaturan_user_controller.dart';

class PengaturanUserView extends GetView<PengaturanUserController> {
  const PengaturanUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
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
        itemBuilder: (UserModel e) {
          return ListTile(
            title: Text(e.nama!),
            subtitle: Text(e.email!),
            onTap: () => controller.itemOnTab(e.id!),
          );
        },
      ),
    );
  }
}
