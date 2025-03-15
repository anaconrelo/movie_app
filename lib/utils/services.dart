import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movieapp/utils/api.dart';

Future<void> setupServices() async {
  // Initialize services here
  services.registerSingleton(API());
  services.registerSingleton(GlobalKey<NavigatorState>());
}

final services = GetIt.instance;