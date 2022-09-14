import 'package:vsartist/core/extensions/index.dart';
import 'package:vsartist/.env.dart';

// /// Application environment variables
abstract class Env {
  String get baseUrl;
  String get paystackKey;
  String get youtubeApiKey;
  String get locationApiEmail;
  String get locationApiToken;

  String get uploadApiKey;
  String get uploadSecret;
  String get uploadRegion;
  String get uploadBucketName;
  String get googleApiKey;
}

class Production extends Env {
  @override
  String get baseUrl => ENV.getKey('PRODUCTION_BASE_URL');

  @override
  String get paystackKey => ENV.getKey('PAYSTACK_KEY_LIVE');

  @override
  String get youtubeApiKey => ENV.getKey('YOUTUBE_API_KEY');

  @override
  String get locationApiEmail => ENV.getKey('LOCATION_EMAIL');

  @override
  String get locationApiToken => ENV.getKey('LOCATION_API_TOKEN');

  @override
  String get uploadApiKey => ENV.getKey('UPLOAD_API_KEY');

  @override
  String get uploadSecret => ENV.getKey('UPLOAD_API_SECRET');

  @override
  String get uploadRegion => ENV.getKey('UPLOAD_REGION');

  @override
  String get uploadBucketName => ENV.getKey('UPLOAD_BUCKET_NAME');

  @override
  String get googleApiKey => ENV.getKey('GOOGLE_API_KEY');
}

class Development extends Env {
  @override
  String get baseUrl => ENV.getKey('DEVELOPMENT_BASE_URL');

  @override
  String get paystackKey => ENV.getKey('PAYSTACK_KEY_TEST');
  @override
  String get youtubeApiKey => ENV.getKey('YOUTUBE_API_KEY');

  @override
  String get locationApiEmail => ENV.getKey('LOCATION_EMAIL');

  @override
  String get locationApiToken => ENV.getKey('LOCATION_API_TOKEN');

  @override
  String get uploadApiKey => ENV.getKey('UPLOAD_API_KEY');

  @override
  String get uploadSecret => ENV.getKey('UPLOAD_API_SECRET');

  @override
  String get uploadRegion => ENV.getKey('UPLOAD_REGION');
  @override
  String get uploadBucketName => ENV.getKey('UPLOAD_BUCKET_NAME');

  @override
  String get googleApiKey => ENV.getKey('GOOGLE_API_KEY');
}
