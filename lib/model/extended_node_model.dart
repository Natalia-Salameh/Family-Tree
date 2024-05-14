import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class ExtendedNode extends Node {
  ValueKey? secondaryId;
  String? label; // Add this line to store the label

  ExtendedNode.DualId(dynamic primaryId, {dynamic secondaryId, this.label})
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
