import 'package:flutter/material.dart';
import 'package:primer_parcial/presentation/widget/layout/drawer_custom.dart';

class Layout extends StatelessWidget {
  
  final Widget child;
  final String title;
  
  const Layout({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: DrawerCustom(),
      body: SafeArea(child: Column(
        children: [
          Expanded(child: child)
        ],
      )),
    );
  }
}