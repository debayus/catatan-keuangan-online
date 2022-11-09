// import 'package:flutter/material.dart';
// import 'package:generalledger/app/mahas/components/inputs/input_text_component.dart';
// import 'package:generalledger/app/mahas/components/others/button_component.dart';
// import 'package:generalledger/app/mahas/components/others/container_component.dart';
// import 'package:generalledger/app/mahas/components/others/divider_component.dart';
// import 'package:generalledger/app/mahas/components/others/shimmer_component.dart';
// import 'package:generalledger/app/mahas/components/others/text_component.dart';
// import 'package:generalledger/app/mahas/icons/font_awesome5_icons.dart';
// import 'package:generalledger/app/mahas/models/api_result_list_model.dart';
// import 'package:generalledger/app/mahas/my_config.dart';
// import 'package:generalledger/app/mahas/services/helper.dart';
// import 'package:generalledger/app/mahas/services/http_api.dart';

// class LookupController<T, U> extends ChangeNotifier {
//   final bool multiple;
//   final _listViewController = ScrollController();
//   final _filterController = InputTextController();

//   late final Function(T e) itemValue;
//   late final List<T> _items;
//   late final String Function(T e) itemText;

//   late BuildContext context;
//   late Function(VoidCallback fn) setState;

//   String Function(int index, String filter)? urlApi;
//   T Function(dynamic e)? fromDynamic;
//   Function()? insertOnPress;
//   Function()? insertFromListOnPress;
//   Function(T e)? onOpenForm;
//   Widget Function(T e, void Function() onClick, Color? color)? itemBuilder;
//   late Widget Function(dynamic) builder;
//   T? model;

//   List<T> _itemsSelected = [];
//   final List<U> _itemsUSelected = [];
//   bool _loadingBottom = false;
//   bool _isItemRefresh = false;
//   int _pageIndex = 0;
//   int _maxPage = 0;
//   bool isSetup = false;
//   bool allowFilter = true;
//   U? itemUActive;

//   set items(List<T> value) {
//     _items.clear();
//     _items.addAll(value);
//   }

//   List<T> get selectedItems {
//     return _itemsSelected;
//   }

//   List<U> get selectedItemsU {
//     return _itemsUSelected;
//   }

//   void clearSelectedItems() {
//     _itemsSelected.clear();
//     _itemsUSelected.clear();
//   }

//   T? itemsSelectedActive;
//   bool withSetup = false;

//   LookupController({
//     this.urlApi,
//     this.fromDynamic,
//     this.insertOnPress,
//     this.multiple = true,
//   }) : _items = [];

//   void clearItems() {
//     _items.clear();
//     _pageIndex = 0;
//     _maxPage = 0;
//   }

//   Future refreshItems() async {
//     if (urlApi != null) {
//       clearItems();
//       await refreshBottom();
//       FocusScope.of(context).unfocus();
//     }
//     setState(() {});
//   }

//   Future refreshBottom({nextPage = false}) async {
//     final itemsX = await getItems(nextPage: nextPage);
//     if (itemsX != null) {
//       _items.addAll(itemsX);
//     }
//   }

//   Future<List<T>?> getItems({nextPage = false}) async {
//     if (urlApi == null) return [];
//     if (!_loadingBottom) {
//       setState(() {
//         _isItemRefresh = true;
//       });
//     }
//     try {
//       final pageIndexX = nextPage ? _pageIndex + 1 : _pageIndex;
//       final filterX = _filterController.value as String;
//       final query =
//           urlApi!(pageIndexX + (MyConfig.server == 'Laravel' ? 1 : 0), filterX);
//       final apiModel = await HttpApi.apiGet(query);
//       final List<T> result = [];
//       if (!_loadingBottom) {
//         setState(() {
//           _isItemRefresh = false;
//         });
//       }
//       if (apiModel.success) {
//         ApiResultListModel listModel =
//             ApiResultListModel.fromDynamic(apiModel.body);
//         _maxPage = listModel.maxPage!;
//         _pageIndex = pageIndexX;
//         for (var i = 0; i < (listModel.datas ?? []).length; i++) {
//           if (fromDynamic != null) {
//             result.add(fromDynamic!(listModel.datas![i]));
//           }
//         }
//       } else {
//         Helper.dialogWarning(apiModel.message);
//       }
//       return result;
//     } catch (ex) {
//       Helper.dialogWarning('$ex');
//       setState(() {
//         _isItemRefresh = false;
//       });
//       return null;
//     }
//   }

//   void _init(Function(VoidCallback fn) setStateX, BuildContext contextX) {
//     setState = setStateX;
//     context = contextX;
//     _filterController.onEditingComplete = () => refreshItems();
//     _listViewController.addListener(() async {
//       if (_loadingBottom) return;
//       final maxScroll = _listViewController.position.maxScrollExtent;
//       final currentScroll = _listViewController.position.pixels;
//       final delta = 0.0;
//       if (maxScroll - currentScroll <= delta && _pageIndex != _maxPage) {
//         _loadingBottom = true;
//         await refreshBottom(nextPage: true);
//         _loadingBottom = false;
//       }
//     });
//     refreshItems();
//   }

//   Future<bool> backOnPressed() async {
//     if (withSetup && isSetup && itemsSelectedActive != null) {
//       setState(() {
//         isSetup = false;
//       });
//       return false;
//     } else {
//       return true;
//     }
//   }

