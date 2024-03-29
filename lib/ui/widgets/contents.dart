import 'package:flutter/material.dart';
import 'package:shopping_2/data/models/products.dart';

class Contents extends StatelessWidget {
  final Products products;

  const Contents({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 180,
      decoration: const BoxDecoration(
          color: Color(0xff84CEEB),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          )),
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Stack(
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                  products.thumbnail,
                ))),
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xffCC725D),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            'Stock Left:',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            products.stock.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ))),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Text(
                products.title,
                style: const TextStyle(
                  fontSize: 13.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff749BC2)),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Added to cart')));
                      },
                      child: Row(
                        children: [
                          const Text('Price: \$'),
                          Text(products.price.toString()),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
