import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // تمام import ها در ابتدا
import 'core/network/api_service.dart';   // قبل از هر declaration دیگر

// فقط یک تابع main باید وجود داشته باشد
void main() async {
  // کدهای initialization اگر نیاز است
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metreyar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

// بقیه کدهای شما...
