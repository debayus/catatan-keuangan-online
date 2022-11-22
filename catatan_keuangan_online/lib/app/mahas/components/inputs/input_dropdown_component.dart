import 'package:catatan_keuangan_online/app/mahas/mahas_colors.dart';
import 'package:flutter/material.dart';

import '../mahas_themes.dart';
import 'input_box_component.dart';

class DropdownItem {
  String text;
  dynamic value;

  DropdownItem({
    required this.text,
    this.value,
  });

  DropdownItem.init(String? text, dynamic value)
      : this(
          text: text ?? "",
          value: value,
        );

  DropdownItem.simple(String? value) : this.init(value, value);
}

class InputDropdownController {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late Function(VoidCallback fn) setState;

  DropdownItem? _value;
  List<DropdownItem> items;
  Function(DropdownItem? value)? onChanged;
  bool _isInit = false;

  late bool _required = false;

  dynamic get value {
    return _value?.value;
  }

  String? get text {
    return _value?.text;
  }

  set value(dynamic val) {
    if (items.where((e) => e.value == val).isEmpty) {
      _value = null;
    } else {
      _value = items.firstWhere((e) => e.value == val);
    }
    if (_isInit) {
      setState(() {});
    }
  }

  set setItems(List<DropdownItem> val) {
    if (val.where((e) => e.value == _value?.value).isEmpty) {
      _value = null;
    }
    items = val;
  }

  InputDropdownController({
    this.items = const [],
    this.onChanged,
  });

  void _rootOnChanged(e) {
    _value = e;
    if (onChanged != null) {
      onChanged!(e);
    }
    if (_isInit) {
      setState(() {});
    }
  }

  String? _validator(v) {
    if (_required && v == null) {
      return 'The field is required';
    }
    return null;
  }

  bool get isValid {
    bool? valid = _key.currentState?.validate();
    if (valid == null) {
      return true;
    }
    return valid;
  }

  void _init(Function(VoidCallback fn) setStateX, bool requiredX) {
    setState = setStateX;
    _required = requiredX;
    _isInit = true;
  }
}

class InputDropdownComponent extends StatefulWidget {
  final String? label;
  final double? marginBottom;
  final bool required;
  final bool editable;
  final InputDropdownController controller;
  final Radius? borderRadius;

  const InputDropdownComponent({
    Key? key,
    this.label,
    this.marginBottom,
    this.editable = true,
    required this.controller,
    this.required = false,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<InputDropdownComponent> createState() => _InputDropdownComponentState();
}

class _InputDropdownComponentState extends State<InputDropdownComponent> {
  @override
  void initState() {
    widget.controller._init(
      (fn) {
        if (mounted) {
          setState(fn);
        }
      },
      widget.required,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final decoration = InputDecoration(
      filled: true,
      contentPadding:
          const EdgeInsets.only(top: 12, bottom: 12, left: 10, right: 10),
      fillColor: MahasColors.dark.withOpacity(.01),
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
            widget.borderRadius ?? Radius.circular(MahasThemes.borderRadius)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
            widget.borderRadius ?? Radius.circular(MahasThemes.borderRadius)),
        borderSide: const BorderSide(color: MahasColors.dark, width: .1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
            widget.borderRadius ?? Radius.circular(MahasThemes.borderRadius)),
        borderSide: const BorderSide(color: MahasColors.dark, width: .1),
      ),
      prefixStyle: TextStyle(
        color: MahasColors.light.withOpacity(0.6),
      ),
      suffixIconConstraints: const BoxConstraints(
        minHeight: 30,
        minWidth: 30,
      ),
    );

    return InputBoxComponent(
      label: widget.label,
      isRequired: widget.required,
      marginBottom: widget.marginBottom,
      childText: widget.controller._value == null
          ? ""
          : widget.controller._value?.text ?? "",
      children: widget.editable
          ? Form(
              key: widget.controller._key,
              child: DropdownButtonFormField(
                decoration: decoration,
                isExpanded: true,
                focusColor: Colors.transparent,
                validator: widget.controller._validator,
                value: widget.controller._value,
                onChanged: widget.controller._rootOnChanged,
                items: widget.controller.items
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.text),
                        ))
                    .toList(),
                style: TextStyle(
                  color: MahasColors.dark.withOpacity(.7),
                ),
                dropdownColor: MahasColors.light,
              ),
            )
          : null,
    );
  }
}
