import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//--------------------------------------------
import 'package:social_x/core/ui/components/input/x_text_field.dart';
//-------------------------------------------------------------

class ChatRoomBottomBar extends StatelessWidget {
  final String peerId;

  const ChatRoomBottomBar({
    super.key,
    required this.peerId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: "camera",
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              focusElevation: 0.0,
              highlightElevation: 0.0,
              hoverElevation: 0.0,
              child: SvgPicture.asset(
                "assets/icons/camera.svg",
                height: 22.0,
                width: 22.0,
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 5.0),
            const Flexible(
              child: XTextField(
                hintText: "Enter your message",
              ),
            ),
            const SizedBox(width: 5.0),
            FloatingActionButton(
              heroTag: "send",
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              focusElevation: 0.0,
              highlightElevation: 0.0,
              hoverElevation: 0.0,
              child: SvgPicture.asset(
                "assets/icons/send.svg",
                height: 22.0,
                width: 22.0,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
