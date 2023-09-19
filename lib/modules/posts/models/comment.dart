class Comment {
  int? likes;

  String? id;
  String? text;
  String? userId;
  String? userName;

  DateTime? lastUpdated;

  Comment.fromJson({
    required String docId,
    required Map data,
  }) {
    id = docId;
    text = data["text"];
    likes = data["likes"];
    userId = data["user_id"];
    userName = data["user_name"];
    lastUpdated = DateTime.fromMillisecondsSinceEpoch(data["last_updated"]);
  }

  Comment.fromUserInput({
    required String id,
    required String name,
    required String comment,
  }) {
    text = comment;
    userName = name;
    userId = id;
    likes = 0;
    lastUpdated = DateTime.now();
  }

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "likes": likes,
      "user_name": userName,
      "user_id": userId,
      "last_updated": lastUpdated?.millisecondsSinceEpoch,
    };
  }
}
