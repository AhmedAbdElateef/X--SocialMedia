import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_x/core/constants/errors.dart';
import 'package:social_x/core/helpers/extensions/firestore_objects_converter.dart';
import 'package:social_x/core/models/http_client_result.dart';

class NewNotificationClient {
  CollectionReference get _notifications {
    return FirebaseFirestore.instance.collection("notifications");
  }

  Future<HttpClientResult> addNotification(Notification notification) async {
    try {
      await _notifications.adaptiveNotifications().add(notification);
      return SuccessfulRequest();
    } catch (_) {
      return FailedRequest(AppErrors.networkError);
    }
  }
}
