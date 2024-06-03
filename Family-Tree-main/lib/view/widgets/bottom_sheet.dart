// import 'package:flutter/material.dart';

// class CustomBottomSheet extends StatelessWidget {
//   final Widget Function(BuildContext) builder;
//   final Widget? child;

//   const CustomBottomSheet({
//     Key? key,
//     required this.builder,
//     this.child,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         showModalBottomSheet(
//           context: context,
//           builder: (BuildContext context) {
//             return Container(
//               height: 420,
//               width: 400,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: builder(context),
//             );
//           },
//         );
//       },
//       child: child,
//     );
//   }
// }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// showBottomModalDialog({
//   required BuildContext context,
//   required List<Widget> children,
// }) {
//   showCupertinoModalPopup(
//     context: context,
//     builder: (BuildContext modalContext) => Container(
//       height: MediaQuery.of(context).size.height * 0.5, 
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
//       ),
//       child: Material(
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min, // Adjust to min
//             children: children,
//           ),
//         ),
//       ),
//     ),
//   );
// }
