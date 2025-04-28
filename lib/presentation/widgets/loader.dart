import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

import '../../core/constants/asset_constants.dart';
import '../../core/extensions/context_extensions.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = context.cs.onPrimaryContainer;
    return Center(
      child: Lottie.asset(
        height: 120,
        AssetConstants.loading,
        frameRate: const FrameRate(30),
        delegates: LottieDelegates(
          values: [
            ValueDelegate.color(["**", "Resize", "**"], value: color),
            ValueDelegate.color(["**", "Rectangle", "**"], value: color),
          ],
        ),
      ),
    );
  }
}
