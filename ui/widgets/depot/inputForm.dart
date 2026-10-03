import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final void Function(int) onChanged;
  final TextEditingController controller;

  const InputForm({
    super.key,
    required this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: controller, // parent's controller
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter amount of product",
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
              ),
              onChanged: (val) => onChanged(int.tryParse(val) ?? 0),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text("box", style: TextStyle(color: Colors.grey.withOpacity(0.9))),
        const SizedBox(width: 10),
      ],
    );
  }
}
