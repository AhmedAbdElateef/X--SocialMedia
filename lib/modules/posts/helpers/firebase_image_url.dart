import 'package:social_x/core/constants/firebase_storage.dart';
//-------------------------------------------------------------

String getUserImageUrl(String userId) {
  return "${FirebaseStorageConstants.usersImageUrl}/$userId.jpg";
}
