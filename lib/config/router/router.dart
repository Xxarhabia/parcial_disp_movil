import 'package:go_router/go_router.dart';
import 'package:primer_parcial/config/router/router_config.dart';
import 'package:primer_parcial/presentation/shared/Layout.dart';

final GoRouter router = GoRouter(
  initialLocation: "/",
  routes: <RouteBase> [
    ShellRoute(
      builder: (context, state, child) {
        return Layout(child: child, title: "App");
      },
      routes: routerConfig
        .map(
          (route) => GoRoute(
            path: route.path,
            name: route.name,
            builder: route.widgetBuilder,
          )
        ).toList()
    )
  ]
);