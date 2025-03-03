import 'package:flutter/material.dart';
import 'package:tst/presentation/ui/screens/crudapi_screen.dart';

class MyApp extends StatelessWidget {
  // PascalCase name
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        appBarTheme: const AppBarTheme(
          // const here as well
          color: Colors.blue,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: Crudapi(), // const here if ApiReadrightcons supports it
    );
  }
}
