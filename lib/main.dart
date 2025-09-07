void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EstimationProvider()),
      ],
      child: MaterialApp(
        home: MaterialsScreen(), // یا CalculationScreen
      ),
    ),
  );
}
