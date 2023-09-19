import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:social_x/modules/posts/models/posts_query.dart';
import 'package:social_x/modules/posts/services/posts_client.dart';
//-----------------------------------------------------------------

final postsTabProvider = ChangeNotifierProvider((_) {
  return PostsTabNotifier();
});

class PostsTabNotifier extends ChangeNotifier {
  var selectedPostsQuery = PostsQuery.feeds;

  final _client = PostsClient();

  Query get clientQuery => _client.getQuery(selectedPostsQuery);

  void changePostsTab(PostsQuery newQuery) {
    selectedPostsQuery = newQuery;
    notifyListeners();
  }
}
