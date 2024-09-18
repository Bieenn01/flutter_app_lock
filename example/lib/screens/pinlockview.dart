import 'package:flutter/material.dart';

class PinLockView extends StatelessWidget {
  final Function(String) onSubmit;

  PinLockView({required this.onSubmit});

  final TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter PIN'),
      content: TextField(
        controller: pinController,
        obscureText: true,
        decoration: InputDecoration(hintText: 'Enter your PIN'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            String enteredPin = pinController.text;
            onSubmit(enteredPin);
            Navigator.of(context).pop();
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
