import 'package:flutter/material.dart';
import '../utils/app_locale_fallback.dart';
import '../../../generated/app_localizations.dart';

extension ContextExtensions on BuildContext {
  Size get size => MediaQuery.sizeOf(this);
  TextTheme get tt => Theme.of(this).textTheme;
  ColorScheme get cs => Theme.of(this).colorScheme;
  AppLocalizations get locale {
    return AppLocalizations.of(this) ?? AppLocaleFallback("en");
  }
}
