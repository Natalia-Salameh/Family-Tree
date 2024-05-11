import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class ExtendedNode extends Node {
  ValueKey? secondaryId;
  String? primaryGender;
  String? secondaryGender;
  dynamic primaryId;

  ExtendedNode.dualId(dynamic primaryId, [this.primaryGender, dynamic secondaryId, this.secondaryGender])
      : super.Id(primaryId) {
    if (secondaryId != null) {
      this.secondaryId = ValueKey(secondaryId);
    }
  }

  void setSecondaryId(dynamic id) {
    secondaryId = ValueKey(id);
  }

  ValueKey? get secondaryKey => secondaryId;

  String? get getPrimaryGender => primaryGender;

  String? get getSecondaryGender => secondaryGender;

  void setPrimaryGender(String? value) {
    primaryGender = value;
  }

  void setSecondaryGender(String? value) {
    secondaryGender = value;
  }
}

