import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_x/core/constants/errors.dart';
import 'package:social_x/core/helpers/extensions/firestore_objects_converter.dart';
import 'package:social_x/core/models/http_client_result.dart';
import 'package:social_x/modules/auth/models/user.dart';

class ProfileEditClient {
  final _loggedInUser = FirebaseAuth.instance.currentUser!;

  CollectionReference get _users {
    return FirebaseFirestore.instance.collection("users").adaptiveUsers();
  }

  Future<HttpClientResult> editProfile(SocialXUser newUserData) async {
    try {
      await _users.doc(_loggedInUser.uid).update(newUserData.toJson());
      return SuccessfulRequest();
    } catch (_) {
      return FailedRequest(AppErrors.networkError);
    }
  }
}
