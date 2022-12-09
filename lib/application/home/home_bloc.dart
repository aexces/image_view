import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_app/domain/home/failure/home_failure.dart';
import 'package:image_app/domain/home/i_home_repo.dart';
import 'package:image_app/domain/home/models/image_urls.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
@prod
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IHomeRepo _homeRepo;
  HomeBloc(this._homeRepo) : super(HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      await event.map(
        showTextField: (e) async => emit(state.copyWith(
          failureOrSuccessOption: none(),
          showTextField: true,
        )),
        searchKeyChanged: (e) async => emit(state.copyWith(
          searchKey: e.searchKey,
          failureOrSuccessOption: none(),
        )),
        hideTextField: (e) async => emit(state.copyWith(
          showTextField: false,
          failureOrSuccessOption: none(),
        )),
        getImages: (e) async {
          emit(state.copyWith(
            isLoading: true,
            page: 0,
            failureOrSuccessOption: none(),
          ));
          final failureOrSuccess = await _homeRepo.getImages(
            page: state.page,
            searchKey: state.searchKey,
          );
          emit(failureOrSuccess.fold(
            (l) => state.copyWith(
              isLoading: false,
              failureOrSuccessOption: some(left(l)),
            ),
            (r) => state.copyWith(
              isLoading: false,
              images: r,
              failureOrSuccessOption: some(right(r)),
            ),
          ));
        },
        getImagesNextPage: (e) async {
          emit(state.copyWith(
            isNextPageLoading: true,
            page: state.page + 1,
            failureOrSuccessOption: none(),
          ));
          final failureOrSuccess = await _homeRepo.getImages(
            page: state.page,
            searchKey: state.searchKey,
          );
          emit(failureOrSuccess.fold(
            (l) => state.copyWith(
              isNextPageLoading: false,
              failureOrSuccessOption: some(left(l)),
            ),
            (r) => state.copyWith(
              isNextPageLoading: false,
              images: [...state.images, ...r],
              failureOrSuccessOption: some(right(r)),
            ),
          ));
        },
      );
    });
  }
}
