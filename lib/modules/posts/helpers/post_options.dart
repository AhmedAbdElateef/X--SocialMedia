import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_x/core/constants/hive_boxes.dart';
import 'package:social_x/modules/posts/models/post_option.dart';
//--------------------------------------------------------------

List<PostOption> resolvePostOptions({
  required String postOwnerId,
  required String postId,
}) {
  final loggedInUser = FirebaseAuth.instance.currentUser!;
  bool showRestrictedOptions = loggedInUser.uid == postOwnerId;

  return [
    _isSavedPost(postId) ? PostOption("unsave") : PostOption("save"),
    if (showRestrictedOptions) PostOption("edit"),
    if (showRestrictedOptions) PostOption("delete"),
  ];
}

bool _isSavedPost(String postId) {
  bool result = false;
  final savedPosts = HiveBoxes.savedPostsBox.values;
  for (var post in savedPosts) {
    if (post.id == postId) return true;
  }
  return result;
}
