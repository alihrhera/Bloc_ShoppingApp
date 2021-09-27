import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopingapp/modules/home_screen/home_layout.dart';
import 'package:shopingapp/modules/register_screen/cubit/states.dart';
import 'package:shopingapp/network/local/cache_helper.dart';
import 'package:shopingapp/shared/components/components.dart';

import 'cubit/cubit.dart';

class ShopRegister extends StatelessWidget {
  //const ShopRegister({Key? key}) : super(key: key);
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return BlocProvider(
        create: (context) => ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
          listener: (context, state) {
            if (state is ShopRegisterSuccessState) {
              if (state.model.status) {
                print('true ya3m el7g');
                print('token is' + '${state.model.data!.token}');
                CacheHelper.saveData(
                    key: 'token', value: state.model.data!.token);
                showToast(text: state.model.message!, state: ToastState.SUCCESS);
                navigateAndFinish(context: context, widget: Home());
              } else {
                showToast(text: state.model.message!, state: ToastState.ERROR);
                //print(state.model.message);
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'REGISTER',
                            style: TextStyle(
                                fontSize: 50.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                          Text(
                            'register now to browse hot offers ',
                            style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          defaultFormField(
                            controller: nameController,
                            hint: 'name',
                            preIcon: Icons.person,
                            isPassword: false,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: phoneController,
                            hint: 'phone',
                            preIcon: Icons.phone,
                            isPassword: false,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: emailController,
                            hint: 'Email',
                            preIcon: Icons.alternate_email_sharp,
                            isPassword: false,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: passwordController,
                            hint: 'Password',
                            preIcon: Icons.lock,
                            sufIcon: ShopRegisterCubit.get(context).sufIcon,
                            suffixPressed: () {
                              ShopRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            isPassword:
                                ShopRegisterCubit.get(context).isPasswordShown,
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          defaultButton(
                              buttonTitle: 'REGISTER',
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
