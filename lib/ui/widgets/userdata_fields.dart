import 'package:flutter/material.dart';

class UserDataFields extends StatelessWidget {
  final String field;
  final String data;

  const UserDataFields({super.key, required this.field, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Container(
          height: 57,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xffDADADA),
              border: Border.all(color: const Color(0xff000000))),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                width: 19,
              ),
              Text(
                '$field : $data',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Urbanist',
                    color: Color(0xff000000)),
              )
            ],
          ),
        ));
  }
}
