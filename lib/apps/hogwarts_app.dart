import 'package:flutter/material.dart';
import '../core/utils/app_color.dart';
import '../core/utils/app_fonts.dart';
import '../presentation/router/hogwarts_router.dart';
import '../../../generated/app_localizations.dart';

class HogwartsApp extends StatelessWidget {
  const HogwartsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: HogwartsRouter.config,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        fontFamily: AppFonts.montserrat,
        colorScheme: AppColor.hogwartsScheme,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
