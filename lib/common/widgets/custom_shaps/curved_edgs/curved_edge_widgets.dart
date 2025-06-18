import 'package:flutter/material.dart';
import 'package:kkn_store/common/widgets/custom_shaps/curved_edgs/curved_edgs.dart';

class TCurvedEdgeWidgets extends StatelessWidget {
  const TCurvedEdgeWidgets({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: TCustomCurvedEdges(), child: child);
  }
}
