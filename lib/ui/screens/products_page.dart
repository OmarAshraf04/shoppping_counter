import 'package:flutter/material.dart';
import 'package:shopping_2/data/data_source/data_source.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        )),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xffCC725D),
        title: const Text('All products'),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.face_5,
            ),
          )
        ],
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
