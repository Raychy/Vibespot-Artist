// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.phone,
    required this.userType,
    required this.image,
    required this.wallet,
    required this.previousWallet,
    required this.token,
    required this.country,
    required this.state,
    required this.city,
    required this.fbSocialLoginId,
    required this.googleSocialLoginId,
    required this.youtubeChannel,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.userLatitude,
    required this.userLongitude,
    required this.fcmToken,
    required this.emailVerified,
  });

  int id;
  String email;
  String phone;
  String userType;
  dynamic image;
  String wallet;
  String previousWallet;
  String token;
  String country;
  dynamic state;
  dynamic city;
  dynamic fbSocialLoginId;
  dynamic googleSocialLoginId;
  dynamic youtubeChannel;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic userLatitude;
  dynamic userLongitude;
  dynamic fcmToken;
  bool emailVerified;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    email: json["email"],
    phone: json["phone"],
    userType: json["user_type"],
    image: json["image"],
    wallet: json["wallet"],
    previousWallet: json["previous_wallet"],
    token: json["token"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    fbSocialLoginId: json["fb_social_login_id"],
    googleSocialLoginId: json["google_social_login_id"],
    youtubeChannel: json["youtube_channel"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    userLatitude: json["user_latitude"],
    userLongitude: json["user_longitude"],
    fcmToken: json["fcm_token"],
    emailVerified: json["email_verified"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "phone": phone,
    "user_type": userType,
    "image": image,
    "wallet": wallet,
    "previous_wallet": previousWallet,
    "token": token,
    "country": country,
    "state": state,
    "city": city,
    "fb_social_login_id": fbSocialLoginId,
    "google_social_login_id": googleSocialLoginId,
    "youtube_channel": youtubeChannel,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user_latitude": userLatitude,
    "user_longitude": userLongitude,
    "fcm_token": fcmToken,
    "email_verified": emailVerified,
  };
}
