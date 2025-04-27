import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/constants/asset_constants.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/utils/app_fonts.dart';

class LandingButton extends StatelessWidget {
  const LandingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Alohomora",
          style: context.tt.displayMedium?.copyWith(
            fontWeight: FontWeight.w900,
            fontFamily: AppFonts.tangerine,
            color: context.cs.onSurface.withAlpha(120),
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Lottie.asset(AssetConstants.highlight, height: 100),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.cs.onSurface.withAlpha(80),
              ),
              child: Icon(
                Icons.keyboard_arrow_right_outlined,
                size: 35,
                color: context.cs.onSurface.withAlpha(120),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
