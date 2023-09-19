import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_x/core/helpers/extensions/firestore_objects_converter.dart';
import 'package:social_x/modules/auth/models/user.dart';

class BulkUsersClient {
  CollectionReference get _users {
    return FirebaseFirestore.instance.collection("users").adaptiveUsers();
  }

  Future<List<SocialXUser>> fetchUsers(List userIds) async {
    if (userIds.isEmpty) return [];

    final usersQuery = await _users
        .where(
          FieldPath.documentId,
          whereIn: userIds,
        )
        .get();

    return usersQuery.docs.map((userDoc) {
      return userDoc.data() as SocialXUser;
    }).toList();
  }
}
