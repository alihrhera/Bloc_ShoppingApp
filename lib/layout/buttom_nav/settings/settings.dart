import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopingapp/modules/home_screen/cubit/cubit.dart';
import 'package:shopingapp/modules/home_screen/cubit/states.dart';
import 'package:shopingapp/shared/components/components.dart';
import 'package:shopingapp/shared/components/constants.dart';

class Settings extends StatelessWidget {
  //const Favorites({Key? key}) : super(key: key);
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();
/*
* */
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeShopCubit, HomeShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeShopCubit.get(context);
        if(cubit.userData != null){
          nameController.text = cubit.userData!.data!.name!;
          phoneController.text = cubit.userData!.data!.phone!;
          emailController.text = cubit.userData!.data!.email!;
          return Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if (state is UpdateUserShopAppLoadingState)
                      LinearProgressIndicator(backgroundColor: Colors.deepOrange,),
                    SizedBox(
                      height: 20.0,
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
                      hint: 'email',
                      preIcon: Icons.email,
                      isPassword: false,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        buttonTitle: 'UPDATE',
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            cubit.updateUser(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text,
                            );
                          }
                        }),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        buttonTitle: 'LOGOUT',
                        onTap: () {
                          logOut(context);
                        }),
                  ],
                ),
              ),
            ),
          );
        }else {
          return  Center(child: CircularProgressIndicator());
        }


      },
    );
  }
}
