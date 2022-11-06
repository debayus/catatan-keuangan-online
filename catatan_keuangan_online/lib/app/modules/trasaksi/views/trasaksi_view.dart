import 'package:catatan_keuangan_online/app/modules/trasaksi/controllers/trasaksi_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrasaksiView extends GetView<TrasaksiController> {
  const TrasaksiView({
    Key? key,
    TrasaksiController? controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: controller.showMessage,
            child: const Text("sign Out"),
          ),
        ),
      ),
    );
  }
}
