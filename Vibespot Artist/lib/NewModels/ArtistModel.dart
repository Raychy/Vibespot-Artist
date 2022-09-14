class ArtistModel {
  ArtistModel({
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
    required this.artistProfile,
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
  ArtistProfile artistProfile;

  factory ArtistModel.fromJson(Map<String, dynamic> json) => ArtistModel(
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
    artistProfile: ArtistProfile.fromJson(json["artist_profile"]),
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
    "artist_profile": artistProfile.toJson(),
  };
}

class ArtistProfile {
  ArtistProfile({
    required this.id,
    required this.userId,
    required this.stageName,
    required this.surname,
    required this.firstname,
    required this.othernames,
    required this.recordLabelId,
    required this.managementId,
    required this.confirmRecordLabel,
    required this.createdAt,
  });

  int id;
  int userId;
  String stageName;
  String surname;
  String firstname;
  dynamic othernames;
  int recordLabelId;
  int managementId;
  dynamic confirmRecordLabel;
  DateTime createdAt;

  factory ArtistProfile.fromJson(Map<String, dynamic> json) => ArtistProfile(
    id: json["id"],
    userId: json["user_id"],
    stageName: json["stage_name"],
    surname: json["surname"],
    firstname: json["firstname"],
    othernames: json["othernames"],
    recordLabelId: json["record_label_id"],
    managementId: json["management_id"],
    confirmRecordLabel: json["confirm_record_label"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "stage_name": stageName,
    "surname": surname,
    "firstname": firstname,
    "othernames": othernames,
    "record_label_id": recordLabelId,
    "management_id": managementId,
    "confirm_record_label": confirmRecordLabel,
    "created_at": createdAt.toIso8601String(),
  };
}
