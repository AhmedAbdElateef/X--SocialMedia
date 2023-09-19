import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:social_x/core/helpers/extensions/themes_helper.dart';
//--------------------------------------------------------------------------------------
import 'package:social_x/core/ui/colors.dart';
import 'package:social_x/core/ui/styles.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
//--------------------------------------------------------------
import 'package:social_x/modules/posts/models/posts_query.dart';
//--------------------------------------------------------------

class PostsTabBar extends StatelessWidget {
  final PostsQuery selectedQuery;

  final ValueChanged<PostsQuery> onTabChanged;

  const PostsTabBar({
    super.key,
    required this.selectedQuery,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: CustomSlidingSegmentedControl<PostsQuery>(
        initialValue: selectedQuery,
        isStretch: true,
        clipBehavior: Clip.hardEdge,
        children: {
          PostsQuery.feeds: TabBarText(
            text: context.localizations.feeds,
            isActive: selectedQuery == PostsQuery.feeds,
          ),
          PostsQuery.trending: TabBarText(
            text: context.localizations.trending,
            isActive: selectedQuery == PostsQuery.trending,
          ),
        },
        decoration: BoxDecoration(
          color: context.darkMoodEnabled ? AppColors.bgBlack : Colors.white,
        ),
        thumbDecoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        duration: AppStyles.animationDuration,
        curve: Curves.ease,
        onValueChanged: onTabChanged,
      ),
    );
  }
}

class TabBarText extends StatelessWidget {
  final bool isActive;

  final String text;

  const TabBarText({
    super.key,
    required this.text,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: TextStyle(
          color: isActive
              ? Theme.of(context).primaryColor
              : (context.darkMoodEnabled ? Colors.white : AppColors.bgBlack),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
