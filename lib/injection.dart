import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection(String env) async {
  getIt.registerLazySingleton<Dio>(() => Dio(BaseOptions()));
  $initGetIt(getIt, environment: env);
}
