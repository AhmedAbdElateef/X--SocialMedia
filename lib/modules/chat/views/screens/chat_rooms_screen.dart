import 'package:flutter/material.dart';
//-------------------------------------
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_x/core/helpers/extensions/themes_helper.dart';
//--------------------------------------------
import 'package:social_x/core/ui/styles.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/core/ui/components/layouts/screen_header.dart';
//--------------------------------------------------------------
import 'package:social_x/modules/chat/views/widgets/chat_room_item.dart';
//-----------------------------------------------------------------------

class ChatRoomsScreen extends StatelessWidget {
  const ChatRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ScreenHeader(
          title: context.localizations.messages,
          trailing: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/edit_square.svg",
              height: 25,
              width: 25,
              colorFilter: ColorFilter.mode(
                context.darkMoodEnabled ? Colors.white : Colors.black,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppStyles.screensHorizontalPadding,
          ),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) {
              if (index == 8) return const SizedBox(height: 30.0);

              return const ChatRoomItem();
            },
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemCount: 7 + 2,
          ),
        ),
      ),
    );
  }
}
