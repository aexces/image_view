// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'image_urls.freezed.dart';
part 'image_urls.g.dart';

@freezed
class ImageUrls with _$ImageUrls {
  const factory ImageUrls({
    @JsonKey(name: "webformatURL") required String? image,
    @JsonKey(name: "largeImageURL") required String? largeImage,
  }) = _ImageUrls;

  factory ImageUrls.fromJson(Map<String, dynamic> json) =>
      _$ImageUrlsFromJson(json);
}
