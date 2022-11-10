import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../models/api_result_model.dart';
import '../../services/helper.dart';
import '../../services/http_api.dart';
import '../others/shimmer_component.dart';

class SetupPageController<T> extends ChangeNotifier {
  final String Function(dynamic id)? urlApiGet;
  final String Function()? urlApiPost;
  final String Function(dynamic id)? urlApiPut;
  final String Function(dynamic id)? urlApiDelete;
  final dynamic Function(dynamic e) itemKey;
  final dynamic Function(dynamic e) itemIdAfterSubmit;
  late Function(VoidCallback fn) setState;

  final bool withQuestionBack;
  bool allowDelete;
  bool allowEdit;
  final bool isFormData;
  final dynamic pageBackParametes;
  bool editable = false;

  Function()? initState;
  Function()? onSubmit;
  Function()? onInit;
  Function(ApiResultModel)? onSuccessSubmit;

  dynamic _id;
  bool _backRefresh = false;

  dynamic model;
  bool Function()? onBeforeSubmit;
  Function(dynamic id)? bodyApi;
  Function(dynamic json)? apiToView;
  BuildContext? context;

  bool _isLoading = true;

  SetupPageController({
    this.urlApiGet,
    this.urlApiPost,
    this.urlApiPut,
    this.urlApiDelete,
    required this.itemKey,
    this.allowDelete = true,
    this.allowEdit = true,
    this.withQuestionBack = true,
    this.pageBackParametes,
    required this.itemIdAfterSubmit,
    this.onBeforeSubmit,
    this.bodyApi,
    this.isFormData = false,
    this.apiToView,
    this.onInit,
  });

  void _init({
    Function(VoidCallback fn)? setStateX,
    BuildContext? contextX,
  }) async {
    if (setStateX != null) {
      setState = setStateX;
    }
    if (contextX != null) {
      context = contextX;
    }
    setState(() {
      _isLoading = true;
    });
    if (initState != null) {
      await initState!();
    }
    dynamic idX = itemKey(Get.parameters);
    if (onInit != null) {
      await onInit!();
    }
    if (idX != null) {
      await _getModelFromApi(idX);
    } else {
      editable = true;
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future _getModelFromApi(dynamic idX) async {
    if (urlApiGet != null) {
      final r = await HttpApi.get(urlApiGet!(idX));
      if (r.success) {
        _id = idX;
        setState(() {
          apiToView!(r.body);
        });
      } else {
        Helper.dialogWarning(r.message!);
      }
    } else {
      setState(() {
        apiToView!(idX);
      });
    }
  }

  void _back() {
    Helper.backOnPress(
      result: _backRefresh,
      editable: editable,
      questionBack: withQuestionBack,
      parametes: pageBackParametes,
    );
  }

  Future<bool> _onWillPop() async {
    _back();
    return false;
  }

  void _popupMenuButtonOnSelected(String v) async {
    if (v == 'Edit') {
      editable = true;
      setState(() {});
    } else if (v == 'Cancel') {
      _init();
      editable = false;
      setState(() {});
    } else if (v == 'Delete') {
      final r = await Helper.dialogQuestion(
        message: 'Yakin akan menghapus data ini?',
        icon: FontAwesomeIcons.trash,
        textConfirm: 'Delete',
      );
      if (r == true) {
        if (EasyLoading.isShow) return;
        await EasyLoading.show();
        final r = await HttpApi.delete(urlApiDelete!(_id));
        await EasyLoading.dismiss();
        if (r.success) {
          _backRefresh = true;
          _back();
        } else {
          Helper.dialogWarning(r.message!);
        }
      }
    }
  }

  void submitOnPressed() async {
    if (onSubmit != null) {
      onSubmit!();
    } else {
      if (EasyLoading.isShow) return;
      if (onBeforeSubmit != null) {
        if (!onBeforeSubmit!()) return;
      }
      final model = bodyApi != null ? bodyApi!(_id) : null;

      if (urlApiPost != null || urlApiPut != null) {
        await EasyLoading.show();
        ApiResultModel r = _id == null
            ? await HttpApi.post(
                urlApiPost!(),
                body: model,
              )
            : await HttpApi.put(
                urlApiPut!(_id),
                body: model,
              );
        await EasyLoading.dismiss();
        if (r.success) {
          if (onSuccessSubmit != null) {
            onSuccessSubmit!(r);
          } else {
            _backRefresh = true;
            _id ??= itemIdAfterSubmit(r.body);
            await _getModelFromApi(_id);
            editable = false;
          }
        } else {
          Helper.dialogWarning(r.message ?? "");
        }
      }
    }
  }
}

class SetupPageComponent extends StatefulWidget {
  final SetupPageController controller;
  final bool childrenPadding;
  final String title;
  final Widget? titleWidget;
  final Function children;
  final bool showAppBar;
  final dynamic crossAxisAlignmentChildren;
  final Function? titleFunction;
  final List<Widget>? childrenAfterButton;

  const SetupPageComponent({
    Key? key,
    this.title = "",
    required this.controller,
    this.childrenPadding = true,
    this.titleWidget,
    required this.children,
    this.childrenAfterButton,
    this.crossAxisAlignmentChildren = CrossAxisAlignment.center,
    this.titleFunction,
    this.showAppBar = true,
  }) : super(key: key);

  @override
  State<SetupPageComponent> createState() => _SetupPageComponentState();
}

class _SetupPageComponentState extends State<SetupPageComponent> {
  @override
  void initState() {
    widget.controller._init(setStateX: setState, contextX: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.controller._onWillPop,
      child: Scaffold(
        appBar: !widget.showAppBar
            ? null
            : AppBar(
                title: widget.titleWidget ??
                    Text(
                      widget.titleFunction != null
                          ? widget.titleFunction!()
                          : widget.title,
                    ),
                centerTitle: true,
                actions: widget.controller._id == null ||
                        (!widget.controller.allowEdit &&
                            !widget.controller.allowDelete)
                    ? []
                    : [
                        PopupMenuButton(
                          onSelected:
                              widget.controller._popupMenuButtonOnSelected,
                          itemBuilder: (BuildContext context) {
                            List<PopupMenuItem<String>> r = [];
                            if (widget.controller.editable) {
                              r.add(const PopupMenuItem(
                                value: 'Cancel',
                                child: Text('Cancel'),
                              ));
                            } else {
                              if (widget.controller.allowEdit) {
                                r.add(const PopupMenuItem(
                                  value: 'Edit',
                                  child: Text('Edit'),
                                ));
                              }
                              if (widget.controller.allowDelete) {
                                r.add(const PopupMenuItem(
                                  value: 'Delete',
                                  child: Text('Delete'),
                                ));
                              }
                            }
                            return r;
                          },
                        ),
                      ],
              ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: widget.controller._isLoading
              ? const ShimmerComponent()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: widget.crossAxisAlignmentChildren,
                        children: widget.children(),
                      ),
                      Visibility(
                        visible: widget.controller.editable,
                        child: ElevatedButton(
                          onPressed: widget.controller.submitOnPressed,
                          child: const Text('Simpan'),
                        ),
                      ),
                      Visibility(
                        visible: widget.childrenAfterButton != null,
                        child: Column(
                          children: widget.childrenAfterButton ?? [],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
