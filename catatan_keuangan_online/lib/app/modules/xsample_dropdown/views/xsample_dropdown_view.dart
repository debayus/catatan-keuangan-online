import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/xsample_dropdown_controller.dart';

class XsampleDropdownView extends GetView<XsampleDropdownController> {
  const XsampleDropdownView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XsampleDropdownView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'XsampleDropdownView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
