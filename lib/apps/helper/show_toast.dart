import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastSuccess(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 20.0,
  );
}

void showToastError(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 20.0,
  );
}
