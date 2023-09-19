import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_x/core/helpers/extensions/firestore_objects_converter.dart';
//----------------------------------------------------
import 'package:social_x/modules/auth/models/user.dart';
//------------------------------------------------------

class SingleUserClient {
  CollectionReference get _users {
    return FirebaseFirestore.instance.collection("users").adaptiveUsers();
  }

  Future<SocialXUser> fetchUserData(String userId) async {
    final userDoc = await _users.doc(userId).get();
    return userDoc.data() as SocialXUser;
  }
}
