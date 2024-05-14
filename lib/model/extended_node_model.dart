import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class ExtendedNode extends Node {
  ValueKey? secondaryId;
  ValueKey? marriageId;
  String? primaryGender;
  String? secondaryGender;
  dynamic primaryId;

  ExtendedNode.dualId(dynamic primaryId,
      [this.primaryGender,
      dynamic secondaryId,
      this.secondaryGender,
      this.marriageId])
      : super.Id(primaryId) {
    if (secondaryId != null) {
      this.secondaryId = ValueKey(secondaryId);
    }
    if (marriageId != null) {
      marriageId = ValueKey(marriageId);
    }
  }

  void setSecondaryId(dynamic id) {
    secondaryId = ValueKey(id);
  }

  void setMarriageId(dynamic id) {
    marriageId = ValueKey(id);
  }

  ValueKey? get secondaryKey => secondaryId;

  ValueKey? get marriageKey => marriageId;

  String? get getPrimaryGender => primaryGender;

  String? get getSecondaryGender => secondaryGender;

  void setPrimaryGender(String? value) {
    primaryGender = value;
  }

  void setSecondaryGender(String? value) {
    secondaryGender = value;
  }
}
