import 'package:cloud_firestore/cloud_firestore.dart';

DateTime? parseDateTime(dynamic value) {
  if (value == null) return null;
  if (value is Timestamp) return value.toDate();
  if (value is Map<String, dynamic> && value.containsKey('_seconds')) {
    return DateTime.fromMillisecondsSinceEpoch((value['_seconds'] as int) * 1000);
  }
  return null;
}
