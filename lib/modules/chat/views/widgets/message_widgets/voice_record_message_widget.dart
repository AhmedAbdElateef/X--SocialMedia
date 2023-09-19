// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// //------------------------------------------------------
//
// class VoiceRecordMessageWidget extends StatelessWidget {
//   final bool selfMessage;
//
//   final int recordDurationInSeconds;
//
//   final String recordUrl;
//
//   const VoiceRecordMessageWidget({
//     super.key,
//     required this.selfMessage,
//     required this.recordDurationInSeconds,
//     required this.recordUrl,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     bool isUploading = recordUrl == "uploading";
//     return Directionality(
//       textDirection: TextDirection.ltr,
//       child: GestureDetector(
//         onTap: () => notifier.handleMessageGestureTap(recordUrl),
//         child: Container(
//           width: MediaQuery.of(context).size.width * 0.5,
//           height: 40.0,
//           padding: const EdgeInsets.symmetric(
//             horizontal: 12.0,
//             vertical: 8.0,
//           ),
//           decoration: BoxDecoration(
//             color: selfMessage ? Palette.shuttleGray : Palette.burntSienna,
//             borderRadius: BorderRadius.circular(
//               SharedStyles.largeComponentsRadius,
//             ),
//           ),
//           child: Consumer(
//             builder: (_, watch, __) {
//               var watcher = watch(voiceRecordProvider(recordDurationInSeconds));
//               Duration duration = watcher.recordDurationCounter;
//               bool isPlaying = watcher.isPlaying;
//               return Row(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white,
//                     ),
//                     child: Transform.scale(
//                       scale: isUploading ? 0.6 : 0.75,
//                       child: isUploading
//                           ? CircularLoadingIndicator(size: 22.0)
//                           : Icon(
//                               isPlaying ? Icons.pause : Icons.play_arrow,
//                               color: selfMessage
//                                   ? Palette.shuttleGray
//                                   : Palette.burntSienna,
//                               size: 22.0,
//                             ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       height: 1.5,
//                       color: Colors.white,
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(
//                         SharedStyles.largeComponentsRadius,
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         duration.stringFormat,
//                         style: TextStyle(
//                           height: 1.0,
//                           fontSize: 13.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
