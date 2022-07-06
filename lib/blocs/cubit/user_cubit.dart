import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import '/api/api.dart';
import '/config/urls.dart';
import '/models/response__model.dart';
import '/models/failure.dart';
import '/models/user.dart';
import '/repositories/user/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;
  UserCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserState.initial());

  Future<ResponseModel> getUserInfo() async {
    ResponseModel responseModel;
    Response response = await _userRepository.getUserInfo();
    if (response.statusCode == 200) {
      emit(state.copyWith(user: User.fromMap(response.data)));

      responseModel = ResponseModel(isSuccess: true, message: 'successful');
    } else {
      responseModel = ResponseModel(
          isSuccess: false,
          message: response.statusMessage ?? 'Something went wrong');

      //ApiChecker.checkApi(response);
    }
    //  update();
    return responseModel;
  }

  Future<Response?> updateProfile(User? user, XFile data, String token) async {
    Map<String, String> _body = {};
    if (user != null) {}
    _body.addAll(<String, String>{
      'f_name': user?.firstName ?? '',
      'l_name': user?.lastName ?? '',
      'email': user?.email ?? '',
    });

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        data.path,
        filename: data.name,
      )
    });

    return await Api.createDio().post(Urls.updateProfile,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}));
  }

  Future<Response?> changePassword(User? user) async {
    if (user != null) {
      return null;
    }

    final data = {
      'f_name': user?.firstName ?? '',
      'l_name': user?.lastName ?? '',
      'email': user?.email ?? '',
      'password': user?.password ?? '',
    };

    return await Api.createDio().post(Urls.updateProfile, data: data);
  }
}
