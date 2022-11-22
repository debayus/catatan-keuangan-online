import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../mahas_colors.dart';

class ShimmerComponent extends StatelessWidget {
  final int count;
  final double marginBottom;
  final double marginTop;
  final double marginLeft;
  final double marginRight;

  const ShimmerComponent({
    Key? key,
    this.count = 5,
    this.marginBottom = 0,
    this.marginLeft = 0,
    this.marginRight = 0,
    this.marginTop = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shimmers = <Widget>[];

    for (var i = 1; i <= count; i++) {
      shimmers.add(
        Container(
          margin: EdgeInsets.only(
            right: marginRight,
            left: marginLeft,
            top: marginTop,
            bottom: i == count ? marginBottom : 8,
          ),
          width: double.infinity,
          height: 16,
          color: MahasColors.light,
        ),
      );
    }
    return Shimmer.fromColors(
      baseColor: MahasColors.dark.withOpacity(.1),
      highlightColor: MahasColors.dark.withOpacity(.05),
      child: Column(
        children: shimmers,
      ),
    );
  }
}
