class CalculationScreen extends StatefulWidget {
  @override
  _CalculationScreenState createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  final _materialsCostController = TextEditingController();
  final _laborCostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('محاسبه برآورد')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _materialsCostController,
              decoration: InputDecoration(labelText: 'هزینه مواد'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _laborCostController,
              decoration: InputDecoration(labelText: 'هزینه نیروی کار'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              child: Text('محاسبه'),
            ),
            SizedBox(height: 20),
            Consumer<EstimationProvider>(
              builder: (context, estimation, child) {
                if (estimation.calculationResult != null) {
                  return _buildResult(estimation.calculationResult!);
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResult(Map<String, dynamic> result) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('نتایج محاسبه:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('هزینه کل: ${result['result']['total_cost']} تومان'),
            Text('هزینه مواد: ${result['result']['materials_cost']} تومان'),
            Text('هزینه نیروی کار: ${result['result']['labor_cost']} تومان'),
            Text('مالیات: ${result['result']['tax_amount']} تومان'),
          ],
        ),
      ),
    );
  }

  void _calculate() async {
    try {
      await context.read<EstimationProvider>().calculateEstimation({
        'materials_cost': double.parse(_materialsCostController.text),
        'labor_cost': double.parse(_laborCostController.text),
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطا در محاسبه: $e')),
      );
    }
  }
}
