import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Padding padding(EdgeInsets padding) {
    return Padding(padding: padding, child: this);
  }
}
