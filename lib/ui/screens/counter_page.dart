import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  TextEditingController num1controller = TextEditingController();
  TextEditingController num2controller = TextEditingController();
  double sum = 0;

  void calSum() {
    setState(() {
      sum =
          double.parse(num1controller.text) + double.parse(num2controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          )
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xffCC725D),
        title: const Text(
            'Counter'
        ),

        actions: const [
          Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.face_5,
            ),
          )
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius:  BorderRadius.all(
                  Radius.circular(10)
                ),
                color: Color(0xff749BC2),
              ),
              child: Align(
                child: TextField(
                  controller: num1controller,
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius:  BorderRadius.all(
                    Radius.circular(10)
                ),
                color: Color(0xff749BC2),
              ),
              child: TextField(
                controller: num2controller,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xff5A6D7A)
              ),
              onPressed: () {
                calSum();
              },
              child: const Text(
                'Find Sum',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'New Sum = $sum',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
