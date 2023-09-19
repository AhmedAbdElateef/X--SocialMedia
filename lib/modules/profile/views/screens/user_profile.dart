import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/core/helpers/extensions/sailor.dart';
import 'package:social_x/core/helpers/extensions/themes_helper.dart';
//--------------------------------------------
import 'package:social_x/core/ui/colors.dart';
import 'package:social_x/core/ui/components/buttons/action_button.dart';
import 'package:social_x/core/ui/components/images/cached_network_image.dart';
import 'package:social_x/core/ui/components/loaders/circular_loading_indicator.dart';
import 'package:social_x/core/ui/routes.dart';
import 'package:social_x/core/ui/styles.dart';
import 'package:social_x/modules/posts/helpers/firebase_image_url.dart';
import 'package:social_x/modules/posts/models/post.dart';
import 'package:social_x/modules/posts/views/widgets/post_item.dart';
import 'package:social_x/modules/posts/views/widgets/posts_shimmer_loading.dart';
import 'package:social_x/modules/profile/view_models/bulk_users_provider.dart';
import 'package:social_x/modules/profile/view_models/profile_controller.dart';
import 'package:social_x/modules/profile/view_models/single_user_provider.dart';
//---------------------------------------------------------------------
import 'package:social_x/modules/profile/views/widgets/oval_bottom_clipper.dart';
//-------------------------------------------------------------------------------

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ModalRoute.of(context)!.settings.arguments as String;
    final controller = ProfileController();
    var r = ref.watch(singleUserProvider(userId));
    return Scaffold(
      body: r.when(
        loading: () => const CircularLoadingIndicator(),
        data: (user) => ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                ClipPath(
                  clipper: OvalBottomClipper(),
                  child: Container(
                    height: 170.0,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/profile_header.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -60,
                  child: CircleAvatar(
                    backgroundColor:
                        context.darkMoodEnabled ? Colors.black : Colors.white,
                    radius: 65,
                    child: ClipOval(
                      child: getCachedImage(getUserImageUrl(userId),
                          height: 120,
                          width: 120,
                          fallbackImageName: "default.png"),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 16,
                  child: Builder(
                    builder: (_) {
                      var r = ref.watch(isFollowingProvider(userId));
                      return r.when(
                        data: (isFollowing) => ActionButton(
                          onAction: () {},
                          text: isFollowing
                              ? context.localizations.unFollow
                              : context.localizations.follow,
                          wrapParent: true,
                          buttonHeight: 35,
                          buttonColor: context.darkMoodEnabled
                              ? Colors.black
                              : Colors.white,
                          textColor: context.darkMoodEnabled
                              ? Colors.white
                              : Colors.black,
                        ),
                        error: (_, __) => const SizedBox(),
                        loading: () => const CircularLoadingIndicator(),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: IconButton(
                      onPressed: () {
                        Sailor.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: context.darkMoodEnabled
                            ? Colors.white
                            : Colors.black,
                      )),
                )
              ],
            ),
            const SizedBox(height: 76),
            Text(
              user.name.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            if (user.address?.isNotEmpty ?? false) ...[
              Text(
                user.address!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 8),
            ],
            if (user.bio?.isNotEmpty ?? false)
              Text(
                user.bio!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            if (user.phoneNumber?.isNotEmpty ?? false) ...[
              const SizedBox(height: 8),
              Text(
                user.phoneNumber!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.darkMoodEnabled
                    ? AppColors.bgBlack
                    : AppColors.grey10,
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20.0),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Builder(
                      builder: (_) {
                        var provider = ref.watch(followersProvider(userId));
                        return provider.when(
                          data: (followersIds) {
                            return TextButton(
                              onPressed: () {
                                Sailor.toNamed(
                                  AppRoutes.users,
                                  routeArgs: {
                                    "user_ids": followersIds,
                                    "title": context.localizations.followers,
                                  },
                                );
                              },
                              child: Text.rich(
                                TextSpan(
                                  text: "${followersIds.length}  ",
                                  children: [
                                    TextSpan(
                                      text: context.localizations.followers,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.grey70,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: context.darkMoodEnabled
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            );
                          },
                          error: (_, __) {
                            return const TextButton(
                              onPressed: null,
                              child: Text("???"),
                            );
                          },
                          loading: () => const CircularLoadingIndicator(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: Builder(
                      builder: (_) {
                        var provider = ref.watch(followingProvider(userId));
                        return provider.when(
                          data: (followingIds) {
                            return TextButton(
                              onPressed: () {
                                Sailor.toNamed(
                                  AppRoutes.users,
                                  routeArgs: {
                                    "user_ids": followingIds,
                                    "title": context.localizations.following,
                                  },
                                );
                              },
                              child: Text.rich(
                                TextSpan(
                                  text: "${followingIds.length}  ",
                                  children: [
                                    TextSpan(
                                      text: context.localizations.following,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.grey70,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: context.darkMoodEnabled
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            );
                          },
                          error: (e, s) {
                            return const TextButton(
                              onPressed: null,
                              child: Text("???"),
                            );
                          },
                          loading: () => const CircularLoadingIndicator(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (user.facebookLink?.isNotEmpty ?? false) ...[
                  IconButton(
                    onPressed: () {
                      controller.launchSocialLink(user.facebookLink!);
                    },
                    icon:
                        SvgPicture.asset("assets/icons/facebook_outlined.svg"),
                  ),
                  const SizedBox(width: 20.0),
                ],
                if (user.instagramLink?.isNotEmpty ?? false) ...[
                  IconButton(
                    onPressed: () {
                      controller.launchSocialLink(user.instagramLink!);
                    },
                    icon: SvgPicture.asset("assets/icons/instagram.svg"),
                  ),
                  const SizedBox(width: 20.0),
                ],
                if (user.personalWebsiteLink?.isNotEmpty ?? false)
                  IconButton(
                    onPressed: () {
                      controller.launchSocialLink(user.personalWebsiteLink!);
                    },
                    icon: SvgPicture.asset("assets/icons/web.svg"),
                  ),
              ],
            ),
            FirestoreListView(
              pageSize: 10,
              shrinkWrap: true,
              query: controller.clientQuery,
              padding: EdgeInsets.only(
                bottom: AppStyles.screenBottomSpace.height!,
              ),
              physics: const NeverScrollableScrollPhysics(),
              loadingBuilder: (_) => const PostsShimmerLoading(),
              itemBuilder: (_, postDoc) {
                return Container(
                  color: context.darkMoodEnabled
                      ? AppColors.grey85
                      : AppColors.grey25,
                  margin: const EdgeInsets.only(bottom: 6),
                  child: PostItem(
                    shareable: false,
                    isSavedPost: false,
                    post: postDoc.data() as Post,
                    onTap: () => Sailor.toNamed(AppRoutes.postDetails),
                  ),
                );
              },
            ),
          ],
        ),
        error: (error, stackTrace) => const SizedBox(),
      ),
    );
  }
}
