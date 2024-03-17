import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:family_tree_application/core/constants/imageasset.dart';
import 'package:family_tree_application/enums.dart';

class MockData {
  static LifeStatus lifeStatusValue = LifeStatus.alive;
  static final List<SelectedListItem> familyName = [
    SelectedListItem(
      name: 'سلامة',
    ),
    SelectedListItem(
      name: 'لاما',
    ),
    SelectedListItem(
      name: 'سعد',
    ),
    SelectedListItem(
      name: 'شوملي',
    ),
    SelectedListItem(
      name: 'حيحي',
    ),
    SelectedListItem(
      name: 'بنورة',
    ),
    SelectedListItem(
      name: 'سلامة',
    ),
  ];

  static String groupValue = "gender";

  // Map of people with their details
  static final Map<String, dynamic> people = {
    'person1': {
      'name': 'Alex Smith',
      'subject': 'Mathematics',
      'location': 'New York',
      'image': AppImageAsset.father,
    },
    'person2': {
      'name': 'Maria Garcia',
      'subject': 'Biology',
      'location': 'Los Angeles',
      'image': AppImageAsset.child,
    },
    'person3': {
      'name': 'John Doe',
      'subject': 'History',
      'location': 'Chicago',
      'image': AppImageAsset.profile,
    },
    'person4': {
      'name': 'Alex Smith',
      'subject': 'Mathematics',
      'location': 'New York',
      'image': AppImageAsset.mother,
    },
    'person5': {
      'name': 'Maria Garcia',
      'subject': 'Biology',
      'location': 'Los Angeles',
      'image': AppImageAsset.child,
    },
    // Add more people as needed
  };
}
