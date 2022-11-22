import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../mahas_colors.dart';
import '../mahas_themes.dart';

class InputBoxComponent extends StatelessWidget {
  final String? label;
  final double? marginBottom;
  final String? childText;
  final Widget? children;
  final Widget? childrenSizeBox;
  final GestureTapCallback? onTap;
  final bool alowClear;
  final String? errorMessage;
  final IconData? icon;
  final bool? isRequired;
  final bool? editable;
  final Function()? clearOnTab;

  const InputBoxComponent({
    Key? key,
    this.label,
    this.marginBottom,
    this.childText,
    this.onTap,
    this.children,
    this.childrenSizeBox,
    this.alowClear = false,
    this.clearOnTab,
    this.errorMessage,
    this.isRequired = false,
    this.icon,
    this.editable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: label != null,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: (isRequired == true)
                    ? Row(
                        children: [
                          Text(
                            label ?? '-',
                            style: MahasThemes.muted,
                          ),
                          Text(
                            "*",
                            style: MahasThemes.muted
                                .copyWith(color: MahasColors.danger),
                          ),
                        ],
                      )
                    : Text(
                        label ?? '-',
                        style: MahasThemes.muted,
                      ),
              ),
              const Padding(padding: EdgeInsets.all(2)),
            ],
          ),
        ),
        Visibility(
          visible: children == null,
          child: Column(
            children: [
              SizedBox(
                height: 48,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(MahasThemes.borderRadius),
                    color: MahasColors.dark
                        .withOpacity(editable ?? false ? .01 : .05),
                    border: errorMessage != null
                        ? Border.all(color: MahasColors.danger, width: .8)
                        : Border.all(color: MahasColors.dark, width: .1),
                  ),
                  padding: childrenSizeBox != null
                      ? null
                      : const EdgeInsets.only(left: 10, right: 10),
                  child: childrenSizeBox ??
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: onTap,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  childText ?? '',
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: alowClear,
                            child: SizedBox(
                              width: 20,
                              height: 30,
                              child: InkWell(
                                onTap: clearOnTab,
                                child: const Icon(
                                  FontAwesomeIcons.xmark,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !alowClear && icon != null,
                            child: SizedBox(
                              width: 20,
                              height: 30,
                              child: InkWell(
                                onTap: onTap,
                                child: Icon(
                                  icon,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                ),
              ),
              Visibility(
                visible: errorMessage != null,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 8,
                    left: 12,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      errorMessage ?? "",
                      style: const TextStyle(color: MahasColors.danger),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: children != null,
          child: Column(
            children: [
              children ?? Container(),
              Visibility(
                visible: errorMessage != null,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 8,
                    left: 12,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      errorMessage ?? "",
                      style: const TextStyle(color: MahasColors.danger),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.all(marginBottom ?? 10)),
      ],
    );
  }
}
