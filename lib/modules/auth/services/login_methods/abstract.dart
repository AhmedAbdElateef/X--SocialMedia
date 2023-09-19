library login_methods;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//----------------------------------------------------------------
import 'package:social_x/core/constants/errors.dart';
import 'package:social_x/core/constants/hive_boxes.dart';
import 'package:social_x/core/models/http_client_result.dart';
//------------------------------------------------------------
import 'package:social_x/modules/auth/models/user.dart';
//------------------------------------------------------
part 'email_impl.dart';
part 'google_impl.dart';
part 'facebook_impl.dart';
//------------------------

abstract class LoginMethod {
  final _auth = FirebaseAuth.instance;
  final _cachedData = HiveBoxes.prefsBox;

  CollectionReference get _users {
    return FirebaseFirestore.instance.collection("users");
  }

  Future<HttpClientResult> login() async {
    try {
      final authCredential = await _getAuthCredential();
      if (authCredential != null) {
        final loggedInUserId = await _addToFirebaseAuth(authCredential);
        await _cacheUserData(loggedInUserId);
        return SuccessfulRequest();
      } else {
        return FailedRequest(AppErrors.userCanceledLogin);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email" || e.code == "wrong-password") {
        return FailedRequest(AppErrors.invalidCredentials);
      } else if (e.code == "user-not-found") {
        return FailedRequest(AppErrors.userNotFound);
      } else if (e.code == "account-exists-with-different-credential") {
        return FailedRequest(AppErrors.wrongLoginMethod);
      }

      return FailedRequest("");
    } catch (_) {
      // print(e);
      // print(stackTrace);
      return FailedRequest(AppErrors.networkError);
    }
  }

  Future<AuthCredential?> _getAuthCredential();

  Future<String> _addToFirebaseAuth(AuthCredential credential) async {
    final result = await _auth.signInWithCredential(credential);
    return result.user!.uid;
  }

  Future<void> _cacheUserData(String userId) async {
    var userDoc = await _users.doc(userId).get();

    // [userDoc.exists] equals false when user used social login.
    if (!userDoc.exists) {
      await _uploadUserDataToFirestore(userId);
      userDoc = await _users.doc(userId).get();
    }
    final userData = SocialXUser.fromJson(userDoc.data() as Map);
    await _cachedData.put(HiveBoxes.userCredentialsKey, userData);
  }

  Future<void> _uploadUserDataToFirestore(String userId) async {
    final loggedInUser = _auth.currentUser!;
    await _users.doc(userId).set({
      "user_name": loggedInUser.displayName,
      "phone_number": loggedInUser.phoneNumber,
      "email": loggedInUser.email,
      "online": true,
    });
  }
}
