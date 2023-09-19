import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_x/modules/posts/services/profile_posts_client.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileController {
  final _client = ProfilePostsClient();

  Query get clientQuery => _client.query;

  void launchSocialLink(String socialLink) {
    try {
      launchUrl(
        Uri.parse(socialLink),
        mode: LaunchMode.externalNonBrowserApplication,
      );
    } catch (_) {
      launchUrl(
        Uri.parse(socialLink),
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
