import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/asset_constants.dart';
import '../../core/constants/padding_constants.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/utils/app_injector.dart';
import '../../core/utils/app_state.dart';
import '../blocs/landing/landing_cubit.dart';
import '../widgets/landing_button.dart';
import '../widgets/loader.dart';

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

    _cubit.triggerPostLogin();
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
      body: BlocBuilder<LandingCubit, LandingState>(
        bloc: _cubit,
        builder: (final BuildContext context, final LandingState state) {
          if (state is LandingLoadingState) return const Loader();
          return LandingContent(
            background: _background,
            onAuthCallback: _cubit.triggerUserAuthentication,
          );
        },
      ),
    );
  }
}

/// The landing page default content.
class LandingContent extends StatelessWidget {
  final VoidCallback onAuthCallback;
  final ImageProvider<Object> background;

  const LandingContent({
    super.key,
    required this.background,
    required this.onAuthCallback,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle? defaultStyle = this.defaultStyle(context);
    final TextStyle? headingStyle = this.headingStyle(context);
    final TextStyle? highlightStyle = this.highlightStyle(context);
    final TextStyle? dimHighlightStyle = this.dimHighlightStyle(context);

    return Container(
      padding: PaddingConstants.defaultPx,
      decoration: BoxDecoration(
        image: DecorationImage(image: background, fit: BoxFit.cover),
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
          InkWell(onTap: onAuthCallback, child: const LandingButton()),
        ],
      ),
    );
  }

  TextStyle? defaultStyle(final BuildContext context) {
    return context.tt.bodyLarge?.copyWith(
      color: context.cs.onSurface.withAlpha(180),
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle? headingStyle(final BuildContext context) {
    return context.tt.headlineLarge?.copyWith(
      color: context.cs.onSurface.withAlpha(120),
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle? highlightStyle(final BuildContext context) {
    return context.tt.displaySmall?.copyWith(
      color: context.cs.onSurface.withAlpha(120),
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle? dimHighlightStyle(final BuildContext context) {
    return context.tt.displaySmall?.copyWith(
      color: context.cs.onSurface.withAlpha(80),
      fontWeight: FontWeight.bold,
    );
  }
}
