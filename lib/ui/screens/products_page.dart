import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_2/data/data_source/data_source.dart';
import 'package:shopping_2/ui/screens/login_page.dart';
import '../widgets/contents.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();

    if (DataSource.products.isEmpty) {
      Future.delayed(Duration.zero, () async {
        var data = await DataSource.receive();
        setState(() {
          DataSource.products = data;
          DataSource.isLoading = false;
        });
      });
    }
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
        )),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xffCC725D),
        title: const Text('All products'),
      ),


      body: GridView.builder(
        itemBuilder: (context, index) {
          return DataSource.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Contents(products: DataSource.products[index],
                );
        },
        itemCount: DataSource.products.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),
    );
  }
}
