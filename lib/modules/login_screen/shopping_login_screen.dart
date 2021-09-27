
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopingapp/modules/home_screen/home_layout.dart';
import 'package:shopingapp/modules/register_screen/register_screen.dart';

import 'package:shopingapp/network/local/cache_helper.dart';
import 'package:shopingapp/shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';





class ShopLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => ShopLoginCubit(),

      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context , state){

          if (state is ShopLoginSuccessState){
            if(state.model.status){
              print('token is'+'${state.model.data!.token}');
              print('true ya3m el7g');
              CacheHelper.saveData(key: 'token', value : state.model.data!.token);
              showToast(text: state.model.message!,state: ToastState.SUCCESS);
              navigateAndFinish(context: context,widget: Home());

            }else{
              showToast(text: state.model.message!,state: ToastState.ERROR);
              //print(state.model.message);
            }
          }

        },
        builder: (context , state){
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
                          'Login ',
                          style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        Text(
                          'Login now to browse hot offers ',
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),

                        SizedBox(
                          height: 16.0,
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
                          sufIcon: ShopLoginCubit.get(context).sufIcon,
                          suffixPressed: (){
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                          isPassword: ShopLoginCubit.get(context).isPasswordShown,
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        defaultButton(
                            buttonTitle: 'Login',
                            onTap: (){
                              if(formKey.currentState!.validate()){
                                ShopLoginCubit.get(context).userLogin(emailController.text, passwordController.text);
                              }
                            }
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            defaultTextButton(
                                title: "Don't have an account ?", color: Colors.blue
                            ),

                            defaultTextButton(
                                title: 'Register',
                                color: Colors.blue,

                                tap: (){
                                  navigateTo(
                                    context: context,
                                    widget: ShopRegister(),
                                  );

                                }
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }

}


