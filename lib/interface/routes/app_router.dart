import 'package:go_router/go_router.dart';

import '../pages/landing_page.dart';
import 'route_paths.dart';

class AppRouter {
  static final GoRouter hogwartsRoute = GoRouter(
    routes: [
      GoRoute(
        path: RoutePaths.landing,
        builder: (_, __) => const LandingPage(),
      ),
    ],
  );
}
