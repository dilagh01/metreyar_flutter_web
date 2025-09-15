import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/router.dart';
import 'data/repositories/api_repository.dart';
import 'features/estimation/bloc/estimation_bloc.dart';

void main() {
  runApp(const MetreyarApp());
}

class MetreyarApp extends StatelessWidget {
  const MetreyarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ApiRepository()),
      ],
      child: MaterialApp.router(
        title: 'متره یار',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
import 'package:http/http.dart' as http;
import 'core/network/api_service.dart';

void main() async {
  final api = ApiService(
    baseUrl: 'https://metreyar.onrender.com',
    client: http.Client(),
  );

  final response = await api.get('/estimations');
  print('status: ${response.statusCode}');
  print('body: ${response.body}');
}
