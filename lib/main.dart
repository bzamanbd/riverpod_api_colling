import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_api_colling/home_screen.dart';

void main() => runApp(ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Api Colling',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.red,
        ),
        home: const HomeScreen(),
      ),
    ));
