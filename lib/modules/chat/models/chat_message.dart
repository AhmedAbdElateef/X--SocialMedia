class ChatMessage {
  String? imageUrl;
  String? senderId;
  String? senderName;
  String? text;
  String? voiceUrl;

  DateTime? sendDate;

  ChatMessage.fromJson(Map data) {
    imageUrl = data["image_url"];
    senderId = data["sender_id"];
    senderName = data["sender_name"];
    text = data["text"];
    voiceUrl = data["voice_url"];
    sendDate = DateTime.fromMillisecondsSinceEpoch(data["send_date"]);
  }
}
