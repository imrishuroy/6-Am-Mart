import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '/blocs/config/app_config_bloc.dart';
import '/models/distance_model.dart';
import '/models/place_order_body.dart';
import '/models/store.dart';
import '/utils/date_converter.dart';
import '/utils/network_info.dart';
import '/repositories/order/order_repository.dart';
import '/models/failure.dart';
import '/models/order_details_model.dart';
import '/models/order_model.dart';
import '/models/paginated_order_model.dart';
import '/models/response__model.dart';
import '/models/time_slot_model.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository _orderRepo;
  OrderCubit({required OrderRepository orderRepo})
      : _orderRepo = orderRepo,
        super(OrderState.initial());

  Future<void> getRunningOrders(
    int offset,
  ) async {
    emit(state.copyWith(status: OrderStatus.loading));
    // if (offset == 1) {
    //   emit(state.copyWith(runningOrderModel: null));
    // }
    Response response = await _orderRepo.getRunningOrderList(offset);
    print('Order response -- ${response.data}');
    print('Order status -- ${response.statusCode}');
    if (response.statusCode == 200) {
      if (offset == 1) {
        print('This runs --- $offset');
        print(
            'Running order model ${PaginatedOrderModel.fromMap(response.data)}');
        emit(
          state.copyWith(
              runningOrderModel: PaginatedOrderModel.fromMap(response.data),
              status: OrderStatus.succuss),
        );
        // _runningOrderModel = PaginatedOrderModel.fromJson(response.body);
      } else {
        emit(state.copyWith(
            runningOrderModel: PaginatedOrderModel.fromMap(response.data)));

        emit(state.copyWith(
            runningOrderModel: state.runningOrderModel?.copyWith(
                orders: state.runningOrderModel?.orders
                  ?..addAll(
                      PaginatedOrderModel.fromMap(response.data).orders))));
        // state.runningOrderModel?.orders
        //     .addAll(PaginatedOrderModel.fromJson(response.data).orders);

        emit(state.copyWith(
            runningOrderModel: state.runningOrderModel?.copyWith(
                offset: PaginatedOrderModel.fromMap(response.data).offset)));

        // _runningOrderModel.offset =
        //     PaginatedOrderModel.fromJson(response.body).offset;

        emit(state.copyWith(
            runningOrderModel: state.runningOrderModel?.copyWith(
                totalSize:
                    PaginatedOrderModel.fromMap(response.data).totalSize),
            status: OrderStatus.succuss));
        // _runningOrderModel.totalSize =
        //     PaginatedOrderModel.fromJson(response.body).totalSize;
      }
      // update();
    } else {
      emit(state.copyWith(
          failure: const Failure(message: 'Something went wrong'),
          status: OrderStatus.succuss));
      //ApiChecker?.checkApi(response, context: context);
    }
  }

  Future<void> getHistoryOrders(int offset) async {
    // if (offset == 1) {
    // emit(state.copyWith(historyOrderModel: null));
    //}
    Response response = await _orderRepo.getHistoryOrderList(offset);
    print('History order model 1 ${response.data}');
    if (response.statusCode == 200) {
      if (offset == 1) {
        print(
            'History order model   ${PaginatedOrderModel.fromMap(response.data)} ');
        emit(state.copyWith(
            historyOrderModel: PaginatedOrderModel.fromMap(response.data)));
      } else {
        emit(state.copyWith(
            historyOrderModel: state.historyOrderModel?.copyWith(
                orders: state.historyOrderModel?.orders
                  ?..addAll(
                      PaginatedOrderModel.fromMap(response.data).orders))));

        emit(state.copyWith(
            historyOrderModel: state.historyOrderModel?.copyWith(
                offset: PaginatedOrderModel.fromMap(response.data).offset)));

        // _runningOrderModel.offset =
        //     PaginatedOrderModel.fromJson(response.body).offset;

        emit(state.copyWith(
            historyOrderModel: state.historyOrderModel?.copyWith(
                totalSize:
                    PaginatedOrderModel.fromMap(response.data).totalSize)));
      }
    } else {
      //ApiChecker.checkApi(response);
    }
  }

  ///////
  ///
  ///

  Future<List<OrderDetailsModel?>> getOrderDetails(String orderID) async {
    emit(state.copyWith(
        orderDetails: null, isLoading: true, showCancelled: false));

    if (state.trackModel == null || state.trackModel?.orderType != 'parcel') {
      Response response = await _orderRepo.getOrderDetails(orderID);
      emit(state.copyWith(isLoading: false));

      if (response.statusCode == 200) {
        emit(
          state.copyWith(
            orderDetails: [],
          ),
        );

        response.data.forEach((orderDetail) => emit(state.copyWith(
            orderDetails: state.orderDetails
              ..add(OrderDetailsModel.fromMap(orderDetail)))));
      } else {
        // ApiChecker.checkApi(response);
      }
    } else {
      emit(state.copyWith(isLoading: false, orderDetails: []));
    }
    return state.orderDetails;
    //update();
    //return Future.delayed(Duration(seconds: 1),()=>  state.orderDetails);
  }

  void setPaymentMethod(int index) {
    emit(state.copyWith(paymentMethodIndex: index));
  }

  Future<ResponseModel?> trackOrder(
      String orderID, OrderModel? orderModel, bool fromTracking) async {
    emit(state.copyWith(trackModel: null, responseModel: null));

    if (!fromTracking) {
      emit(state.copyWith(orderDetails: null));
    }
    emit(state.copyWith(showCancelled: false));

    if (orderModel == null) {
      emit(state.copyWith(isLoading: true));

      Response response = await _orderRepo.trackOrder(orderID);
      if (response.statusCode == 200) {
        emit(state.copyWith(
            trackModel: OrderModel.fromMap(response.data),
            responseModel: ResponseModel(
                isSuccess: true, message: response.data.toString())));
      } else {
        emit(
          state.copyWith(
            responseModel: ResponseModel(
                isSuccess: false,
                message: response.statusMessage ?? 'Something went wrong'),
          ),
        );

        //_responseModel = ResponseModel(false, response.statusMessage);
        // ApiChecker.checkApi(response);
      }
      emit(state.copyWith(isLoading: false));
    } else {
      emit(
        state.copyWith(
          trackModel: orderModel,
          responseModel: ResponseModel(isSuccess: true, message: 'Successful'),
        ),
      );
    }
    return state.responseModel;
  }

  Future<void> placeOrder(PlaceOrderBody placeOrderBody,
      Function(bool isSuccess, String message, String orderID) callback) async {
    emit(state.copyWith(isLoading: true));

    print(placeOrderBody.toJson());
    if (state.orderAttachment != null) {
      Response response =
          await _orderRepo.placeOrder(placeOrderBody, state.orderAttachment!);
      emit(state.copyWith(isLoading: false));

      if (response.statusCode == 200) {
        String message = response.data['message'];
        String orderID = response.data['order_id'].toString();
        callback(true, message, orderID);
        emit(state.copyWith(orderAttachment: null, rawAttachment: null));

        print('-------- Order placed successfully $orderID ----------');
      } else {
        callback(false, response.statusMessage ?? 'Something went wrong', '-1');
      }
    }
  }

  void stopLoader() {
    emit(state.copyWith(isLoading: false));
    // _isLoading = false;
    // update();
  }

  void clearPrevData() {
    emit(state.copyWith(
      addressIndex: -1,
      paymentMethodIndex: 0,
      selectedDateSlot: 0,
      selectedTimeSlot: 0,
      distance: null,
      orderAttachment: null,
      rawAttachment: null,
    ));
  }

  void setAddressIndex(int index) {
    emit(state.copyWith(addressIndex: index));
  }

  void cancelOrder(int orderID) async {
    emit(state.copyWith(isLoading: true));

    Response response = await _orderRepo.cancelOrder(orderID.toString());
    emit(state.copyWith(isLoading: false));

    //Get.back();
    if (response.statusCode == 200) {
      OrderModel? orderModel;
      for (OrderModel? order in state.runningOrderModel?.orders ?? []) {
        if (order?.id == orderID) {
          if (order != null) {
            orderModel = order;
            break;
          }
        }
      }

      emit(state.copyWith(
          runningOrderModel: state.runningOrderModel?.copyWith(
              orders: state.runningOrderModel?.orders?..remove(orderModel)),
          showCancelled: true));

      //  showCustomSnackBar(response.body['message'], isError: false);
    } else {
      print(response.statusMessage);
      // ApiChecker.checkApi(response);
    }
    //update();
  }

  void setOrderType(String type, {bool notify = true}) {
    if (notify) {
      emit(state.copyWith(orderType: type));
    }
  }

  Future<void> initializeTimeSlot(Store? store,
      {required BuildContext context}) async {
    final configBloc = context.read<AppConfigBloc>();
    emit(state.copyWith(timeSlots: [], allTimeSlots: []));

    int minutes = 0;
    DateTime now = DateTime.now();
    for (int index = 0; index < (store?.schedules.length ?? 0); index++) {
      DateTime openTime = DateTime(
        now.year,
        now.month,
        now.day,
        DateConverter.convertStringTimeToDate(
                store?.schedules[index]?.openingTime ?? '')
            .hour,
        DateConverter.convertStringTimeToDate(
                store?.schedules[index]?.openingTime ?? '')
            .minute,
      );
      DateTime closeTime = DateTime(
        now.year,
        now.month,
        now.day,
        DateConverter.convertStringTimeToDate(
                store?.schedules[index]?.closingTime ?? '')
            .hour,
        DateConverter.convertStringTimeToDate(
                store?.schedules[index]?.closingTime ?? '')
            .minute,
      );
      if (closeTime.difference(openTime).isNegative) {
        minutes = openTime.difference(closeTime).inMinutes;
      } else {
        minutes = closeTime.difference(openTime).inMinutes;
      }
      if (minutes >
          (configBloc.state.configModel?.scheduleOrderSlotDuration ?? 0)) {
        DateTime time = openTime;
        for (;;) {
          if (time.isBefore(closeTime)) {
            DateTime start = time;
            DateTime end = start.add(Duration(
                minutes:
                    (configBloc.state.configModel?.scheduleOrderSlotDuration ??
                        0)));
            if (end.isAfter(closeTime)) {
              end = closeTime;
            }

            emit(
              state.copyWith(
                timeSlots: state.timeSlots
                  ..add(
                    TimeSlotModel(
                      day: store?.schedules[index]?.day ?? 0,
                      startTime: start,
                      endTime: end,
                    ),
                  ),
                allTimeSlots: state.allTimeSlots
                  ..add(
                    TimeSlotModel(
                      day: store?.schedules[index]?.day ?? 0,
                      startTime: start,
                      endTime: end,
                    ),
                  ),
              ),
            );

            time = time.add(Duration(
                minutes:
                    configBloc.state.configModel?.scheduleOrderSlotDuration ??
                        0));
          } else {
            break;
          }
        }
      } else {
        emit(
          state.copyWith(
              timeSlots: state.timeSlots
                ..add(
                  TimeSlotModel(
                    day: store?.schedules[index]?.day ?? 0,
                    startTime: openTime,
                    endTime: closeTime,
                  ),
                ),
              allTimeSlots: state.allTimeSlots
                ..add(TimeSlotModel(
                    day: store?.schedules[index]?.day ?? 0,
                    startTime: openTime,
                    endTime: closeTime))),
        );
      }
    }
    validateSlot(
        state.allTimeSlots, 0, store?.orderPlaceToScheduleInterval ?? 0,
        notify: false, context: context);
  }

  void updateTimeSlot(int index) {
    emit(state.copyWith(selectedTimeSlot: index));
  }

  void updateDateSlot(int index, int interval,
      {required BuildContext context}) {
    emit(state.copyWith(selectedDateSlot: index));
    validateSlot(state.allTimeSlots, index, interval, context: context);
  }

  void validateSlot(List<TimeSlotModel> slots, int dateIndex, int interval,
      {bool notify = true, required BuildContext context}) {
    emit(state.copyWith(timeSlots: []));

    DateTime now = DateTime.now();
    final configBloc = context.read<AppConfigBloc>();
    if ((configBloc.state.configModel?.moduleConfig?.module
            ?.orderPlaceToScheduleInterval ==
        true)) {
      now = now.add(Duration(minutes: interval));
    }
    int day = 0;
    if (dateIndex == 0) {
      day = DateTime.now().weekday;
    } else {
      day = DateTime.now().add(const Duration(days: 1)).weekday;
    }
    if (day == 7) {
      day = 0;
    }
    for (var slot in slots) {
      if (day == slot.day &&
          (dateIndex == 0 ? slot.endTime.isAfter(now) : true)) {
        emit(state.copyWith(timeSlots: state.timeSlots..add(slot)));
      }
    }
    if (notify) {
      // update();
    }
  }

  Future<bool> switchToCOD(String orderID) async {
    emit(state.copyWith(isLoading: true));

    Response response = await _orderRepo.switchToCOD(orderID);
    bool isSuccess;
    if (response.statusCode == 200) {
      // Get.offAllNamed(RouteHelper.getInitialRoute());
      // showCustomSnackBar(response.body['message'], isError: false);
      emit(state.copyWith(isLoading: false));
      isSuccess = true;
    } else {
      //ApiChecker.checkApi(response);
      isSuccess = false;
    }
    emit(state.copyWith(isLoading: false));
    // _isLoading = false;
    // update();
    return isSuccess;
  }

  Future<double?> getDistanceInKM(
      LatLng originLatLng, LatLng destinationLatLng) async {
    emit(state.copyWith(distance: -1));
    //_distance = -1;
    Response response =
        await _orderRepo.getDistanceInMeter(originLatLng, destinationLatLng);
    try {
      if (response.statusCode == 200 && response.data['status'] == 'OK') {
        emit(state.copyWith(
            distance: DistanceModel.fromJson(response.data)
                    .rows[0]
                    ?.elements[0]
                    ?.distance
                    ?.value ??
                0 / 1000));
      } else {
        emit(
          state.copyWith(
            distance: Geolocator.distanceBetween(
                  originLatLng.latitude,
                  originLatLng.longitude,
                  destinationLatLng.latitude,
                  destinationLatLng.longitude,
                ) /
                1000,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          distance: Geolocator.distanceBetween(
                originLatLng.latitude,
                originLatLng.longitude,
                destinationLatLng.latitude,
                destinationLatLng.longitude,
              ) /
              1000,
        ),
      );
    }
    //  update();
    return state.distance;
  }

  void pickImage() async {
    emit(state.copyWith(
        orderAttachment: await ImagePicker()
            .pickImage(source: ImageSource.gallery, imageQuality: 50)));

    if (state.orderAttachment != null) {
      emit(state.copyWith(
          orderAttachment:
              await NetworkInfo.compressImage(state.orderAttachment!)));
      emit(state.copyWith(
          rawAttachment: await state.orderAttachment?.readAsBytes()));
    }
  }
}
