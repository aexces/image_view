part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.getImages() = _GetImages;
  const factory HomeEvent.getImagesNextPage() = _GetImagesNextPage;
  const factory HomeEvent.showTextField() = _ShowTextField;
  const factory HomeEvent.hideTextField() = _HideTextField;
  const factory HomeEvent.searchKeyChanged(String searchKey) =
      _SearchKeyChanged;
}
