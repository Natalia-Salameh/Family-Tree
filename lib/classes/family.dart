// models/family_member.dart
enum LifeStatus { alive, deceased }

class FamilyMember {
  int ? id;
  String name;
  DateTime? birthDate;
  DateTime? deathDate;
  LifeStatus lifeStatus;
  int ?spouseId;
  List<int> childrenIds;

  FamilyMember({
     this.id,
    required this.name,
    this.birthDate,
    this.deathDate,
    required this.lifeStatus,
    this.spouseId,
    this.childrenIds = const [],
  });
}
