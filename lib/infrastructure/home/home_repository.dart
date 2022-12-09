import 'package:image_app/core/api_key.dart';
import 'package:image_app/domain/home/failure/home_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:image_app/domain/home/i_home_repo.dart';
import 'package:image_app/domain/home/models/image_urls.dart';
import 'package:image_app/injection.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

@Injectable(as: IHomeRepo)
@prod
class HomeRepository implements IHomeRepo {
  @override
  Future<Either<HomeFailure, List<ImageUrls>>> getImages({
    required int page,
    required String searchKey,
  }) async {
    try {
      final Response response = await getIt<Dio>()
          .get("https://pixabay.com/api/?key=$apiKey&q=$searchKey");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<ImageUrls> urls = [];
        for (final raw in response.data["hits"]) {
          urls.add(
            ImageUrls.fromJson(raw as Map<String, dynamic>),
          );
        }
        return right(urls);
      } else {
        return left(const HomeFailure.serverFailure());
      }
    } on DioError catch (e) {
      if (e.response == null) {
        return left(const HomeFailure.serverFailure());
      } else {
        return left(const HomeFailure.clientFailure());
      }
    }
  }
}
