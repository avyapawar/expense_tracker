import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';
var kColorScheme = ColorScheme.fromSeed(seedColor:const Color.fromARGB(255, 15, 40, 255)) ;

void main() {
  runApp(
    MaterialApp(
    theme: ThemeData().copyWith(
      colorScheme: kColorScheme,
      useMaterial3: true,
      appBarTheme:  const AppBarTheme().copyWith(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.primaryContainer,
      ),
      cardTheme: const CardTheme().copyWith(
      color: kColorScheme.primaryContainer,
      margin: const EdgeInsets.all(8),
      ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kColorScheme.primaryContainer
      )),
      textTheme: const TextTheme().copyWith(
        titleLarge:  const TextStyle(color: Colors.black,
        fontSize: 14,

        fontWeight: FontWeight.bold
        )
      )
    ),
   home:  const Expenses(),
    )
  );
}

