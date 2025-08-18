import 'package:flutter/material.dart';

class EstimationForm extends StatefulWidget {
  @override
  _EstimationFormState createState() => _EstimationFormState();
}

class _EstimationFormState extends State<EstimationForm> {
  final _formKey = GlobalKey<FormState>();
  String description = "";
  double quantity = 0;
  double unitPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: "شرح فعالیت"),
            onSaved: (val) => description = val ?? "",
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "مقدار"),
            keyboardType: TextInputType.number,
            onSaved: (val) => quantity = double.tryParse(val ?? "0") ?? 0,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "قیمت واحد"),
            keyboardType: TextInputType.number,
            onSaved: (val) => unitPrice = double.tryParse(val ?? "0") ?? 0,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            child: Text("ثبت"),
            onPressed: () {
              _formKey.currentState?.save();
              print("شرح: $description, مقدار: $quantity, قیمت: $unitPrice");
            },
          ),
        ],
      ),
    );
  }
}
