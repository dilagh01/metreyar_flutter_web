import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/estimation_provider.dart';

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

          return ListView.builder(
            itemCount: estimation.materials.length,
            itemBuilder: (context, index) {
              final material = estimation.materials[index];
              return Card(
                color: Colors.black.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFF006A4E)),
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: ListTile(
                  title: Text(material['name'], style: TextStyle(color: Colors.white)),
                  subtitle: Text('قیمت: ${material['price']} تومان', style: TextStyle(color: Colors.greenAccent)),
                  trailing: Text(material['unit'], style: TextStyle(color: Colors.white70)),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<EstimationProvider>().loadMaterials(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
