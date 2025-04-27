import 'package:flutter/material.dart';

import '../../core/constants/asset_constants.dart';
import '../../core/constants/padding_constants.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/utils/app_injector.dart';
import '../blocs/landing/landing_cubit.dart';
import '../widgets/landing_button.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late final LandingCubit _cubit;
  late final ImageProvider _background;

  @override
  void initState() {
    _cubit = AppInjector.get<LandingCubit>();
    _background = const AssetImage(AssetConstants.hogwartsLanding);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(_background, context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: PaddingConstants.defaultPx,
        decoration: BoxDecoration(
          image: DecorationImage(image: _background, fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // The options.
            Expanded(
              child: Row(
                spacing: 15.0,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ABOUT US", style: defaultStyle),
                  Text("TERMS OF USE", style: defaultStyle),
                  Text("PRIVACY POLICY", style: defaultStyle),
                  Text("v1.0.0", style: defaultStyle),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: "WELCOME TO\n", style: headingStyle),
                  TextSpan(text: "THE HOGWARTS SCHOOL ", style: highlightStyle),
                  TextSpan(
                    text: "OF WITCHCRAFT AND WIZARDRY",
                    style: dimHighlightStyle,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: _cubit.authenticate,
              child: const LandingButton(),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle? get defaultStyle {
    return context.tt.bodyLarge?.copyWith(
      color: context.cs.onSurface.withAlpha(180),
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle? get headingStyle {
    return context.tt.headlineLarge?.copyWith(
      color: context.cs.onSurface.withAlpha(120),
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle? get highlightStyle {
    return context.tt.displaySmall?.copyWith(
      color: context.cs.onSurface.withAlpha(120),
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle? get dimHighlightStyle {
    return context.tt.displaySmall?.copyWith(
      color: context.cs.onSurface.withAlpha(80),
      fontWeight: FontWeight.bold,
    );
  }
}
