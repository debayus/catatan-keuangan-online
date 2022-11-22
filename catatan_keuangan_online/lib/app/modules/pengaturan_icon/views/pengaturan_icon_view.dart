import 'package:catatan_keuangan_online/app/mahas/mahas_colors.dart';
import 'package:catatan_keuangan_online/app/models/master_icon_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pengaturan_icon_controller.dart';

class PengaturanIconView extends GetView<PengaturanIconController> {
  const PengaturanIconView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Icon'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
          itemBuilder: (c, index) {
            var i = index * 3;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        controller.iconOnPress(MasterIconModel.icons[i].name),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(60, 60),
                      backgroundColor: MahasColors.light.withOpacity(.5),
                    ),
                    child: Icon(
                      MasterIconModel.icons[i].icon,
                      color: MahasColors.primary,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(5)),
                Expanded(
                  child: i + 1 >= MasterIconModel.icons.length
                      ? Container()
                      : ElevatedButton(
                          onPressed: () => controller
                              .iconOnPress(MasterIconModel.icons[i + 1].name),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(60, 60),
                            backgroundColor: MahasColors.light.withOpacity(.5),
                          ),
                          child: Icon(
                            MasterIconModel.icons[i + 1].icon,
                            color: MahasColors.primary,
                          ),
                        ),
                ),
                const Padding(padding: EdgeInsets.all(5)),
                Expanded(
                  child: i + 2 >= MasterIconModel.icons.length
                      ? Container()
                      : ElevatedButton(
                          onPressed: () => controller
                              .iconOnPress(MasterIconModel.icons[i + 2].name),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(60, 60),
                            backgroundColor: MahasColors.light.withOpacity(.5),
                          ),
                          child: Icon(
                            MasterIconModel.icons[i + 2].icon,
                            color: MahasColors.primary,
                          ),
                        ),
                ),
              ],
            );
          },
          itemCount: (MasterIconModel.icons.length / 3).ceil(),
          separatorBuilder: (c, i) => const Padding(
            padding: EdgeInsets.all(5),
          ),
        ),
      ),
    );
  }
}
