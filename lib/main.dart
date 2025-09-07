import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/estimation_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => EstimationProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metreyar Quran Noor UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF006A4E),
        accentColor: Colors.greenAccent,
        scaffoldBackgroundColor: Color(0xFF101820),
        fontFamily: 'IranSans',
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF006A4E),
          centerTitle: true,
          elevation: 2,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF006A4E),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
