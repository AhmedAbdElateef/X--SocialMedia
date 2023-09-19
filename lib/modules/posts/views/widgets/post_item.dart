import 'package:flutter/material.dart';
import 'package:social_x/core/helpers/extensions/themes_helper.dart';
//------------------------------------------------------
//---------------------------------------------------------------------
import 'package:social_x/modules/posts/models/post.dart';
import 'package:social_x/modules/posts/views/widgets/post_item_widgets/body.dart';
import 'package:social_x/modules/posts/views/widgets/post_item_widgets/buttons.dart';
import 'package:social_x/modules/posts/views/widgets/post_item_widgets/header.dart';
//------------------------------------------------------------------------------

class PostItem extends StatelessWidget {
  final bool showCommentIcon;
  final bool isSavedPost;
  final bool shareable;

  final Post post;

  final VoidCallback? onTap;

  const PostItem({
    super.key,
    required this.isSavedPost,
    this.showCommentIcon = true,
    this.shareable = true,
    required this.post,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: context.darkMoodEnabled ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          PostItemHeader(
            post: post,
            isSavedPost: isSavedPost,
          ),
          PostItemBody(
            post: post,
            onTap: onTap,
          ),
          PostItemButtons(
            shareable: shareable,
            areButtonsActivated: !isSavedPost,
            post: post,
            showCommentButton: showCommentIcon,
          ),
        ],
      ),
    );
  }
}
