import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopingapp/model/user_model.dart';
import 'package:shopingapp/modules/register_screen/cubit/states.dart';
import 'package:shopingapp/network/remote/dio_helper.dart';
import 'package:shopingapp/shared/components/end_point.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  bool isPasswordShown = true;
  IconData sufIcon = Icons.visibility_outlined;
   UserModel? _userModel;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    sufIcon = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    emit(PasswordChangeRegisterVisibility());
  }

  void userRegister(
      {required String email,required  String password,required  String phone,required  String name}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER,
        query: {},
        token: '',
        data: {
      'name':name,
      'phone':phone,
      'email': email,
      'password': password,
    }).then((value) {
      _userModel = UserModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(_userModel!));

    }).catchError((onError) {
      emit(ShopRegisterErrorState(onError.toString()));
      print(onError.toString());
    });
  }
}
