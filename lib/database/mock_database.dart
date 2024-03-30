import 'package:family_tree_application/classes/family.dart';

class MockFamilyTreeDatabase {
  final Map<int, FamilyMember> members = {};
  int _currentId = 0;

  int generateUniqueId() {
    return ++_currentId;
  }

  

  FamilyMember? getMemberById(int id) {
    return members[id];
  }
  
  void addFamilyMember(FamilyMember member) {
    member.id ??= generateUniqueId(); // Assign a new ID if null
    members[member.id!] = member;
  }

  void addSpouse(int memberId, int spouseId) {
    final member = members[memberId];
    final spouse = members[spouseId];
    if (member != null && spouse != null) {
      // Directly assigning int IDs, no need for casting
      member.spouseId = spouse.id;
      spouse.spouseId = member.id;
    }
  }

  void addChildToParent(int childId, int parentId) {
    final parent = members[parentId];
    if (parent != null) {
      // Ensure parent.childrenIds is a list of int, then directly add childId
      parent.childrenIds.add(childId);
    }
  }

  List<FamilyMember> getChildren(int parentId) {
    final List<FamilyMember> children = [];
    final parent = members[parentId];
    if (parent != null) {
      for (var childId in parent.childrenIds) {
        final child = getMemberById(childId);
        if (child != null) {
          children.add(child);
        }
      }
    }
    return children;
  }
}
