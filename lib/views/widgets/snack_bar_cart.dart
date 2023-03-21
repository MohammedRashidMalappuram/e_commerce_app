import 'package:flutter/material.dart';

snackBarCart(context) {
    const snackBar = SnackBar(
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(30.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Text('Successfully Cart Added !'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }