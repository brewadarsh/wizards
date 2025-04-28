import 'apps/hogwarts_app.dart';
import 'package:flutter/cupertino.dart';

import 'core/utils/local_storage.dart';
import 'hogwarts_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorageSync.instance.init();
  HogwartsContainer.inject();
  runApp(const HogwartsApp());
}
