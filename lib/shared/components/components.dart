import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultFormField(
        {TextEditingController? controller,
        String? hint,
        Function? onTap,
        IconData? preIcon,
        IconData? sufIcon,
        Function? suffixPressed,
        bool isPassword =false,
        Function? onChange}) =>
    TextFormField(
      controller: controller,
      onTap: (){
        onTap!();
      },
      obscureText: isPassword,
      onChanged: (s){
        onChange!(s);
      },
      validator: (value) {
        if (value!.isEmpty) {
          return '$hint must be provided';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          preIcon,
          color: Colors.grey,
        ),
        suffixIcon: IconButton(
          icon: Icon(sufIcon),
          color: Colors.grey,
          onPressed: (){
            suffixPressed!();
          },
        ),
        // contentPadding: EdgeInsets.symmetric(horizontal:16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        hintText: hint,
      ),
    );

Widget defaultTextButton({required String title, Function? tap, required Color color}) =>
    TextButton(
      onPressed: (){
        tap!();
      },
      child: Text(
        title,
        style: TextStyle(letterSpacing: 0.1, fontSize: 18.0, color: color),
      ),
    );

Widget defaultButton ({required String buttonTitle,  required Function onTap}) => Container(
  width: double.infinity,
  height: 45.0,
  child:   ElevatedButton(
      style: ElevatedButton.styleFrom(
        //  primary: Color(0xFF7f5985),
         // onPrimary: Colors.white,
          shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)) )
      ),
      onPressed: (){
        onTap();
      }, child: Text(buttonTitle)),
);
void navigateTo({required context, required Widget widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

Widget myDivider() => Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey[300],
);

void navigateAndFinish({required context, required Widget widget}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false);
}


void showToast({required String text, required ToastState state}){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: choseBuildColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

Color choseBuildColor(ToastState state){
  Color color;

  switch(state){

    case ToastState.SUCCESS:
      color= Colors.green;
      break;
    case ToastState.ERROR:
      color= Colors.red;
      break;
    case ToastState.WARNING:
      color= Colors.amber;
      break;

  }
  return color;
}

enum ToastState{SUCCESS,ERROR,WARNING}

