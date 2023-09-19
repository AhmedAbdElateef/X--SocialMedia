import 'package:cloud_firestore/cloud_firestore.dart';
//----------------------------------------------------
import 'package:social_x/core/helpers/extensions/firestore_objects_converter.dart';
//----------------------------------------------------------------------
import 'package:social_x/modules/posts/models/posts_query.dart';
//--------------------------------------------------------------

class PostsClient {
  CollectionReference get _posts {
    return FirebaseFirestore.instance.collection("posts").adaptivePosts();
  }

  Query getQuery(PostsQuery query) {
    var clientQuery = _posts.orderBy(
      "last_updated",
      descending: true,
    );

    if (query == PostsQuery.trending) {
      clientQuery = _posts.orderBy("likes", descending: true);
    }

    return clientQuery;
  }
}
