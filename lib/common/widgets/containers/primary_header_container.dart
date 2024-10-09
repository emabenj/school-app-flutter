import 'package:colegio_bnnm/common/widgets/containers/circular_container.dart';
import 'package:colegio_bnnm/common/widgets/curved_edges/curved_edges_widget.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class BPrimaryHeaderContainer extends StatelessWidget {
  const BPrimaryHeaderContainer(
      {super.key, required this.widget, required this.color});
  final Color color;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    final appBarHeight = BHelperFunctions.screenHeight() * .18;
    final circleWithOutCurved = appBarHeight - 20;
    final w = BHelperFunctions.screenWidth();
    return BCurvedEdgesWidget(
        child: Container(
            color: color,
            padding: const EdgeInsets.all(0),
            child: SizedBox(
                height: appBarHeight,
                child: Stack(children: [
                  Positioned(
                      top: -(w - 150) / 2,
                      left: w - (w - 200) / 2 - 6,
                      child: BCircularContainer(
                          radius: w,
                          width: w,
                          height: w,
                          backgroundColor: BColors.textWhite.withOpacity(.15))),
                  Positioned(
                      top: circleWithOutCurved * 4 / 5,
                      left: -2,
                      child: BCircularContainer(
                          radius: w,
                          width: w,
                          height: w,
                          backgroundColor: BColors.textWhite.withOpacity(.15))),
                  Positioned(
                      top: circleWithOutCurved / 2,
                      left: w - (w - 200) / 2,
                      child: BCircularContainer(
                          radius: w - 200,
                          width: w - 200,
                          height: w - 200,
                          backgroundColor: BColors.textWhite.withOpacity(.15))),
                  widget
                ]))));
  }
}
