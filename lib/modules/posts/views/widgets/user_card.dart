import 'package:flutter/material.dart';
import 'package:social_x/core/ui/components/images/cached_network_image.dart';
import 'package:social_x/modules/auth/models/user.dart';
import 'package:social_x/modules/posts/helpers/firebase_image_url.dart';

class UserCard extends StatelessWidget {
  final SocialXUser user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).primaryColor.withOpacity(0.5),
        child: ListTile(
          title: Text(user.name.toString()),
          leading: ClipOval(
            child: getCachedImage(
              getUserImageUrl(user.imageUrl.toString()),
              fallbackImageName: "default.png",
              height: 45,
              width: 45,
            ),
          ),
        ));
  }
}