//   void itemOnTab(T e) {
//     final item =
//         _itemsSelected.where((element) => itemValue(element) == itemValue(e));

//     setState(() {
//       if (item.isEmpty) {
//         if (!multiple) {
//           _itemsSelected = [];
//         }
//         if (withSetup) {
//           isSetup = true;
//           itemsSelectedActive = e;
//           onOpenForm!(e);
//         } else {
//           _itemsSelected.add(e);
//         }
//       } else {
//         if (!multiple) {
//           insertFromListOnPress!();
//         }
//         _itemsSelected.removeAt(_itemsSelected
//             .indexWhere((element) => itemValue(element) == itemValue(e)));
//       }
//     });
//   }

//   Color? _itemColor(int index) {
//     return _itemsSelected
//             .where((element) => itemValue(element) == itemValue(_items[index]))
//             .isEmpty
//         ? null
//         : MyConfig.primaryColor.shade400;
//   }

//   String _itemText(int index) {
//     return itemText(_items[index]);
//   }

//   void close() {
//     Navigator.pop(context);
//   }

//   Widget _itemBuilder(int index) {
//     if (itemBuilder != null) {
//       return itemBuilder!(
//         _items[index],
//         () => itemOnTab(_items[index]),
//         _itemColor(index),
//       );
//     } else {
//       return ListTile(
//         tileColor: _itemColor(index),
//         title: Text(
//           _itemText(index),
//         ),
//         onTap: () => itemOnTab(_items[index]),
//       );
//     }
//   }
// }

// class LookupComponent<T, U> extends StatefulWidget {
//   final String? title;
//   final LookupController<T, U> controller;
//   final Widget Function(dynamic)? setup;

//   const LookupComponent({
//     Key? key,
//     this.title,
//     required this.controller,
//     this.setup,
//   }) : super(key: key);

//   @override
//   State<LookupComponent> createState() => _LookupComponentState();
// }

// class _LookupComponentState<T, U> extends State<LookupComponent<T, U>> {
//   @override
//   void initState() {
//     widget.controller._init(setState, context);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: widget.controller.backOnPressed,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title ?? ""),
//           centerTitle: true,
//         ),
//         body: StatefulBuilder(
//           builder: (
//             context,
//             setState,
//           ) =>
//               widget.controller.isSetup
//                   ? ContainerComponent(
//                       child: Column(
//                         children: [
//                           widget.controller.builder(widget.controller.model),
//                           ButtonComponent(
//                             label: 'Insert',
//                             onPressed: widget.controller.insertOnPress,
//                           )
//                         ],
//                       ),
//                     )
//                   : Column(
//                       children: [
//                         Visibility(
//                           visible: widget.controller.allowFilter,
//                           child: InputText(
//                             borderRadius: Radius.zero,
//                             placeHolder: 'Search',
//                             marginBottom: 0,
//                             controller: widget.controller._filterController,
//                           ),
//                         ),
//                         Expanded(
//                           child: RefreshIndicator(
//                             color: MyConfig.primaryColor.shade800,
//                             backgroundColor: MyConfig.primaryColor.shade600,
//                             onRefresh: widget.controller.refreshItems,
//                             child: widget.controller._isItemRefresh
//                                 ? ShimmerComponent()
//                                 : widget.controller._items.isEmpty &&
//                                         !widget.controller._isItemRefresh
//                                     ? Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Icon(
//                                             FontAwesomeIcons.box_open,
//                                             color:
//                                                 MyConfig.primaryColor.shade600,
//                                             size: 40,
//                                           ),
//                                           Padding(padding: EdgeInsets.all(5)),
//                                           Text("No Item Found"),
//                                           Padding(padding: EdgeInsets.all(5)),
//                                           TextButton(
//                                             onPressed:
//                                                 widget.controller.refreshItems,
//                                             child: Text(
//                                               "Refresh",
//                                               color: Colors.lightBlue,
//                                             ),
//                                           )
//                                         ],
//                                       )
//                                     : ListView.separated(
//                                         separatorBuilder: (context, index) =>
//                                             DividerComponent(),
//                                         controller: widget
//                                             .controller._listViewController,
//                                         physics:
//                                             AlwaysScrollableScrollPhysics(),
//                                         itemCount:
//                                             widget.controller._items.length +
//                                                 (MyConfig.server == "Laravel"
//                                                     ? 1
//                                                     : 0),
//                                         itemBuilder: (context, index) {
//                                           if (index ==
//                                               widget.controller._items.length) {
//                                             return Visibility(
//                                               visible: widget.controller
//                                                           ._pageIndex !=
//                                                       widget.controller
//                                                           ._maxPage &&
//                                                   widget.controller._items
//                                                       .isNotEmpty,
//                                               child: Container(
//                                                 margin: EdgeInsets.all(10),
//                                                 child: Center(
//                                                   child:
//                                                       CircularProgressIndicator(
//                                                     color: MyConfig
//                                                         .primaryColor.shade600,
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           } else {
//                                             return Container(
//                                               child: widget.controller
//                                                   ._itemBuilder(index),
//                                             );
//                                           }
//                                         },
//                                       ),
//                           ),
//                         ),
//                         ButtonComponent(
//                           borderRadius: Radius.zero,
//                           label: 'Insert',
//                           onPressed: widget.controller.insertFromListOnPress,
//                         ),
//                       ],
//                     ),
//         ),
//       ),
//     );
//   }
// }
