// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_legacy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateLegacyModel _$UpdateLegacyModelFromJson(Map<String, dynamic> json) =>
    UpdateLegacyModel(
      education: json['education'] as String? ?? '',
      work: json['work'] as String? ?? '',
      legacyStory: json['legacyStory'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      secondName: json['secondName'] as String? ?? '',
      thirdName: json['thirdName'] as String? ?? '',
      family: Family.fromJson(json['family'] as Map<String, dynamic>),
      gender: json['gender'] as String? ?? '',
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      photoBase64: json['photoBase64'] as String? ?? '',
    );

Map<String, dynamic> _$UpdateLegacyModelToJson(UpdateLegacyModel instance) =>
    <String, dynamic>{
      'education': instance.education,
      'work': instance.work,
      'legacyStory': instance.legacyStory,
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'thirdName': instance.thirdName,
      'family': instance.family,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'photoBase64': instance.photoBase64,
    };
