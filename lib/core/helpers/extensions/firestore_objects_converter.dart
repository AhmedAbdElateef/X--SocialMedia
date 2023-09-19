import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_x/modules/auth/models/user.dart';
import 'package:social_x/modules/posts/models/comment.dart';
//----------------------------------------------------
import 'package:social_x/modules/posts/models/post.dart';
import 'package:social_x/modules/notifications/models/notification.dart';
//-----------------------------------------------------------------------

extension JsonConverter on CollectionReference {
  CollectionReference adaptivePosts() {
    return withConverter<Post>(
      fromFirestore: (snapshot, _) => Post.fromJson(
        docId: snapshot.id,
        data: snapshot.data()!,
      ),
      toFirestore: (post, _) => post.toJson(),
    );
  }

  CollectionReference adaptiveNotifications() {
    return withConverter<Notification>(
      fromFirestore: (snapshot, _) => Notification.fromJson(snapshot.data()!),
      toFirestore: (notification, _) => notification.toJson(),
    );
  }

  CollectionReference adaptiveComments() {
    return withConverter<Comment>(
      fromFirestore: (snapshot, _) => Comment.fromJson(
        docId: snapshot.id,
        data: snapshot.data()!,
      ),
      toFirestore: (comment, _) => comment.toJson(),
    );
  }

  CollectionReference adaptiveUsers() {
    return withConverter<SocialXUser>(
      fromFirestore: (snapshot, _) => SocialXUser.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    );
  }
}
