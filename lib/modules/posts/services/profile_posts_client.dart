import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_x/core/helpers/extensions/firestore_objects_converter.dart';

class ProfilePostsClient {
  final _loggedInUser = FirebaseAuth.instance.currentUser!;

  CollectionReference get _posts {
    return FirebaseFirestore.instance.collection("posts").adaptivePosts();
  }

  Query get query {
    return _posts
        .where(
          Filter.or(
            Filter("user_id", isEqualTo: _loggedInUser.uid),
            Filter("shares", arrayContains: _loggedInUser.uid),
          ),
        )
        .orderBy("last_updated", descending: true);
  }
}
