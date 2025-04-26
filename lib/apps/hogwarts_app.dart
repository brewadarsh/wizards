import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../interface/routes/app_router.dart';

class HogwartsApp extends StatelessWidget {
  const HogwartsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.dark(),
      localizationsDelegates: [S.delegate],
      routerConfig: AppRouter.hogwartsRoute,
    );
  }
}
