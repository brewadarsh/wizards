import 'package:flutter/material.dart';

import '../../core/constants/asset_constants.dart';
import '../../core/constants/color_constants.dart';
import '../../core/constants/padding_constants.dart';
import '../../core/constants/size_constants.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/extensions/widget_extensions.dart';
import '../../generated/l10n.dart';
import '../widgets/landing_button.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late final ImageProvider landingBackground;

  @override
  void initState() {
    landingBackground = const AssetImage(AssetConstants.hogwartsLanding);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(landingBackground, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final S locale = S.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: landingBackground, fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(locale.termsOfUse, style: basicStyle),
                  Text(locale.privacyPolicy, style: basicStyle),
                  Text(locale.version100, style: basicStyle),
                ],
              ),
            ),
            Text(locale.welcomeToThe, style: mainStyle),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: "${locale.hogwartsSchool} ", style: tagStyle),
                  TextSpan(text: locale.tagline, style: dimStyle),
                ],
              ),
            ),
            SizeConstants.h10,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(S.of(context).alohomora, style: basicStyle),
                GestureDetector(child: const LandingButton()),
              ],
            ),
          ],
        ).padding(PaddingConstants.defaultPx),
      ),
    );
  }

  // Text Styles.
  TextStyle? get mainStyle {
    return context.tt.headlineMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: ColorConstants.fontColor,
    );
  }

  TextStyle? get tagStyle {
    return context.tt.displaySmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: ColorConstants.fontColor,
    );
  }

  TextStyle? get dimStyle {
    return context.tt.displaySmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: ColorConstants.fontColorDim,
    );
  }

  TextStyle? get basicStyle {
    return context.tt.bodyLarge?.copyWith(
      fontWeight: FontWeight.bold,
      color: Colors.white54,
    );
  }
}
