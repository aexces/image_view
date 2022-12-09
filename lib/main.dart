import 'package:flutter/material.dart';
import 'package:image_app/presentation/core/app_widget.dart';
import 'package:injectable/injectable.dart';

import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Environment.prod);
  runApp(const AppWidget());
}
