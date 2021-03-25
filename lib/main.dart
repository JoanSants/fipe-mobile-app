import 'package:flutter/material.dart';
import 'package:fipe_mobile_app/pages/home.dart';
import 'package:fipe_mobile_app/pages/brands.dart';
import 'package:fipe_mobile_app/pages/vehicle-models.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/brands': (context) => Brands(),
      '/models': (context) => VehicleModels()
    },
  ));
}