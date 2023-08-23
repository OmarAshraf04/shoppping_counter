import 'package:flutter/material.dart';
import 'package:shopping_2/ui/screens/counter_page.dart';
import 'package:shopping_2/ui/screens/products_page.dart';
import 'package:shopping_2/ui/screens/profile_page.dart';


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
    CounterPage(),
    const ProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: screens[currentIndex],

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xff300046),
          borderRadius: BorderRadius.circular(50)
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            goPage(index);
          },
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color(0xff8391A1),

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate_rounded),
              label: 'Counter',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.face_3),
              label: 'Profile',
            )
          ],
        ),
      ),
    );
  }
}
