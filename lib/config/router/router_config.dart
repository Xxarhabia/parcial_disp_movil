import 'package:primer_parcial/config/router/router_model.dart';
import 'package:primer_parcial/presentation/screen/agents/agents_screen.dart';
import 'package:primer_parcial/presentation/screen/home/home_screen.dart';

List<RouterModel> routerConfig = [
  RouterModel(
    name: "home", 
    title: "Home", 
    description: "Pantalla principal de presentación", 
    path: "/", 
    widgetBuilder: (context, state) => const HomeScreen()
  ),
  RouterModel(
    name: "agents", 
    title: "Agents", 
    description: "Pantalla destinada a visualizar los agentes de valorant", 
    path: "/agents", 
    widgetBuilder: (context, state) => const AgentsScreen()
  ),
];