import 'package:colegio_bnnm/common/widgets/curved_edges/curved_edges.dart';
import 'package:flutter/material.dart';

class BCurvedEdgesWidget extends StatelessWidget {
  const BCurvedEdgesWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: BCustomCurvedEdges(), child: child);
  }
}
