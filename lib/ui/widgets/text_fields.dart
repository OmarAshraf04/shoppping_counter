import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  const TextFields({super.key, required this.controller, required this.type});

  final TextEditingController controller;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Row(
          children: [
            Text(
              type.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const Text(
              ':',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        const SizedBox(
          height: 10,
        ),

        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty)
              {
                return 'This field shouldn\'t be empty ';
              }
          },
        ),

        const SizedBox(
          height: 30,
        ),

      ],
    );
  }
}
