part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required bool isLoading,
    required bool isNextPageLoading,
    required String searchKey,
    required int page,
    required bool showTextField,
    required List<ImageUrls> images,
    required Option<Either<HomeFailure, List<ImageUrls>>>
        failureOrSuccessOption,
  }) = _HomeState;

  factory HomeState.initial() => const HomeState(
        isLoading: false,
        isNextPageLoading: false,
        showTextField: false,
        searchKey: "",
        page: 1,
        images: [],
        failureOrSuccessOption: None(),
      );
}
