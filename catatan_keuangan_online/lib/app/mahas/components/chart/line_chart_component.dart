import 'package:catatan_keuangan_online/app/mahas/components/others/empty_component.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartItem {
  Color color;
  double x;
  double value;

  LineChartItem({
    required this.color,
    required this.x,
    required this.value,
  });
}

class LineChartComponent extends StatefulWidget {
  // final Widget Function(double, TitleMeta)? leftTitleWidgets;
  final List<LineChartItem> data;
  final String? title;

  const LineChartComponent({
    super.key,
    // this.leftTitleWidgets,
    required this.data,
    this.title,
  });

  @override
  State<LineChartComponent> createState() => _LineChartComponentState();
}

class _LineChartComponentState extends State<LineChartComponent> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Card(
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Visibility(
                  visible: widget.title != null,
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text(widget.title ?? "")),
                ),
                Visibility(
                  visible: widget.data.isEmpty,
                  child: const Expanded(child: EmptyComponent()),
                ),
                Visibility(
                  visible: widget.data.isNotEmpty,
                  child: Expanded(
                    child: LineChart(
                      LineChartData(
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 1,
                              // getTitlesWidget: widget.leftTitleWidgets,
                              reservedSize: 42,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border:
                              Border.all(color: Colors.black.withOpacity(.2)),
                        ),
                        lineBarsData: [
                          // LineChartBarData(
                          //   spots: widget.data
                          //       .map(
                          //         (e) => FlSpot(e.x, e.value),
                          //       )
                          //       .toList(),
                          // ),
                        ],
                      ),
                      swapAnimationDuration: const Duration(milliseconds: 150),
                      swapAnimationCurve: Curves.linear,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // if (widget.spots == null || widget.spots!.isEmpty) {
    //   return const EmptyComponent();
    // }
    // return SizedBox(
    //   height: 200,
    //   child: LineChart(
    //     LineChartData(
    //         titlesData: FlTitlesData(
    //           show: true,
    //           rightTitles: AxisTitles(
    //             sideTitles: SideTitles(showTitles: false),
    //           ),
    //           topTitles: AxisTitles(
    //             sideTitles: SideTitles(showTitles: false),
    //           ),
    //           leftTitles: AxisTitles(
    //             sideTitles: SideTitles(
    //               showTitles: true,
    //               interval: 1,
    //               getTitlesWidget: widget.leftTitleWidgets,
    //               reservedSize: 42,
    //             ),
    //           ),
    //         ),
    //         borderData: FlBorderData(
    //           show: true,
    //           border: Border.all(color: Colors.black.withOpacity(.2)),
    //         ),
    //         lineBarsData: [
    //           LineChartBarData(
    //             spots: widget.spots,
    //           ),
    //         ]),
    //     swapAnimationDuration: const Duration(milliseconds: 150),
    //     swapAnimationCurve: Curves.linear,
    //   ),
    // );
  }
}
