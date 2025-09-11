import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen.dart'; // import صحیح

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'متره‌یار',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      home: HomeScreen(), // حالا باید کار کند
      debugShowCheckedModeBanner: false,
    );
  }
}
