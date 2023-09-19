import 'package:hive/hive.dart';
//------------------------------
part 'post.g.dart';
//-----------------

@HiveType(typeId: 2)
class Post extends HiveObject {
  @HiveField(1)
  List? likes;
  @HiveField(3)
  int? commentsCount;

  @HiveField(4)
  String? id;
  @HiveField(5)
  String? text;
  @HiveField(6)
  String? userId;
  @HiveField(7)
  String? imageUrl;
  @HiveField(8)
  String? videoUrl;

  @HiveField(2)
  List? shares;

  @HiveField(9)
  DateTime? lastUpdated;

  Post();

  Post.fromJson({
    required String docId,
    required Map data,
  }) {
    id = docId;
    likes = data["likes"] ?? [];
    shares = data["shares"] ?? [];
    commentsCount = data["comments_count"];
    text = data["text"];
    userId = data["user_id"];
    imageUrl = data["image_url"];
    videoUrl = data["video_url"];
    lastUpdated = DateTime.fromMillisecondsSinceEpoch(data["last_updated"]);
  }

  Post.fromUserForm(Map form) {
    text = form["text"];
    userId = form["user_id"];
    imageUrl = form["image_url"];
    videoUrl = form["video_url"];
    lastUpdated = DateTime.now();
  }

  Map<String, dynamic> toJson() {
    return {
      "likes": likes,
      "shares": shares,
      "comments_count": commentsCount,
      "text": text,
      "user_id": userId,
      "image_url": imageUrl,
      "video_url": videoUrl,
      "last_updated": lastUpdated?.millisecondsSinceEpoch,
    };
  }
}
