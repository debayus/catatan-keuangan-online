import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/grafik_controller.dart';

class GrafikView extends GetView<GrafikController> {
  const GrafikView({
    Key? key,
    GrafikController? controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GrafikView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GrafikView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
