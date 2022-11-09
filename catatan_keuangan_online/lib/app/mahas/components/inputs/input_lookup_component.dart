// import 'package:flutter/material.dart';
// import 'package:generalledger/app/mahas/components/inputs/input_box_component.dart';
// import 'package:generalledger/app/mahas/components/inputs/lookup_component.dart';
// import 'package:generalledger/app/mahas/icons/font_awesome5_icons.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// class InputLookupController<T> {
//   T? _value;
//   bool _required = false;
//   String? _errorMessage;

//   final String Function(T e) itemText;
//   final Function(T e) itemValue;
//   final String Function(int index, String filter) urlApi;
//   final T Function(dynamic e) fromDynamic;
//   late LookupController<T, T> _lookupCon;
//   late Function(VoidCallback fn) setState;
//   late BuildContext context;
//   String? title;
//   String? label;
//   Widget Function(T e, void Function() onClick, Color? color)? itemBuilder;
//   bool _isInit = false;

//   InputLookupController({
//     this.title,
//     required this.itemText,
//     required this.itemValue,
//     required this.urlApi,
//     required this.fromDynamic,
//     this.itemBuilder,
//   });

//   String get text {
//     return _value == null ? "" : itemText(_value as T);
//   }

//   T? get value {
//     return _value;
//   }

//   set value(T? val) {
//     _value = val;
//     if (_isInit) {
//       setState(() {});
//     }
//   }

//   Function()? onChanged;

//   bool get isValid {
//     setState(() {
//       _errorMessage = null;
//     });
//     if (_required && _value == null) {
//       setState(() {
//         _errorMessage = 'The field is required';
//       });
//       return false;
//     }
//     return true;
//   }

//   void _onTab(bool editable) async {
//     if (!editable) return;
//     _lookupCon.clearSelectedItems();

//     FocusScope.of(context).unfocus();
//     await showMaterialModalBottomSheet(
//       context: context,
//       builder: (context) => LookupComponent<T, T>(
//         controller: _lookupCon,
//         title: title ?? label,
//       ),
//     );
//   }

//   void _init(
//     Function(VoidCallback fn) setStateX,
//     BuildContext contextX,
//     String? labelX,
//   ) {
//     setState = setStateX;
//     context = contextX;
//     label = labelX;
//     _lookupCon = LookupController<T, T>(
//       multiple: false,
//     );
//     _lookupCon.urlApi = urlApi;
//     _lookupCon.fromDynamic = fromDynamic;
//     _lookupCon.itemText = itemText;
//     _lookupCon.itemValue = itemValue;
//     _lookupCon.itemBuilder = itemBuilder;
//     _lookupCon.insertFromListOnPress = () {
//       setState(() {
//         _value = _lookupCon.selectedItems.isNotEmpty
//             ? _lookupCon.selectedItems.elementAt(0)
//             : null;
//       });
//       _lookupCon.close();
//       if (onChanged != null) {
//         onChanged!();
//       }
//     };
//     _isInit = true;
//   }

//   void _clearOnTab() {
//     setState(() {
//       _value = null;
//     });
//   }
// }

// class InputLookupComponent<T> extends StatefulWidget {
//   final String? label;
//   final bool editable;
//   final double? marginBottom;
//   final InputLookupController controller;
//   final bool required;

//   const InputLookupComponent({
//     Key? key,
//     this.label,
//     this.marginBottom,
//     required this.controller,
//     this.editable = true,
//     this.required = false,
//   }) : super(key: key);

//   @override
//   State<InputLookupComponent<T>> createState() =>
//       _InputLookupComponentState<T>();
// }

// class _InputLookupComponentState<T> extends State<InputLookupComponent<T>> {
//   @override
//   void initState() {
//     widget.controller._init(setState, context, widget.label);
//     widget.controller._required = widget.required;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InputBoxComponent(
//       label: widget.label,
//       isRequired: widget.required,
//       editable: widget.editable,
//       alowClear: widget.editable && widget.controller._value != null,
//       errorMessage: widget.controller._errorMessage,
//       clearOnTab: widget.controller._clearOnTab,
//       marginBottom: widget.marginBottom,
//       onTap: !widget.editable
//           ? null
//           : () => widget.controller._onTab(widget.editable),
//       icon: !widget.editable ? null : FontAwesomeIcons.search,
//       childText: widget.controller.text,
//     );
//   }
// }