import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//--------------------------------------------
import 'package:social_x/core/ui/routes.dart';
import 'package:social_x/core/helpers/extensions/sailor.dart';
//-------------------------------------------------
import 'package:social_x/core/ui/components/images/cached_network_image.dart';
//---------------------------------------------------------------------

class ChatRoomItem extends StatelessWidget {
  const ChatRoomItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Sailor.toNamed(AppRoutes.privateRoom),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              ClipOval(
                child: getCachedImage(
                  "https://scontent.faly1-4.fna.fbcdn.net/v/t39.30808-1/357733484_234261812803881_663862537226195691_n.jpg?stp=dst-jpg_p160x160&_nc_cat=111&ccb=1-7&_nc_sid=7206a8&_nc_eui2=AeGsk-XxpzOu5BA_yDsFNHFth7jI52fIPgiHuMjnZ8g-COYf4YR3crHPsFw7crcXl6z2lfrJhHthHCJSsAdjk02H&_nc_ohc=rr2w4hx3jv0AX9Gck_L&_nc_ht=scontent.faly1-4.fna&oh=00_AfA0JjCDtpqeQYTzsZsPCvBX8njzbGRymeuiuTOkaU_mlg&oe=64F1B221",
                  height: 45.0,
                  width: 45.0,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ahmed Mohamed",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text(
                      "UserMessage",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "2 minutes ago",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "20",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(width: 6),
                        SvgPicture.asset(
                          "assets/icons/chat.svg",
                          height: 15,
                          width: 15,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
