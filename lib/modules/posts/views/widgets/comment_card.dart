import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/core/helpers/extensions/themes_helper.dart';
import 'package:social_x/core/helpers/functions/time_ago_util.dart';
//-------------------------------------
import 'package:social_x/core/ui/colors.dart';
import 'package:social_x/core/ui/components/images/cached_network_image.dart';
import 'package:social_x/modules/posts/helpers/firebase_image_url.dart';
import 'package:social_x/modules/posts/models/comment.dart';
//--------------------------------------------

class CommentCard extends StatelessWidget {
  final Comment comment;

  final VoidCallback onDelete;

  const CommentCard({
    super.key,
    required this.comment,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final loggedInUser = FirebaseAuth.instance.currentUser!;
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.darkMoodEnabled ? AppColors.bgBlack : AppColors.grey25,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Row(
              children: [
                ClipOval(
                  child: getCachedImage(
                    getUserImageUrl(comment.userId!),
                    height: 45.0,
                    width: 45.0,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.userName!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      comment.text!,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      TimeAgoUtil().formatTime(
                        comment.lastUpdated!,
                        context.langCode,
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (comment.userId == loggedInUser.uid)
              Positioned.directional(
                textDirection: TextDirection.ltr,
                end: 3,
                top: 3,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onDelete,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SvgPicture.asset(
                        "assets/icons/delete_cross.svg",
                        height: 10.0,
                        width: 10.0,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
