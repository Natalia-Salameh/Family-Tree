import 'package:family_tree_application/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class LegacyEdit extends StatefulWidget {
  const LegacyEdit({Key? key}) : super(key: key);

  @override
  State<LegacyEdit> createState() => _UserFormState();
}

class _UserFormState extends State<LegacyEdit> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController workController = TextEditingController();
  final TextEditingController diaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Edit Legacy",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView(
          children: [
            const ProfilePicture(
              name: "Natalia Salameh",
              radius: 31,
              fontsize: 21,
            ),
            ListTile(
              horizontalTitleGap: 35,
              leading: const Text("Name"),
              title: TextField(
                controller: fullNameController,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            const Divider(
              height: 0.5,
              indent: 80,
              thickness: 1,
              color: CustomColors.lightGrey,
            ),
            ListTile(
              horizontalTitleGap: 22,
              leading: const Text("Birthday"),
              title: TextField(
                controller: dateController,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            const Divider(
              height: 0.5,
              indent: 80,
              thickness: 1,
              color: CustomColors.lightGrey,
            ),
            ListTile(
              leading: const Text("Education"),
              title: TextField(
                controller: educationController,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            const Divider(
              height: 0.5,
              indent: 80,
              thickness: 1,
              color: CustomColors.lightGrey,
            ),
            ListTile(
              horizontalTitleGap: 40,
              leading: const Text("Work"),
              title: TextField(
                controller: workController,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            const Divider(
              height: 0.5,
              indent: 80,
              thickness: 1,
              color: CustomColors.lightGrey,
            ),
            ListTile(
              horizontalTitleGap: 40,
              leading: const Text("Diary"),
              title: TextField(
                maxLines: 2,
                controller: diaryController,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            const Divider(
              height: 0.5,
              indent: 80,
              thickness: 1,
              color: CustomColors.lightGrey,
            ),
          ],
        )

        // SingleChildScrollView(
        //   child: SafeArea(
        //     child: Padding(
        //       padding: EdgeInsets.all(15),
        //       child: Align(
        //         alignment: Alignment.topCenter,
        //         child: Column(
        //           children: [
        //             Padding(
        //                 padding: EdgeInsets.only(bottom: 10),
        //                 child: Stack(
        //                   children: [
        //                     const Profile(),
        //                     Positioned(
        //                       bottom: 0,
        //                       right: 0,
        //                       child: Container(
        //                         height: 25,
        //                         width: 25,
        //                         decoration: const BoxDecoration(
        //                           shape: BoxShape.circle,
        //                           color: Colors.white,
        //                         ),
        //                         child: IconButton(
        //                           icon: const Icon(Icons.camera_alt_outlined,
        //                               size: 16),
        //                           color: CustomColors.primaryColor,
        //                           onPressed: () {},
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 )),
        //             SizedBox(height: 10),

        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}
