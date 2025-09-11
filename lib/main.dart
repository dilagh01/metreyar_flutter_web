import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/main_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => MainProvider()),
      ],
      child: MaterialApp(
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
        home: HomeScreen(), // این خط باید کار کند
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}





