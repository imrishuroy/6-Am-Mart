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
}
