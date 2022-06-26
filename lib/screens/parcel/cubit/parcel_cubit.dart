import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:six_am_mart/models/parcel_category_model.dart';
import 'package:six_am_mart/repositories/parcel/parcel_repository.dart';
import '/blocs/auth/auth_bloc.dart';
import '/repositories/location/location_repository.dart';
import '/models/failure.dart';

part 'parcel_state.dart';

class ParcelCubit extends Cubit<ParcelState> {
  final LocationRepository _locationRepository;
  final AuthBloc _authBloc;
  final ParcelRepository _parcelRepository;
  ParcelCubit({
    required AuthBloc authBloc,
    required LocationRepository locationRepository,
    required ParcelRepository parcelRepository,
  })  : _authBloc = authBloc,
        _locationRepository = locationRepository,
        _parcelRepository = parcelRepository,
        super(ParcelState.initial());

  void addSenderAddress(String address) {
    emit(state.copyWith(senderAddress: address, status: ParcelStatus.initial));
  }

  void addReceiverAddress(String address) {
    emit(
        state.copyWith(receiverAddress: address, status: ParcelStatus.initial));
  }

  void nameChanged(String name, {bool isSender = true}) {
    if (isSender) {
      emit(state.copyWith(senderName: name, status: ParcelStatus.initial));
    } else {
      emit(state.copyWith(receiverName: name, status: ParcelStatus.initial));
    }
  }

  void mobileNumberChanged(String mobileNo, {bool isSender = false}) {
    if (isSender) {
      emit(state.copyWith(senderPhNo: mobileNo, status: ParcelStatus.initial));
    } else {
      emit(
          state.copyWith(receiverPhNo: mobileNo, status: ParcelStatus.initial));
    }
  }

  void selectPackageType(ParcelCategoryModel? category) {
    emit(state.copyWith(
        selectedCategory: category, status: ParcelStatus.initial));
  }

  void addContact(
      {required bool isSender, required String? phNo, required String? name}) {
    if (isSender) {
      emit(state.copyWith(
          senderName: name, senderPhNo: phNo, status: ParcelStatus.initial));
    } else {
      emit(
        state.copyWith(
          receiverName: name,
          receiverPhNo: phNo,
          status: ParcelStatus.initial,
        ),
      );
    }
  }

  void loadParcelCategories() async {
    try {
      emit(state.copyWith(status: ParcelStatus.loading));

      final categories = await _parcelRepository.getParcelCategory();
      emit(
          state.copyWith(categories: categories, status: ParcelStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: ParcelStatus.error));
    }
  }
}
