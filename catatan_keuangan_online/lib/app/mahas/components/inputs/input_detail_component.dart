// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:generalledger/app/mahas/components/inputs/lookup_component.dart';
// import 'package:generalledger/app/mahas/components/others/container_component.dart';
// import 'package:generalledger/app/mahas/components/others/text_component.dart';
// import 'package:generalledger/app/mahas/icons/font_awesome5_icons.dart';
// import 'package:generalledger/app/mahas/my_config.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// class InputDetailControler<T> {
//   bool _required = false;
//   String? _errorMessage;
//   late LookupController<T, T> _lookupCon;
//   Widget Function(T e, bool editable, void Function() deleteOnPress)? _builder;
//   bool _isInit = false;

//   late BuildContext context;
//   late Function(VoidCallback fn) setState;
//   String? label;

//   final Function(T e) itemKey;
//   final String Function(int index, String filter) urlApi;
//   T Function(dynamic e)? fromDynamic;
//   late final String Function(T e) itemText;
//   Widget Function(T e, void Function() onClick, Color? color)? itemBuilder;
//   Function()? onChanged;

//   InputDetailControler({
//     required this.itemKey,
//     required this.urlApi,
//     required this.fromDynamic,
//     required this.itemText,
//     this.itemBuilder,
//     this.onChanged,
//   });

//   final List<T> _values = [];

//   void clear() {
//     _values.clear();
//     if (_isInit) {
//       setState(() {});
//     }
//   }

//   List<T> get values => _values;

//   void addValue(T e) {
//     _values.add(e);
//     if (_isInit) {
//       setState(() {});
//     }
//   }

//   void updateValue(dynamic id, T e) {
//     for (var element in _values) {
//       if (itemKey(element) == id) {
//         element = e;
//       }
//     }
//     if (_isInit) {
//       setState(() {});
//     }
//   }

//   void refresh() {
//     if (_isInit) {
//       setState(() {});
//     }
//   }

//   bool get isValid {
//     setState(() {
//       _errorMessage = null;
//     });
//     if (_required && _values.isEmpty) {
//       setState(() {
//         _errorMessage = 'The field is required';
//       });
//       return false;
//     }
//     return true;
//   }

//   void _itemDeleteOnPress(e) {
//     setState(() {
//       _values.removeWhere((element) => itemKey(element) == itemKey(e));
//     });
//     if (onChanged != null) {
//       onChanged!();
//     }
//   }

//   void _addOnPressed() async {
//     if (EasyLoading.isShow) return;
//     FocusScope.of(context).unfocus();
//     _lookupCon.clearSelectedItems();
//     await showMaterialModalBottomSheet(
//       context: context,
//       builder: (context) => LookupComponent<T, T>(
//         controller: _lookupCon,
//         title: label,
//       ),
//     );
//   }

//   Widget _itemWidget(T element, bool editable) => _builder != null
//       ? _builder!(element, editable, () => _itemDeleteOnPress(element))
//       : ContainerComponent(
//           marginTop: 12,
//           marginBottom: 10,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Text(itemText(element)),
//                   Expanded(child: Container()),
//                   Visibility(
//                     visible: editable,
//                     child: InkWell(
//                       onTap: () => _itemDeleteOnPress(element),
//                       child: Icon(
//                         Icons.delete_forever,
//                         color: Colors.red,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );

//   void _init(
//     Function(VoidCallback fn) setStateX,
//     BuildContext contextX,
//     String? labelX,
//   ) {
//     setState = setStateX;
//     context = contextX;
//     label = labelX;

//     _lookupCon = LookupController<T, T>();
//     _lookupCon.urlApi = urlApi;
//     _lookupCon.fromDynamic = fromDynamic;
//     _lookupCon.itemText = itemText;
//     _lookupCon.itemBuilder = itemBuilder;
//     _lookupCon.itemValue = itemKey;
//     _lookupCon.insertFromListOnPress = () {
//       setState(() {
//         for (var m in _lookupCon.selectedItems) {
//           if (_values
//               .where((element) => itemKey(element) == itemKey(m))
//               .isEmpty) {
//             _values.add(m);
//           }
//         }
//       });
//       _lookupCon.close();
//       if (onChanged != null) {
//         onChanged!();
//       }
//     };

//     _isInit = true;
//   }
// }

// class InputDetailComponent<T> extends StatefulWidget {
//   final InputDetailControler<T> controller;
//   final String? label;
//   final bool editable;
//   final bool required;
//   final Widget Function(T e, bool editable, void Function() deleteOnPress)?
//       builder;

//   const InputDetailComponent({
//     Key? key,
//     this.label,
//     this.editable = true,
//     this.required = false,
//     required this.controller,
//     this.builder,
//   }) : super(key: key);

//   @override
//   State<InputDetailComponent<T>> createState() =>
//       _InputDetailComponentState<T>();
// }

// class _InputDetailComponentState<T> extends State<InputDetailComponent<T>> {
//   @override
//   void initState() {
//     widget.controller._builder = widget.builder;
//     widget.controller._required = widget.required;
//     widget.controller._init(setState, context, widget.label);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           ContainerComponent(
//             marginTop: 0,
//             marginBottom: 5,
//             child: Text(widget.label ?? "", Text),
//           ),
//           Container(
//             color: MyConfig.greyInputan.withOpacity(.3),
//             child: Column(
//               children: [
//                 Visibility(
//                   visible: !widget.editable,
//                   child: Padding(padding: EdgeInsets.all(2)),
//                 ),
//                 Visibility(
//                   visible:
//                       widget.controller._values.isEmpty && !widget.editable,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Padding(padding: EdgeInsets.all(5)),
//                       Icon(
//                         FontAwesomeIcons.box_open,
//                         color: MyConfig.greyInputan,
//                         size: 30,
//                       ),
//                       Padding(padding: EdgeInsets.all(5)),
//                       Text(
//                         "No Data",
//                         color: MyConfig.greyInputan,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Column(
//                   children: widget.controller._values
//                       .map((e) =>
//                           widget.controller._itemWidget(e, widget.editable))
//                       .toList(),
//                 ),
//                 Visibility(
//                   visible: widget.editable,
//                   child: Padding(padding: EdgeInsets.all(5)),
//                 ),
//                 Visibility(
//                   visible: widget.editable,
//                   child: TextButton(
//                     child: Icon(FontAwesomeIcons.plus_circle),
//                     onPressed: widget.controller._addOnPressed,
//                   ),
//                 ),
//                 Padding(padding: EdgeInsets.all(5)),
//               ],
//             ),
//           ),
//           Visibility(
//             visible: widget.controller._errorMessage != null,
//             child: Container(
//               margin: EdgeInsets.only(
//                 top: 8,
//                 left: 12,
//               ),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   widget.controller._errorMessage ?? "",
//                   color: Colors.red.shade700,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
