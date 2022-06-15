part of 'parcel_cubit.dart';

enum ParcelStatus { initial, loading, succuss, error }

class ParcelState extends Equatable {
  final String? senderAddress;
  final String? receiverAddress;
  final String? senderPhNo;
  final String? receiverPhNo;
  final ParcelStatus status;
  final Failure failure;
  final String? senderName;
  final String? receiverName;
  final String? parcelType;

  const ParcelState({
    this.senderAddress,
    this.receiverAddress,
    this.senderPhNo,
    this.receiverPhNo,
    required this.status,
    required this.failure,
    this.senderName,
    this.receiverName,
    this.parcelType,
  });

  factory ParcelState.initial() =>
      const ParcelState(status: ParcelStatus.initial, failure: Failure());

  @override
  List<Object?> get props {
    return [
      senderAddress,
      receiverAddress,
      senderPhNo,
      receiverPhNo,
      status,
      failure,
      senderName,
      receiverName,
      parcelType,
    ];
  }

  @override
  String toString() {
    return 'ParcelState(senderAddress: $senderAddress, receiverAddress: $receiverAddress, senderPhNo: $senderPhNo, receiverPhNo: $receiverPhNo, status: $status, failure: $failure, senderName: $senderName, receiverName: $receiverName, parcelType: $parcelType)';
  }

  ParcelState copyWith({
    String? senderAddress,
    String? receiverAddress,
    String? senderPhNo,
    String? receiverPhNo,
    ParcelStatus? status,
    Failure? failure,
    String? senderName,
    String? receiverName,
    String? parcelType,
  }) {
    return ParcelState(
      senderAddress: senderAddress ?? this.senderAddress,
      receiverAddress: receiverAddress ?? this.receiverAddress,
      senderPhNo: senderPhNo ?? this.senderPhNo,
      receiverPhNo: receiverPhNo ?? this.receiverPhNo,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      senderName: senderName ?? this.senderName,
      receiverName: receiverName ?? this.receiverName,
      parcelType: parcelType ?? this.parcelType,
    );
  }
}
