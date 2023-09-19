import 'package:flutter/material.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/core/helpers/extensions/sailor.dart';
import 'package:social_x/core/ui/components/images/cached_network_image.dart';
import 'package:social_x/core/ui/routes.dart';
import 'package:social_x/modules/posts/models/post.dart';
import 'package:social_x/modules/posts/views/widgets/post_item_widgets/post_video.dart';
//-------------------------------------

class PostItemBody extends StatelessWidget {
  final Post post;

  final VoidCallback? onTap;

  const PostItemBody({
    super.key,
    required this.post,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (post.text != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Align(
              alignment: context.langCode == "ar"
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: SelectableText(
                post.text!,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
        if (post.imageUrl != null)
          getCachedImage(
            post.imageUrl!,
            fallbackImageName: "post_error_image.png",
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        if (post.videoUrl != null) PostVideo(videoUrl: post.videoUrl!),
        if (post.likes!.isNotEmpty)
          TextButton(
            onPressed: () {
              Sailor.toNamed(
                AppRoutes.users,
                routeArgs: {
                  "user_ids": post.likes!,
                  "title": context.localizations.likes,
                },
              );
            },
            child: Text(
              context.localizations.userLikes,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
      ],
    );
  }
}
