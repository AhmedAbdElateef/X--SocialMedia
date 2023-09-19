import 'package:hive/hive.dart';
//------------------------------
part 'user.g.dart';
//-----------------

@HiveType(typeId: 1)
class SocialXUser extends HiveObject {
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? address;
  @HiveField(3)
  String? imageUrl;
  @HiveField(4)
  String? instagramLink;
  @HiveField(5)
  String? personalWebsiteLink;
  @HiveField(6)
  String? phoneNumber;
  @HiveField(7)
  String? facebookLink;
  @HiveField(8)
  String? email;
  @HiveField(9)
  String? bio;

  // default constructor to make hive generate code without problems.
  SocialXUser();

  SocialXUser.fromJson(Map json) {
    bio = json["bio"];
    email = json["email"];
    name = json["user_name"];
    address = json["address"];
    imageUrl = json["image_url"];
    phoneNumber = json["phone_number"];
    facebookLink = json["facebook_link"];
    instagramLink = json["instagram_link"];
    personalWebsiteLink = json["personal_website_link"];
  }

  Map<String, Object?> toJson() {
    return {
      "bio": bio,
      "email": email,
      "user_name": name,
      "address": address,
      "image_url": imageUrl,
      "phone_number": phoneNumber,
      "facebook_link": facebookLink,
      "instagram_link": instagramLink,
      "personal_website_link": personalWebsiteLink,
    };
  }

  SocialXUser.newUser({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });
}
