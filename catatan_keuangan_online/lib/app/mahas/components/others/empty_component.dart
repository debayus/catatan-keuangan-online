// import 'package:flutter/material.dart';
// import 'package:generalledger/app/mahas/components/others/text_component.dart';
// import 'package:generalledger/app/mahas/icons/font_awesome5_icons.dart';
// import 'package:generalledger/app/mahas/my_config.dart';

// class EmptyComponent extends StatelessWidget {
//   final VoidCallback? onPressed;

//   const EmptyComponent({
//     Key? key,
//     this.onPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Icon(
//             FontAwesomeIcons.box_open,
//             color: MyConfig.primaryColor.shade600,
//             size: 40,
//           ),
//           Padding(padding: EdgeInsets.all(5)),
//           Text("No Item Found"),
//           Padding(padding: EdgeInsets.all(5)),
//           Visibility(
//             visible: onPressed != null,
//             child: TextButton(
//               onPressed: onPressed,
//               child: Text(
//                 "Refresh",
//                 color: Colors.lightBlue,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
