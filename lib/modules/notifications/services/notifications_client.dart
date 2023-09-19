import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_x/core/constants/errors.dart';
import 'package:social_x/core/helpers/extensions/firestore_objects_converter.dart';
import 'package:social_x/core/models/http_client_result.dart';

class NotificationsClient {
  final _userId = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference get _notifications {
    return FirebaseFirestore.instance.collection("notifications");
  }

  Future<HttpClientResult> fetch() async {
    try {
      final result = await _notifications
          .adaptiveNotifications()
          .where("receiver_id", isEqualTo: _userId)
          .get();

      final fetchedNotifications = result.docs.map((notificationDoc) {
        return notificationDoc.data() as Notification;
      }).toList();
      return SuccessfulRequest(fetchedNotifications);
    } catch (_) {
      return FailedRequest(AppErrors.networkError);
    }
  }
}
