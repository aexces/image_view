import 'package:dartz/dartz.dart';
import 'package:image_app/domain/home/failure/home_failure.dart';

import 'models/image_urls.dart';

abstract class IHomeRepo {
  Future<Either<HomeFailure, List<ImageUrls>>> getImages({
    required int page,
    required String searchKey,
  });
}
