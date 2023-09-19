import 'package:flutter/material.dart';
import 'package:social_x/core/helpers/extensions/themes_helper.dart';
import 'package:social_x/core/ui/colors.dart';
//-------------------------------------
import 'package:social_x/core/ui/components/images/cached_network_image.dart';
//---------------------------------------------------------------------

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.darkMoodEnabled
            ? AppColors.bgBlack
            : Theme.of(context).primaryColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            ClipOval(
              child: getCachedImage(
                "https://scontent.faly1-2.fna.fbcdn.net/v/t1.6435-9/68747291_2436943653205421_1651990343555481600_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=174925&_nc_eui2=AeETg9gingHKEolxnPTloiKdHIe4iGt4-skch7iIa3j6yerjH8LPhHkfpWkbSVBvamgZ6NCM1ngndSK3tiD6ck88&_nc_ohc=3quSmO2esCQAX9ZLjFX&_nc_ht=scontent.faly1-2.fna&oh=00_AfAQfVnuH14VWUnUKHYVELTwPqBED0mM8-aTMEp8VPC5sg&oe=6519855C",
                height: 45.0,
                width: 45.0,
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ahmed Mohamed",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "liked",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  " 2 minutes ago",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.secondary),
                )
              ],
            ),
            const Spacer(),
            Image.asset(
              "assets/images/auth_header.jpg",
              width: 80,
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
