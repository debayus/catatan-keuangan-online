import 'package:catatan_keuangan_online/app/routes/app_pages.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../mahas/models/menu_item_model.dart';

class XsampleController extends GetxController {
  final List<MenuItemModel> menus = [];

  @override
  void onInit() {
    super.onInit();

    menus.add(MenuItemModel('Input', FontAwesomeIcons.bug,
        () => Get.toNamed(Routes.XSAMPLE_INPUT)));
    menus.add(MenuItemModel('Checkbox & Radio', FontAwesomeIcons.bug,
        () => Get.toNamed(Routes.XSAMPLE_CHECKBOX_RADIO)));
    menus.add(MenuItemModel('Date & Time', FontAwesomeIcons.bug,
        () => Get.toNamed(Routes.XSAMPLE_DATE_TIME)));
    menus.add(MenuItemModel('Dropdown', FontAwesomeIcons.bug,
        () => Get.toNamed(Routes.XSAMPLE_DROPDOWN)));
    menus.add(MenuItemModel('Detail', FontAwesomeIcons.bug,
        () => Get.toNamed(Routes.XSAMPLE_DETAIL)));
    menus.add(MenuItemModel(
        'List', FontAwesomeIcons.bug, () => Get.toNamed(Routes.XSAMPLE_LIST)));
    menus.add(MenuItemModel('Setup', FontAwesomeIcons.bug,
        () => Get.toNamed(Routes.XSAMPLE_SETUP)));
  }
}
