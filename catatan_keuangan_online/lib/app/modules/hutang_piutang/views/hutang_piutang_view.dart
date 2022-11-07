import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Text(
          'HutangPiutangView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
