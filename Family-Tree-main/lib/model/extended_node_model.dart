import 'dart:typed_data'; // Import for Uint8List
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class ExtendedNode extends Node {
  ValueKey? secondaryId;
  ValueKey? marriageId;
  String? primaryGender;
  String? secondaryGender;
  Uint8List? primaryImage;
  Uint8List? secondaryImage;
  ValueKey primaryId; // Changed to ValueKey
  String? primaryState;
  String? secondaryState;
  bool isExpanded = false;

  ExtendedNode.dualId(
    dynamic primaryId, [
    this.primaryGender,
    this.primaryImage,
    dynamic secondaryId,
    this.secondaryGender,
    this.secondaryImage,
    dynamic marriageId, 
    this.primaryState,
    this.secondaryState,
  ])  : primaryId = ValueKey(primaryId), 
        super.Id(primaryId) {
    if (secondaryId != null) {
      this.secondaryId = ValueKey(secondaryId);
    }
    if (marriageId != null) {
      this.marriageId = ValueKey(marriageId);
    }
  }

  void setSecondaryId(dynamic id) {
    secondaryId = ValueKey(id);
  }

  void setMarriageId(dynamic id) {
    marriageId = ValueKey(id);
  }

  ValueKey? get secondaryKey => secondaryId;

  ValueKey get primaryKey => primaryId; 

  ValueKey? get marriageKey => marriageId;

  String? get getPrimaryGender => primaryGender;

  String? get getSecondaryGender => secondaryGender;

  String? get getPrimaryState => primaryState;

  String? get getSecondaryState => secondaryState;

  void setPrimaryGender(String? value) {
    primaryGender = value;
  }

  void setSecondaryGender(String? value) {
    secondaryGender = value;
  }

  void setPrimaryImage(Uint8List? image) {
    primaryImage = image;
  }

  void setSecondaryImage(Uint8List? image) {
    secondaryImage = image;
  }

  void setPrimaryState(String? state) {
    primaryState = state;
  }

  void setSecondaryState(String? state) {
    secondaryState = state;
  }
}
