import 'package:catatan_keuangan_online/app/mahas/mahas_colors.dart';
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
        itemBuilder: (HutangPiutangModel e) {
          return ListTile(
            title: Text(e.catatan ?? "-"),
            subtitle: Column(
              children: [
                Text(MahasFormat.toCurrency(e.nilai)),
                Text(MahasFormat.toCurrency(e.dibayar)),
              ],
            ),
            onTap: () => controller.itemOnTab(e.id!),
            trailing: InkWell(
              child: const SizedBox(
                height: 100,
                width: 40,
                child: Icon(
                  FontAwesomeIcons.moneyBill1Wave,
                  color: MahasColors.blue,
                ),
              ),
              onTap: () => controller.itemPayOnTab(e.id!),
            ),
          );
        },
      ),
    );
  }
}
