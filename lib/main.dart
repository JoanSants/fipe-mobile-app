import 'package:flutter/material.dart';
import 'package:fipe_mobile_app/pages/home.dart';
import 'package:fipe_mobile_app/pages/brands.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/brands': (context) => Brands()
    },
  ));
}