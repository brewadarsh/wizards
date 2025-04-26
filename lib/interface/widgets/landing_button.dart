import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/constants/asset_constants.dart';
import '../../core/constants/color_constants.dart';
import '../../core/constants/shape_constants.dart';

class LandingButton extends StatelessWidget {
  const LandingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Lottie.asset(AssetConstants.highlight, height: 120),
        ClipRRect(
          borderRadius: ShapeConstants.largeBorderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstants.fontColor.withAlpha(80),
              ),
              child: const Icon(
                Icons.keyboard_arrow_right_rounded,
                size: 45,
                color: ColorConstants.fontColorDim,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
