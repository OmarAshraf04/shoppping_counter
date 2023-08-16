import 'package:flutter/material.dart';
import 'package:shopping_2/ui/screens/counter_page.dart';
import 'package:shopping_2/ui/screens/products_page.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int currentIndex = 0;

  void goPage(int index){
    setState(() {
      currentIndex = index;
    });
}

  List<Widget> screens = [
    const ProductPage(),
    const CounterPage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          goPage(index);
        },
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.black,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_rounded),
            label: 'Counter',
          ),
        ],
      ),
    );
  }
}
