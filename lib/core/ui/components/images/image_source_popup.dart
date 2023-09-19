// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:image_picker/image_picker.dart';
// //----------------------------------------------
// import 'package:social_x/core/helpers/extensions/sailor.dart';
// import 'package:social_x/core/models/image_picker_result.dart';
// import 'package:social_x/core/helpers/functions/image_picker_tool.dart';
// //----------------------------------------------------------------------
//
// Future<ImagePickerResult> showImageSourcePopup(
//   BuildContext context, {
//   required String title,
//   required String cameraOptionText,
//   required String galleryOptionText,
//   required String cancelOptionText,
//   required Color overlayColor,
// }) async {
//   ImagePickerResult? pickerResult = await showCupertinoModalPopup(
//     context: context,
//     barrierColor: overlayColor,
//     builder: (context) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 7.0),
//         child: CupertinoActionSheet(
//           title: Text(
//             title,
//             style: TextStyle(
//               fontSize: 16.0,
//               fontWeight: FontWeight.bold,
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//           actions: [
//             CupertinoActionSheetAction(
//               child: Text(
//                 cameraOptionText,
//                 style: TextStyle(
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.bold,
//                   color: Theme.of(context).colorScheme.secondary,
//                 ),
//               ),
//               onPressed: () {
//                 ImagePickerTool().pick(ImageSource.camera).then((result) {
//                   Sailor.back(result);
//                 });
//               },
//             ),
//             CupertinoActionSheetAction(
//               child: Text(
//                 galleryOptionText,
//                 style: TextStyle(
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.bold,
//                   color: Theme.of(context).colorScheme.secondary,
//                 ),
//               ),
//               onPressed: () {
//                 ImagePickerTool().pick(ImageSource.gallery).then((result) {
//                   Sailor.back(result);
//                 });
//               },
//             )
//           ],
//           cancelButton: CupertinoActionSheetAction(
//             isDestructiveAction: true,
//             child: Text(
//               cancelOptionText,
//               style: const TextStyle(
//                 fontSize: 16.0,
//                 color: Colors.red,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onPressed: () {
//               Sailor.back(ImagePickerCanceledByUser());
//             },
//           ),
//         ),
//       );
//     },
//   );
//
//   return pickerResult ?? ImagePickerCanceledByUser();
// }
