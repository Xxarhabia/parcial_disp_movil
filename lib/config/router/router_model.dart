import 'package:go_router/go_router.dart';

class RouterModel {
  String name;
  String title;
  String description;
  String path;
  GoRouterWidgetBuilder widgetBuilder;

  RouterModel({
    required this.name,
    required this.title,
    required this.description,
    required this.path,
    required this.widgetBuilder,
  });
}