import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/model/user.dart';

class Util {
  static String UID = "";
  static GeoPoint geoPoint = const GeoPoint(0, 0);
  static AppUser? user = null;
}