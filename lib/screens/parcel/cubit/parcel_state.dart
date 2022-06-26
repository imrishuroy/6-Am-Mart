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
  final ParcelCategoryModel? selectedCategory;
  final List<ParcelCategoryModel?> categories;

  const ParcelState({
    this.senderAddress,
    this.receiverAddress,
    this.senderPhNo,
    this.receiverPhNo,
    required this.status,
    required this.failure,
    this.senderName,
    this.receiverName,
    this.selectedCategory,
    required this.categories,
  });

  factory ParcelState.initial() => const ParcelState(
        status: ParcelStatus.initial,
        failure: Failure(),
        categories: [],
      );

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
      selectedCategory,
      categories,
    ];
  }

  @override
  String toString() {
    return 'ParcelState(senderAddress: $senderAddress, receiverAddress: $receiverAddress, senderPhNo: $senderPhNo, receiverPhNo: $receiverPhNo, status: $status, failure: $failure, senderName: $senderName, receiverName: $receiverName, selectedCategory: $selectedCategory, categories: $categories)';
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
    ParcelCategoryModel? selectedCategory,
    List<ParcelCategoryModel?>? categories,
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
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categories: categories ?? this.categories,
    );
  }
}
