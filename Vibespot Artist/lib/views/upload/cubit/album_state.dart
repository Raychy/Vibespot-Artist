part of 'album_cubit.dart';

class AlbumState extends Equatable {
  final String? title, description, image;
  final int? trackCount;
  final DateTime? releaseDate;
  final bool isLoading;

  AlbumState(
      {this.isLoading = false,
      this.title,
      this.description,
      this.image,
      this.trackCount,
      this.releaseDate});

  AlbumState loading() => AlbumState(
        isLoading: true,
        title: title,
        description: description,
        image: image,
        trackCount: trackCount,
        releaseDate: releaseDate,
      );
  AlbumState copyWith(
          {String? title,
          String? description,
          String? image,
          int? trackCount,
          DateTime? releaseDate}) =>
      AlbumState(
        title: title ?? this.title,
        description: description ?? this.description,
        image: image ?? this.image,
        trackCount: trackCount ?? this.trackCount,
        releaseDate: releaseDate ?? this.releaseDate,
      );

  @override
  List<Object?> get props =>
      [title, description, image, releaseDate, trackCount];

  bool get formValid =>
      title != null &&
      title!.isNotEmpty &&
      description != null &&
      description!.isNotEmpty &&
      image != null &&
      image!.isNotEmpty &&
      releaseDate != null &&
      trackCount != null;

  Map<String, dynamic> get toMap => {
        "title": title,
        "description": description,
        "track_count": trackCount?.toString(),
        "release_date": releaseDate?.format('-'),
        "image_url": image,
        // (image ?? '').startsWith('http')    ?  : FileFormField(path: image ?? '', key: 'image'),
        'status': '0'
      };

  Map<String, dynamic> get releaseToMap => {
        "image_url": image,
        "release_name": title,
        "release_date": releaseDate?.format('-'),
        'track_count': 1,
        'status': 0
      };
}
