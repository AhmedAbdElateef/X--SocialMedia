import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_x/core/constants/errors.dart';
import 'package:social_x/core/models/http_client_result.dart';
import 'package:social_x/modules/auth/models/user.dart';

class UsersClient {
  final _loggedInUser = FirebaseAuth.instance.currentUser!;

  CollectionReference get _users {
    return FirebaseFirestore.instance.collection("users");
  }

  Future<HttpClientResult> fetchAllUsers(bool fromCache) async {
    try {
      final usersQuery = await _users
          .where(
            FieldPath.documentId,
            isNotEqualTo: _loggedInUser.uid,
          )
          .get(
            GetOptions(
              source: fromCache ? Source.cache : Source.server,
            ),
          );
      final users = usersQuery.docs.map((userDoc) {
        return SocialXUser.fromJson(userDoc.data() as Map);
      }).toList();
      return SuccessfulRequest(users);
    } catch (_) {
      return FailedRequest(AppErrors.networkError);
    }
  }
}
