import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/home_screen.dart';
import 'view_models/categoria_view_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CategoriaViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Compras',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
