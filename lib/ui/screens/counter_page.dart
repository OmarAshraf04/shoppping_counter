import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_2/ui/screens/login_page.dart';

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

  Future<bool> signOut() async{
    try{
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e)
    {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            signOut().then((value) {
              if (value)
              {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                      return const LogInPage();
                    }));
              }
            });
          },
          icon: const Icon(
              Icons.logout_sharp
          ),
        ),
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
