import 'package:flutter/cupertino.dart';

class IndicatorComponent extends StatelessWidget {
  const IndicatorComponent({
    super.key,
    required this.color,
    required this.text,
    this.size = 16,
  });
  final Color color;
  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
        )
      ],
    );
  }
}
