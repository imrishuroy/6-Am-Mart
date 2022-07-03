part of 'order_cubit.dart';

enum OrderStatus { initial, loading, succuss, error }

class OrderState extends Equatable {
  final Failure failure;
  final OrderStatus status;
  final PaginatedOrderModel? runningOrderModel;
  final PaginatedOrderModel? historyOrderModel;
  final List<OrderDetailsModel?> orderDetails;
  final int paymentMethodIndex;
  final OrderModel? trackModel;
  final ResponseModel? responseModel;
  final bool isLoading;
  final bool showCancelled;
  final String orderType;
  final List<TimeSlotModel> timeSlots;
  final List<TimeSlotModel> allTimeSlots;
  final int selectedDateSlot;
  final int selectedTimeSlot;
  final double? distance;
  final int addressIndex;
  final XFile? orderAttachment;
  final Uint8List? rawAttachment;

  const OrderState({
    required this.failure,
    required this.status,
    this.runningOrderModel,
    this.historyOrderModel,
    required this.orderDetails,
    required this.paymentMethodIndex,
    this.trackModel,
    this.responseModel,
    required this.isLoading,
    required this.showCancelled,
    required this.orderType,
    required this.timeSlots,
    required this.allTimeSlots,
    required this.selectedDateSlot,
    required this.selectedTimeSlot,
    this.distance,
    required this.addressIndex,
    this.orderAttachment,
    this.rawAttachment,
  });

  factory OrderState.initial() => const OrderState(
        failure: Failure(),
        status: OrderStatus.initial,
        orderDetails: [],
        paymentMethodIndex: 0,
        isLoading: false,
        showCancelled: false,
        orderType: 'delivery',
        timeSlots: [],
        allTimeSlots: [],
        selectedDateSlot: 0,
        selectedTimeSlot: 0,
        addressIndex: -1,
      );

  @override
  List<Object?> get props {
    return [
      failure,
      status,
      runningOrderModel,
      historyOrderModel,
      orderDetails,
      paymentMethodIndex,
      trackModel,
      responseModel,
      isLoading,
      showCancelled,
      orderType,
      timeSlots,
      allTimeSlots,
      selectedDateSlot,
      selectedTimeSlot,
      distance,
      addressIndex,
      orderAttachment,
      rawAttachment,
    ];
  }

  OrderState copyWith({
    Failure? failure,
    OrderStatus? status,
    PaginatedOrderModel? runningOrderModel,
    PaginatedOrderModel? historyOrderModel,
    List<OrderDetailsModel?>? orderDetails,
    int? paymentMethodIndex,
    OrderModel? trackModel,
    ResponseModel? responseModel,
    bool? isLoading,
    bool? showCancelled,
    String? orderType,
    List<TimeSlotModel>? timeSlots,
    List<TimeSlotModel>? allTimeSlots,
    int? selectedDateSlot,
    int? selectedTimeSlot,
    double? distance,
    int? addressIndex,
    XFile? orderAttachment,
    Uint8List? rawAttachment,
  }) {
    return OrderState(
      failure: failure ?? this.failure,
      status: status ?? this.status,
      runningOrderModel: runningOrderModel ?? this.runningOrderModel,
      historyOrderModel: historyOrderModel ?? this.historyOrderModel,
      orderDetails: orderDetails ?? this.orderDetails,
      paymentMethodIndex: paymentMethodIndex ?? this.paymentMethodIndex,
      trackModel: trackModel ?? this.trackModel,
      responseModel: responseModel ?? this.responseModel,
      isLoading: isLoading ?? this.isLoading,
      showCancelled: showCancelled ?? this.showCancelled,
      orderType: orderType ?? this.orderType,
      timeSlots: timeSlots ?? this.timeSlots,
      allTimeSlots: allTimeSlots ?? this.allTimeSlots,
      selectedDateSlot: selectedDateSlot ?? this.selectedDateSlot,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      distance: distance ?? this.distance,
      addressIndex: addressIndex ?? this.addressIndex,
      orderAttachment: orderAttachment ?? this.orderAttachment,
      rawAttachment: rawAttachment ?? this.rawAttachment,
    );
  }

  @override
  bool get stringify => true;
}
