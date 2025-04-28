import "package:go_router/go_router.dart";

import "../pages/landing_page.dart";

class HogwartsRouter {
  const HogwartsRouter._();

  static const String landing = "/";
  static final GoRouter config = GoRouter(
    routes: [GoRoute(path: landing, builder: (_, __) => const LandingPage())],
  );
}
