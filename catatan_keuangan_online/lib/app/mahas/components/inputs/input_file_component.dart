// import 'dart:convert';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:generalledger/app/mahas/components/inputs/input_box_component.dart';
// import 'package:generalledger/app/mahas/components/others/button_component.dart';
// import 'package:generalledger/app/mahas/icons/font_awesome5_icons.dart';
// import 'package:dio/dio.dart' as dio;
// import 'package:generalledger/app/mahas/services/helper.dart';

// class InputFileController {
//   final List<PlatformFile> _files = [];
//   bool mutipleFile = false;
//   FileType type;
//   String? _errorMessage;
//   late bool _required;
//   bool _isInit = false;
//   String? strBase64;

//   InputFileController({
//     this.type = FileType.image,
//     this.mutipleFile = false,
//   });

//   List<PlatformFile> get values {
//     return _files;
//   }

//   dynamic getPath() async {
//     if (_files.isNotEmpty) {
//       if (kIsWeb) {
//         return dio.MultipartFile.fromBytes(_files.first.bytes!,
//             filename: _files.first.name);
//       } else {
//         return await dio.MultipartFile.fromFile(_files.single.path!);
//       }
//     } else {
//       return null;
//     }
//   }

//   void addValue(PlatformFile file) {
//     _files.add(file);
//     if (_isInit) {
//       setState(() {});
//     }
//     if (onChanged != null) {
//       onChanged!();
//     }
//   }

//   late Function(VoidCallback fn) setState;
//   BuildContext? context;
//   Function()? onChanged;

//   bool get isValid {
//     setState(() {
//       _errorMessage = null;
//     });
//     if (_required && _files.isEmpty) {
//       setState(() {
//         _errorMessage = 'The field is required';
//       });
//       return false;
//     }
//     return true;
//   }

//   String _inputText(bool editable) {
//     if (_files.isEmpty) {
//       return '';
//     } else if (_files.length == 1) {
//       return _files[0].name;
//     } else {
//       return '${_files.length} files';
//     }
//   }

//   void _viewFileOnPressed() {
//     if (strBase64 == null) return;
//     Helper.dialogCustomWidget([
//       Container(
//         child: Image.memory(base64Decode(strBase64!)),
//       ),
//     ]);
//   }

//   void _onTab(bool editable) async {
//     if (!editable) return;
//     FilePickerResult? result;
//     if (mutipleFile == false) _files.clear();
//     result = await FilePicker.platform
//         .pickFiles(type: type, allowMultiple: mutipleFile);
//     if (result!.files.isEmpty) return;
//     setState(() {
//       _files.addAll(result!.files);
//     });
//   }

//   void _init(Function(VoidCallback fn) setStateX, BuildContext contextX) {
//     setState = setStateX;
//     context = contextX;
//     _isInit = true;
//   }

//   void _clearOnTab() {
//     _files.clear();
//     if (_isInit) {
//       setState(() {});
//     }
//     if (onChanged != null) {
//       onChanged!();
//     }
//   }
// }

// class InputFileComponent extends StatefulWidget {
//   final InputFileController controller;
//   final bool editable;
//   final String? label;
//   final bool required;

//   const InputFileComponent({
//     Key? key,
//     required this.controller,
//     this.editable = true,
//     required this.label,
//     this.required = false,
//   }) : super(key: key);

//   @override
//   InputFileComponentState createState() => InputFileComponentState();
// }

// class InputFileComponentState extends State<InputFileComponent> {
//   @override
//   void initState() {
//     widget.controller._required = widget.required;
//     widget.controller._init(setState, context);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InputBoxComponent(
//       icon: !widget.editable
//           ? null
//           : widget.controller.type == FileType.image
//               ? (widget.controller.mutipleFile
//                   ? FontAwesomeIcons.images
//                   : Icons.image)
//               : (widget.controller.mutipleFile
//                   ? Icons.file_copy
//                   : FontAwesomeIcons.file),
//       editable: widget.editable,
//       label: widget.label,
//       onTap: !widget.editable ? null : () => widget.controller._onTab(true),
//       childText: widget.controller._inputText(widget.editable),
//       alowClear: widget.editable && widget.controller._files.isNotEmpty,
//       errorMessage: widget.controller._errorMessage,
//       clearOnTab: () => widget.controller._clearOnTab(),
//       children: !widget.editable
//           ? ButtonComponent(
//               label: "View File",
//               onPressed: widget.controller.strBase64 == null
//                   ? null
//                   : widget.controller._viewFileOnPressed,
//             )
//           : null,
//     );
//   }
// }
