import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../mahas_colors.dart';

enum LoginButtonType { google, apple }

class LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final LoginButtonType type;

  const LoginButton({
    super.key,
    required this.onPressed,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final title = type == LoginButtonType.google
        ? "Sign in with Google"
        : "Sign in with Apple";
    final icon = type == LoginButtonType.google
        ? FontAwesomeIcons.google
        : FontAwesomeIcons.apple;
    final backgroundColor =
        type == LoginButtonType.google ? MahasColors.red : MahasColors.dark;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 16,
          ),
          const Padding(padding: EdgeInsets.all(5)),
          Text(
            title,
          ),
        ],
      ),
    );
  }
}
