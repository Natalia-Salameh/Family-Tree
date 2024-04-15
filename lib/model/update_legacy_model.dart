// update_legacy_model.dart
import 'package:json_annotation/json_annotation.dart';

import 'package:family_tree_application/model/member_legacy_model.dart';

part 'update_legacy_model.g.dart';
@JsonSerializable()
class UpdateLegacyModel {
  String education;
  String work;
  String legacyStory;
  String firstName;
  String secondName;
  String thirdName;
  Family family;
  String gender;
  DateTime dateOfBirth;
  String photoBase64;

  UpdateLegacyModel({
    this.education = '',
    this.work = '',
    this.legacyStory = '',
    this.firstName = '',
    this.secondName = '',
    this.thirdName = '',
    required this.family,
    this.gender = '',
    required this.dateOfBirth,
    this.photoBase64 = '',
  });

  factory UpdateLegacyModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateLegacyModelFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateLegacyModelToJson(this);
}
