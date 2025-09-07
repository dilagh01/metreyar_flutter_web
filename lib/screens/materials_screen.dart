import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:metreyar/providers/estimation_provider.dart';

class MaterialsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('مواد اولیه')),
      body: Consumer<EstimationProvider>(
        builder: (context, estimation, child) {
          if (estimation.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (estimation.materials.isEmpty) {
            return Center(child: Text('هیچ ماده‌ای یافت نشد'));
          }

          return ListView.builder(
            itemCount: estimation.materials.length,
            itemBuilder: (context, index) {
              final material = estimation.materials[index];
              return ListTile(
                title: Text(material['name']),
                subtitle: Text('قیمت: ${material['price']} تومان'),
                trailing: Text(material['unit']),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            context.read<EstimationProvider>().loadMaterials(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
