import 'package:flutter/material.dart';

class ToastMessage{

  static void showToast(BuildContext context,String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message,style: TextStyle(
          color: Colors.black,
        ),),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.indigo,

      )
    );

  }
}