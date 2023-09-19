import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/core/helpers/extensions/sailor.dart';
import 'package:social_x/core/helpers/extensions/themes_helper.dart';
import 'package:social_x/core/ui/routes.dart';
import 'package:social_x/core/ui/styles.dart';
import 'package:social_x/modules/posts/view_models/users_search_notifier.dart';
import 'package:social_x/modules/posts/views/widgets/user_card.dart';

class FloatingSearchBarWidget extends ConsumerStatefulWidget {
  const FloatingSearchBarWidget({super.key});

  @override
  FloatingSearchBarWidgetState createState() => FloatingSearchBarWidgetState();
}

class FloatingSearchBarWidgetState
    extends ConsumerState<FloatingSearchBarWidget> {
  late UsersNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = ref.read(usersProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _notifier.getAllUsers(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      elevation: 0.0,
      padding: const EdgeInsets.symmetric(
        horizontal: AppStyles.componentsPadding,
      ),
      margins: const EdgeInsets.only(top: 10),
      borderRadius: BorderRadius.circular(16),
      backdropColor: context.darkMoodEnabled ? Colors.black : Colors.white,
      backgroundColor: context.darkMoodEnabled ? Colors.black : Colors.white,
      hintStyle: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20,
      ),
      iconColor: Theme.of(context).primaryColor,
      hint: context.localizations.search,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: 0.0,
      openAxisAlignment: 0.0,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (String newQuery) {
        ref.read(usersProvider).changeSearchKeywordState(newQuery);
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Sailor.toNamed(AppRoutes.chatRooms);
          },
          icon: SvgPicture.asset(
            "assets/icons/send.svg",
            height: 20.0,
            colorFilter: ColorFilter.mode(
              Theme.of(context).primaryColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
      builder: (_, __) {
        return Consumer(
          builder: (_, ref, __) {
            var users = ref.watch(usersSearchProvider);
            return Column(
              children: users.map((user) {
                return UserCard(user: user);
              }).toList(),
            );
          },
        );
      },
    );
  }
}
