import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/money_splitter_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MoneySplitterApp());
}
