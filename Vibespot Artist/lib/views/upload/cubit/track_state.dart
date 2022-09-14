part of 'track_cubit.dart';

class TrackState extends Equatable {
  final String? title, genre, image, audio, featuringBy, producedBy, payment;
  final int? trackCount;
  final DateTime? releaseDate;
  final bool isLoading;
  final Duration? duration;
  final Address? sateVibes, pushLocation;

  TrackState(
      {this.sateVibes,
      this.pushLocation,
      this.featuringBy,
      this.producedBy,
      this.duration,
      this.isLoading = false,
      this.title,
      this.genre,
        this.payment,
      this.image,
      this.audio,
      this.trackCount,
      this.releaseDate});

  TrackState loading() => TrackState(
      isLoading: true,
      title: title,
      genre: genre,
      payment: payment,
      image: image,
      audio: audio,
      trackCount: trackCount,
      duration: duration,
      releaseDate: releaseDate,
      sateVibes: sateVibes,
      featuringBy: featuringBy,
      producedBy: producedBy,
      pushLocation: pushLocation);
  TrackState copyWith(
          {Duration? duration,
          String? title,
          String? audio,
          String? genre,
          String? payment,
          String? image,
          String? featuringBy,
          String? producedBy,
          int? trackCount,
          DateTime? releaseDate,
          Address? sateVibes,
          Address? pushLocation}) =>
      TrackState(
        title: title ?? this.title,
        genre: genre ?? this.genre,
        payment: payment ?? this.payment,
        image: image ?? this.image,
        audio: audio ?? this.audio,
        producedBy: producedBy ?? this.producedBy,
        featuringBy: featuringBy ?? this.featuringBy,
        // songUrl: songUrl ?? this.songUrl,
        duration: duration ?? this.duration,
        trackCount: trackCount ?? this.trackCount,
        releaseDate: releaseDate ?? this.releaseDate,
        sateVibes: sateVibes ?? this.sateVibes,
        pushLocation: pushLocation ?? this.pushLocation,
      );

  @override
  List<Object?> get props => [
        title,
        genre,
        payment,
        image,
        releaseDate,
        trackCount,
        audio,
        duration,
        pushLocation,
        sateVibes,
        featuringBy,
        producedBy
      ];

  bool get formValid =>
      title != null &&
      title!.isNotEmpty &&
      genre != null &&
      genre!.isNotEmpty &&
      // image != null &&
      // image!.isNotEmpty &&
      audio != null &&
      audio!.isNotEmpty;
  // releaseDate != null &&
  // trackCount != null;

  Map<String, dynamic> toMap({int? albumId, int? releaseId}) => {
        "title": title,
        "genre": genre,
        "premium": 1,
        "price": 0.9,
        'push_country': pushLocation?.country,
        'push_state': pushLocation?.state,
        'state': pushLocation?.state,
        'push_city': pushLocation?.city,
        "stream": "5",
        "album_id": albumId,
        "release_id": releaseId,
        // "song_url": songUrl,
        "image": IMAGE_URL.value,
        "release_date": releaseDate?.format('-'),
        "duration": duration?.toString(),
        "song_url": audio,
        'push_latitude':  pushLocation?.latitude,
        'push_longitude':  pushLocation?.longitude
      };
}
