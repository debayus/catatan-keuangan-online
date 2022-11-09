// import 'package:flutter/material.dart';
// import 'package:generalledger/app/mahas/components/inputs/input_text_component.dart';
// import 'package:generalledger/app/mahas/components/others/divider_component.dart';
// import 'package:generalledger/app/mahas/components/others/empty_component.dart';
// import 'package:generalledger/app/mahas/components/others/shimmer_component.dart';
// import 'package:generalledger/app/mahas/components/others/text_component.dart';
// import 'package:generalledger/app/mahas/models/api_result_list_model.dart';
// import 'package:generalledger/app/mahas/my_config.dart';
// import 'package:generalledger/app/mahas/services/helper.dart';
// import 'package:generalledger/app/mahas/services/http_api.dart';
// import 'package:get/get.dart';

// class ListPageController<T> {
//   final Function(int index, String filter) urlApi;
//   final Function(dynamic e)? fromDynamic;
//   final Map<String, String> Function(T e) itemId;
//   final String? page;
//   final dynamic pageParameters;
//   final bool allowAdd;
//   final bool allowSearch;
//   final bool allowDetail;
//   final String? pageBack;
//   final dynamic pageBackParametes;
//   late Function(VoidCallback fn) setState;

//   final _listViewController = ScrollController();
//   final _filterController = InputTextController();
//   final List<T> _items = [];

//   ListPageController({
//     required this.urlApi,
//     required this.fromDynamic,
//     required this.itemId,
//     this.page,
//     this.pageParameters,
//     this.allowAdd = true,
//     this.allowSearch = true,
//     this.allowDetail = true,
//     this.pageBack,
//     this.pageBackParametes,
//   });

//   bool _loadingBottom = false;
//   bool _isItemRefresh = true;
//   int _pageIndex = 0;
//   int _maxPage = 0;

//   void clear() {
//     _items.clear();
//     _pageIndex = 0;
//     _maxPage = 0;
//   }

//   Future refresh() async {
//     clear();
//     await _refreshBottom();
//     Get.focusScope?.unfocus();
//     setState(() {});
//   }

//   Future _refreshBottom({nextPage = false}) async {
//     final itemsX = await _getItems(nextPage: nextPage);
//     if (itemsX != null) {
//       _items.addAll(itemsX);
//     }
//   }

//   Future<List<T>?> _getItems({nextPage = false}) async {
//     if (!nextPage) {
//       setState(() {
//         _isItemRefresh = true;
//       });
//     }
//     try {
//       final pageIndexX = nextPage ? _pageIndex + 1 : _pageIndex;
//       final filterX = _filterController.value;
//       final query =
//           urlApi(pageIndexX + (MyConfig.server == 'Laravel' ? 1 : 0), filterX);
//       final apiModel = await HttpApi.apiGet(query);
//       final List<T> result = [];
//       setState(() {
//         _isItemRefresh = false;
//       });
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
//         Helper.dialogWarning(apiModel.message ?? "");
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

//   void _addOnTab() {
//     Helper.toNamed(
//       page!,
//       parameters: pageParameters,
//       arguments: {'back': true},
//     )?.then((value) {
//       if (value == true) {
//         refresh();
//       }
//     });
//   }

//   void _itemOnTab(T e) {
//     final param = itemId(e);
//     var newPageParameters =
//         pageParameters is Function ? pageParameters(e) : (pageParameters ?? {});
//     Helper.toNamed(
//       page!,
//       parameters: {
//         ...param,
//         ...newPageParameters,
//       },
//       arguments: {'back': true},
//     )?.then((value) {
//       if (value == true) {
//         refresh();
//       }
//     });
//   }

