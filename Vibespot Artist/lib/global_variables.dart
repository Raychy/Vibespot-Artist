import 'package:flutter/material.dart';

final USER_ID = ValueNotifier(0);
final fcmToken = ValueNotifier("");
final songUploadPrice = ValueNotifier(0);
const baseUrl = "https://beckcircle.com/vibespot/v1/";
const saveFcmUrl = "oauth/save-fcm";
const followArtistUrl = "vibestream/follow-artist";
// const getArtistUrl = "vibestream/get-artist";

// List<ArtistModel> artistModelList = [];