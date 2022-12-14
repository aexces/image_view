import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_failure.freezed.dart';

@freezed
class HomeFailure with _$HomeFailure {
  const factory HomeFailure.clientFailure() = _ClientFailure;
  const factory HomeFailure.serverFailure() = _ServerFailure;
}
