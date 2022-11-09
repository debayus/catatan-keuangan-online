import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/xsample_date_time_controller.dart';

class XsampleDateTimeView extends GetView<XsampleDateTimeController> {
  const XsampleDateTimeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XsampleDateTimeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'XsampleDateTimeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
