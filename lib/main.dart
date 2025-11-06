import 'package:flutter/material.dart';
import 'routes.dart';

void main() {
  runApp(const UniGoApp());
}

class UniGoApp extends StatelessWidget {
  const UniGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniGo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: appRoutes,
    );
  }
}
