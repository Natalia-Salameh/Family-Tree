import 'package:family_tree_application/enums.dart';

class Person {
  String fullName;
  String lastName;
  String birthDate;
  String materialState;
  Gender gender;
  LifeStatus lifeStatus;
  String? deathDate;

  Person({
    required this.fullName,
    required this.lastName,
    required this.birthDate,
    required this.materialState,
    required this.gender,
    required this.lifeStatus,
    this.deathDate,
  });
}
