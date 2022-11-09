import 'package:catatan_keuangan_online/app/mahas/components/mahas_colors.dart';
import 'package:catatan_keuangan_online/app/mahas/components/mahas_themes.dart';
import 'package:catatan_keuangan_online/app/mahas/services/currency_input_formater.dart';
import 'package:catatan_keuangan_online/app/mahas/services/mahas_format.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'input_box_component.dart';

enum InputTextType { text, email, password, number, paragraf, money }

class InputTextController extends ChangeNotifier {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _con = TextEditingController();
  late Function(VoidCallback fn) setState;

  InputTextController({
    this.type = InputTextType.text,
  });

  bool _required = false;
  double? _moneyValue;
  bool _showPassword = false;
  final InputTextType type;

  VoidCallback? onEditingComplete;
  ValueChanged<String>? onChanged;
  GestureTapCallback? onTap;
  ValueChanged<String>? onFieldSubmitted;
  FormFieldSetter<String>? onSaved;

  String? _validator(String? v, {FormFieldValidator<String>? otherValidator}) {
    if (_required && (v?.isEmpty ?? false)) {
      return 'The field is required';
    }
    if (type == InputTextType.email) {
      const pattern =
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?)*$";
      final regex = RegExp(pattern);
      if ((v?.isEmpty ?? false) || !regex.hasMatch(v!)) {
        return 'Enter a valid email address';
      } else {
        return null;
      }
    }
    if (otherValidator != null) {
      return otherValidator(v);
    }
    return null;
  }

  void _init(Function(VoidCallback fn) setStateX) {
    setState = setStateX;
  }

  bool get isValid {
    bool? valid = _key.currentState?.validate();
    if (valid == null) {
      return true;
    }
    return valid;
  }

  dynamic get value {
    if (type == InputTextType.number) {
      return num.tryParse(_con.text);
    } else if (type == InputTextType.money) {
      return _moneyValue;
    } else {
      return _con.text;
    }
  }

  set value(dynamic value) {
    if (type == InputTextType.money) {
      value = value is int ? value.toDouble() : value;
      _con.text = value == null ? "" : MahasFormat.toCurrency(value);
      _moneyValue = value;
    } else {
      _con.text = value == null ? "" : "$value";
    }
  }

  @override
  void dispose() {
    _con.dispose();
    super.dispose();
  }
}

class InputTextComponent extends StatefulWidget {
  final InputTextController controller;
  final bool required;
  final String? label;
  final bool editable;
  final String? placeHolder;
  final double? marginBottom;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final String? prefixText;
  final Radius? borderRadius;
  final bool? visibility;

  const InputTextComponent({
    Key? key,
    required this.controller,
    this.required = false,
    this.label,
    this.editable = true,
    this.placeHolder,
    this.marginBottom,
    this.inputFormatters,
    this.validator,
    this.prefixText,
    this.borderRadius,
    this.visibility = true,
  }) : super(key: key);

  @override
  State<InputTextComponent> createState() => _InputTextState();
}

class _InputTextState extends State<InputTextComponent> {
  @override
  void initState() {
    widget.controller._init(setState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.controller._required = widget.required;

    final decoration = InputDecoration(
      filled: true,
      fillColor: Colors.black.withOpacity(widget.editable ? .01 : .05),
      hintText: widget.placeHolder,
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
            widget.borderRadius ?? Radius.circular(MahasThemes.borderRadius)),
      ),
      prefixText: widget.prefixText,
      prefixStyle: TextStyle(
        color: Colors.black.withOpacity(0.6),
      ),
      suffixIconConstraints: const BoxConstraints(
        minHeight: 30,
        minWidth: 30,
      ),
      suffixIcon: widget.controller.type == InputTextType.password
          ? InkWell(
              splashColor: Colors.transparent,
              onTap: () => setState(() {
                widget.controller._showPassword =
                    !widget.controller._showPassword;
              }),
              child: Icon(
                widget.controller._showPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.black.withOpacity(0.6),
                size: 14,
              ),
            )
          : null,
    );

    var textFormField = TextFormField(
      maxLines: widget.controller.type == InputTextType.paragraf ? 4 : 1,
      onChanged: widget.controller.onChanged,
      onSaved: widget.controller.onSaved,
      onTap: widget.controller.onTap,
      onFieldSubmitted: widget.controller.onFieldSubmitted,
      style: const TextStyle(
        color: Colors.black,
      ),
      inputFormatters: widget.controller.type == InputTextType.number
          ? [
              FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,10}')),
              ...(widget.inputFormatters ?? []),
            ]
          : widget.controller.type == InputTextType.money
              ? [
                  CurrencyInputFormatter(),
                  CurrencyInputFormatter.allow,
                  ...(widget.inputFormatters ?? []),
                ]
              : widget.inputFormatters,
      controller: widget.controller._con,
      validator: (v) =>
          widget.controller._validator(v, otherValidator: widget.validator),
      autocorrect: false,
      enableSuggestions: false,
      readOnly: !widget.editable,
      obscureText: widget.controller.type == InputTextType.password
          ? !widget.controller._showPassword
          : false,
      onEditingComplete: widget.controller.onEditingComplete,
      keyboardType: (widget.controller.type == InputTextType.number ||
              widget.controller.type == InputTextType.money)
          ? TextInputType.number
          : null,
      decoration: decoration,
    );

    return Visibility(
      visible: widget.visibility!,
      child: InputBoxComponent(
        label: widget.label,
        marginBottom: widget.marginBottom,
        childText: widget.controller._con.text,
        isRequired: widget.required,
        children: Form(
          key: widget.controller._key,
          child: textFormField,
        ),
      ),
    );
  }
}
