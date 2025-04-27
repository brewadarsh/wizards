import 'apps/hogwarts_app.dart';
import 'package:flutter/cupertino.dart';

import 'layers/core/utils/local_storage.dart';
import 'layers/hogwarts_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorageSync.instance.init();
  HogwartsContainer.inject();
  runApp(const HogwartsApp());
}
