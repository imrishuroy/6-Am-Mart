import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/auth/auth_bloc.dart';
import '/repositories/location/location_repository.dart';
import '/models/failure.dart';

part 'parcel_state.dart';

class ParcelCubit extends Cubit<ParcelState> {
  final LocationRepository _locationRepository;
  final AuthBloc _authBloc;
  ParcelCubit({
    required AuthBloc authBloc,
    required LocationRepository locationRepository,
  })  : _authBloc = authBloc,
        _locationRepository = locationRepository,
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

  void selectPackageType(String? type) {
    emit(state.copyWith(parcelType: type, status: ParcelStatus.initial));
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
}