//   void _init(Function(VoidCallback fn) setStateX) {
//     setState = setStateX;
//     _filterController.onEditingComplete = () => refresh();
//     _listViewController.addListener(() async {
//       if (_loadingBottom) return;
//       final maxScroll = _listViewController.position.maxScrollExtent;
//       final currentScroll = _listViewController.position.pixels;
//       final delta = 0.0;
//       if (maxScroll - currentScroll <= delta && _pageIndex != _maxPage) {
//         _loadingBottom = true;
//         await _refreshBottom(nextPage: true);
//         _loadingBottom = false;
//       }
//     });
//     refresh();
//   }
// }

// class ListPageComponent<T> extends StatefulWidget {
//   final ListPageController<T> controller;
//   final String title;
//   final Function(T e, void Function() onClick) itemBuilder;
//   final bool allowMenuAction;
//   final List<Widget>? listMenuAction;

//   const ListPageComponent({
//     Key? key,
//     required this.controller,
//     required this.title,
//     required this.itemBuilder,
//     this.allowMenuAction = false,
//     this.listMenuAction,
//   }) : super(key: key);

//   @override
//   State<ListPageComponent<T>> createState() => _ListPageComponentState<T>();
// }

// class _ListPageComponentState<T> extends State<ListPageComponent<T>> {
//   @override
//   void initState() {
//     widget.controller._init(setState);
//     super.initState();
//   }

//   Widget itemBuilder(T e) {
//     var item = widget.itemBuilder(e, () => widget.controller._itemOnTab(e));
//     if (item is Widget) {
//       return item;
//     } else {
//       return ListTile(
//         title: Text("${item ?? ""}"),
//         onTap: widget.controller.allowDetail
//             ? () => widget.controller._itemOnTab(e)
//             : null,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         centerTitle: true,
//         leading: widget.controller.pageBack != null
//             ? BackButton(
//                 onPressed: () => Helper.backOnPress(
//                   page: widget.controller.pageBack!,
//                   parametes: widget.controller.pageBackParametes,
//                 ),
//               )
//             : null,
//         actions: widget.allowMenuAction ? widget.listMenuAction : null,
//       ),
//       body: Column(
//         children: [
//           Visibility(
//             visible: widget.controller.allowSearch,
//             child: InputText(
//               borderRadius: Radius.zero,
//               placeHolder: 'Search',
//               marginBottom: 0,
//               controller: widget.controller._filterController,
//             ),
//           ),
//           Expanded(
//             child: RefreshIndicator(
//               color: MyConfig.primaryColor.shade800,
//               backgroundColor: MyConfig.primaryColor.shade600,
//               onRefresh: widget.controller.refresh,
//               child: widget.controller._isItemRefresh
//                   ? ShimmerComponent()
//                   : widget.controller._items.isEmpty &&
//                           !widget.controller._isItemRefresh
//                       ? EmptyComponent(
//                           onPressed: widget.controller.refresh,
//                         )
//                       : ListView.separated(
//                           separatorBuilder: (context, index) =>
//                               DividerComponent(),
//                           controller: widget.controller._listViewController,
//                           physics: AlwaysScrollableScrollPhysics(),
//                           itemCount: widget.controller._items.length +
//                               (MyConfig.server == "Laravel" ? 1 : 0),
//                           itemBuilder: (context, index) {
//                             if (index == widget.controller._items.length) {
//                               return Visibility(
//                                 visible: widget.controller._pageIndex !=
//                                         widget.controller._maxPage &&
//                                     widget.controller._items.isNotEmpty,
//                                 child: Container(
//                                   margin: EdgeInsets.all(10),
//                                   child: Center(
//                                     child: CircularProgressIndicator(
//                                       color: MyConfig.primaryColor.shade600,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             } else {
//                               return itemBuilder(
//                                   widget.controller._items[index]);
//                             }
//                           },
//                         ),
//             ),
//           )
//         ],
//       ),
//       floatingActionButton: widget.controller.allowAdd
//           ? FloatingActionButton(
//               onPressed: () => widget.controller._addOnTab(),
//               child: Icon(Icons.add),
//             )
//           : null,
//     );
//   }
// }
