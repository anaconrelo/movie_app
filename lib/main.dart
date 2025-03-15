import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movieapp/app.dart';
import 'package:movieapp/utils/services.dart';
import 'package:movieapp/utils/ssl_bypass_http_overrides.dart';

void main() async {
  HttpOverrides.global = SSLBypassHttpOverrides();
  await setupServices();
  runApp(const App());
}

