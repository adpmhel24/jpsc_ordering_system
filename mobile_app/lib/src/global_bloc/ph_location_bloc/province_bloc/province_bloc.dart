// import 'dart:io';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../data/repositories/repos.dart';
// import './bloc.dart';

// class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
//   final PhLocationRepo _phLocationRepo;

//   ProvinceBloc(this._phLocationRepo) : super(ProvinceInitState()) {
//     on<FetchProvinceFromLocal>(onFetchingProvinceFromLocal);
//     on<FetchProvinceFromApi>(onFetchingProvinceFromAPI);
//     on<SearchProvinceByKeyword>(onSearchProvinceByKeyword);
//   }

//   void onFetchingProvinceFromLocal(
//       FetchProvinceFromLocal event, Emitter<ProvinceState> emit) async {
//     emit(ProvinceLoadingState());
//     try {
//       if (_phLocationRepo.provinces.isEmpty) {
//         await _phLocationRepo.fetchProvinces();
//       }
//       emit(ProvinceLoadedState(_phLocationRepo.provinces));
//     } on HttpException catch (e) {
//       emit(ProvinceErrorState(e.message));
//     }
//   }

//   void onFetchingProvinceFromAPI(
//       FetchProvinceFromApi event, Emitter<ProvinceState> emit) async {
//     emit(ProvinceLoadingState());
//     try {
//       await _phLocationRepo.fetchProvinces();
//       emit(ProvinceLoadedState(_phLocationRepo.provinces));
//     } on HttpException catch (e) {
//       emit(ProvinceErrorState(e.message));
//     }
//   }

//   void onSearchProvinceByKeyword(
//       SearchProvinceByKeyword event, Emitter<ProvinceState> emit) {
//     emit(ProvinceLoadingState());
//     emit(ProvinceLoadedState(
//         _phLocationRepo.searchProvinceByKeyword(event.keyword)));
//   }
// }
