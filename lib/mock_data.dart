import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:family_tree_application/core/constants/imageasset.dart';
import 'package:family_tree_application/enums.dart';

class MockData {
   static List<String> treeData = []; 
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
  };

  static final Map<String, dynamic> person = {
    "id": 1,
    "FirstName": "Charles",
    // "SecondName": "khader",
    // "ThirdName": "nasri",
    // "FamilyName": "Saed",
    "Gender": "Male",
    "Approved": "yes",
    "NumConfirm": 10,
    "NumReport": 3,
    "Spouses": [
      {
        "marriageid": 11,
        "Partner": {
          "id": 7,
          "firstName": "Diana",
          "Gender": "Female",
          "Children": [
            {
              "Child": {
                "id": 4,
                "firstName": "William",
                "Gender": "Male",
              }
            },
            {
              "Child": {
                "id": 5,
                "firstName": "Harry",
                "Gender": "Male",
              }
            }
          ],
        }
      },
      {
        "marriageid": 22,
        "Partner": {
          "id": 8,
          "firstName": "Camila",
          "Gender": "Female",
        }
      }
    ],
    "Parents": [
      {
        "marriageid": 3,
        "Father": {
          "id": 2,
          "firstName": "Philip",
          "Gender": "Male",
        },
        "Mother": {
          "id": 3,
          "firstName": "Elizabeth",
          "Gender": "Female",
        }
      }
    ],
  };
}
