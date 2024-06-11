import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_theme/json_theme.dart';
import 'package:project_app/products/bloc/products_bloc.dart';
import 'package:project_app/products/products_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('products');

  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/themeData.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson);

  runApp(MyApp(theme: theme));
}

class MyApp extends StatelessWidget {
  final ThemeData? theme;
  const MyApp({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example Product',
      theme: theme ?? ThemeData(),
      home: BlocProvider<ProductsBloc>(
        create: (context) => ProductsBloc(),
        child: ProductsPage(),
      )
    );
  }
}
