import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MasterIconModel {
  String name;
  IconData icon;

  MasterIconModel(this.name, this.icon);

  static IconData? getIcon(String? name) {
    if (name == null) return FontAwesomeIcons.icons;
    return icons.firstWhereOrNull((e) => e.name == name)?.icon;
  }

  static List<MasterIconModel> icons = [
    MasterIconModel('wallet', FontAwesomeIcons.wallet),
    MasterIconModel('creditCard', FontAwesomeIcons.creditCard),
    MasterIconModel('ccMastercard', FontAwesomeIcons.ccMastercard),
    MasterIconModel('moneyBill', FontAwesomeIcons.moneyBill),
    MasterIconModel('landmark', FontAwesomeIcons.landmark),
    MasterIconModel('piggyBank', FontAwesomeIcons.piggyBank),
    MasterIconModel('sackDollar', FontAwesomeIcons.sackDollar),
    MasterIconModel('locationDot', FontAwesomeIcons.locationDot),
    MasterIconModel('houseChimney', FontAwesomeIcons.houseChimney),
    MasterIconModel('computer', FontAwesomeIcons.computer),
    MasterIconModel('carSide', FontAwesomeIcons.carSide),
    MasterIconModel('fire', FontAwesomeIcons.fire),
    MasterIconModel('plane', FontAwesomeIcons.plane),
    MasterIconModel('dribbble', FontAwesomeIcons.dribbble),
    MasterIconModel('key', FontAwesomeIcons.key),
    MasterIconModel('tree', FontAwesomeIcons.tree),
    MasterIconModel('bicycle', FontAwesomeIcons.bicycle),
    MasterIconModel('briefcase', FontAwesomeIcons.briefcase),
    MasterIconModel('compass', FontAwesomeIcons.compass),
    MasterIconModel('bagShopping', FontAwesomeIcons.bagShopping),
    MasterIconModel('bath', FontAwesomeIcons.bath),
    MasterIconModel('shirt', FontAwesomeIcons.shirt),
    MasterIconModel('store', FontAwesomeIcons.store),
    MasterIconModel('hotel', FontAwesomeIcons.hotel),
    MasterIconModel('motorcycle', FontAwesomeIcons.motorcycle),
    MasterIconModel('dumbbell', FontAwesomeIcons.dumbbell),
    MasterIconModel('utensils', FontAwesomeIcons.utensils),
    MasterIconModel('userGraduate', FontAwesomeIcons.userGraduate),
    MasterIconModel('toilet', FontAwesomeIcons.toilet),
    MasterIconModel('pizzaSlice', FontAwesomeIcons.pizzaSlice),
    MasterIconModel('pills', FontAwesomeIcons.pills),
    MasterIconModel('paw', FontAwesomeIcons.paw),
    MasterIconModel('paintbrush', FontAwesomeIcons.paintbrush),
    MasterIconModel('music', FontAwesomeIcons.music),
    MasterIconModel('heart', FontAwesomeIcons.heart),
    MasterIconModel('wandMagicSparkles', FontAwesomeIcons.wandMagicSparkles),
    MasterIconModel('bomb', FontAwesomeIcons.bomb),
    MasterIconModel('poo', FontAwesomeIcons.poo),
    MasterIconModel('camera', FontAwesomeIcons.camera),
    MasterIconModel('cloud', FontAwesomeIcons.cloud),
  ];
}
