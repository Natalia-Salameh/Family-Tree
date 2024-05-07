import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class ExtendedNode extends Node {
  ValueKey? secondaryId;

  ExtendedNode.DualId(dynamic primaryId, [dynamic secondaryId])
      : super.Id(primaryId) {
    if (secondaryId != null) {
      this.secondaryId = ValueKey(secondaryId);
    }
  }

  void setSecondaryId(dynamic id) {
    secondaryId = ValueKey(id);
  }

  ValueKey? get secondaryKey => secondaryId;
}
