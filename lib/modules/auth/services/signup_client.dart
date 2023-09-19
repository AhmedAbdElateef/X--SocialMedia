import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//----------------------------------------------------
import 'package:social_x/core/constants/errors.dart';
import 'package:social_x/modules/auth/models/user.dart';
import 'package:social_x/core/constants/hive_boxes.dart';
import 'package:social_x/core/models/http_client_result.dart';
//------------------------------------------------------------

class SignupClient {
  final _auth = FirebaseAuth.instance;
  final _cachedData = HiveBoxes.prefsBox;

  CollectionReference get _users {
    return FirebaseFirestore.instance.collection("users");
  }

  Future<HttpClientResult> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String userName,
    required String phone,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _saveUserData(
        userId: userCredential.user!.uid,
        phoneNumber: phone,
        userName: userName,
        email: email,
      );

      return SuccessfulRequest();
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return FailedRequest(AppErrors.emailAlreadyExists);
      } else {
        return FailedRequest(AppErrors.networkError);
      }
    }
  }

  /// saves user data on firestore and hive local database.
  Future<HttpClientResult> _saveUserData({
    required String userId,
    required String email,
    required String userName,
    required String phoneNumber,
  }) async {
    try {
      await _users.doc(userId).set({
        "user_name": userName,
        "phone_number": phoneNumber,
        "email": email,
        "online": true,
      });

      await _cachedData.put(
        HiveBoxes.userCredentialsKey,
        SocialXUser.newUser(
          name: userName,
          email: email,
          phoneNumber: phoneNumber,
        ),
      );
      return SuccessfulRequest();
    } on FirebaseAuthException catch (_) {
      return FailedRequest(AppErrors.networkError);
    }
  }
}
