import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmptyComponent extends StatelessWidget {
  final VoidCallback? onPressed;

  const EmptyComponent({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            FontAwesomeIcons.boxOpen,
            size: 40,
          ),
          const Padding(padding: EdgeInsets.all(5)),
          const Text("Tidak ada data"),
          const Padding(padding: EdgeInsets.all(5)),
          Visibility(
            visible: onPressed != null,
            child: TextButton(
              onPressed: onPressed,
              child: const Text(
                "Refresh",
              ),
            ),
          )
        ],
      ),
    );
  }
}
