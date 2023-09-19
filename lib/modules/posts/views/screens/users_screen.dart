import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_x/core/constants/errors.dart';
import 'package:social_x/core/helpers/functions/clients_error_handler.dart';
import 'package:social_x/core/ui/components/layouts/screen_header.dart';
import 'package:social_x/modules/posts/views/widgets/user_card.dart';
import 'package:social_x/modules/profile/view_models/bulk_users_provider.dart';
//-------------------------------------

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final userIds = args["user_ids"];
    final screenTitle = args["title"];
    return SafeArea(
      child: Scaffold(
        appBar: ScreenHeader(title: screenTitle),
        body: Consumer(
          builder: (_, ref, __) {
            var r = ref.watch(bulkUsersProvider(userIds));
            return r.when(
              loading: () => const CircularProgressIndicator(),
              error: (_, __) {
                handleHttpClientError(context, AppErrors.networkError);
                return const SizedBox();
              },
              data: (users) {
                return ListView.separated(
                  itemCount: users.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 5),
                  itemBuilder: (_, index) {
                    return UserCard(user: users[index]);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
