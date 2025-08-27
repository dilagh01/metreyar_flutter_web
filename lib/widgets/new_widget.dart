import 'package:flutter/material.dart';

class EestimationForm extends StatefulWidget {
  @override
  _EestimationFormState createState() => _EestimationFormState();
}

class _EestimationFormState extends State<EestimationForm> {
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
