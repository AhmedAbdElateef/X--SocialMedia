import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
//--------------------------------------------------------
import 'package:social_x/core/helpers/extensions/themes_helper.dart';
import 'package:social_x/core/ui/styles.dart';
import 'package:social_x/modules/posts/views/screens/posts_screen.dart';
import 'package:social_x/modules/posts/views/screens/post_form_screen.dart';
import 'package:social_x/modules/profile/views/screens/profile_screen.dart';
import 'package:social_x/modules/settings/views/screens/settings_drawer.dart';
import 'package:social_x/modules/nearby_map/views/screens/nearby_screen.dart';
import 'package:social_x/modules/notifications/views/screens/notifications_screen.dart';
//--------------------------------------------------------------------------------------

final pageController = PageController();
late final TabController tabController;

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: const SettingDrawer(),
        drawerEnableOpenDragGesture: false,
        body: PageView.builder(
          itemCount: 5,
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          itemBuilder: (_, i) {
            return const [
              PostsScreen(),
              NearbyScreen(),
              PostFormScreen(),
              NotificationsScreen(),
              ProfileScreen(),
            ][i];
          },
        ),
        bottomNavigationBar: StyleProvider(
          style: NavIconsStyle(),
          child: ConvexAppBar(
            disableDefaultTabController: true,
            controller: tabController,
            onTap: (int i) {
              pageController.jumpToPage(i);
            },
            height: 60.0,
            activeColor: Colors.white,
            backgroundColor: context.darkMoodEnabled
                ? Colors.black
                : Theme.of(context).primaryColor,
            elevation: 5.0,
            initialActiveIndex: 0,
            items: const [
              TabItem(icon: Icons.home_outlined),
              TabItem(icon: Icons.public_outlined),
              TabItem(icon: Icons.add_circle_outline_outlined),
              TabItem(icon: Icons.notifications_active_outlined),
              TabItem(icon: Icons.person_2_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
