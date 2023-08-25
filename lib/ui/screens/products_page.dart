import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_2/data/cubits/myapp_cubit.dart';
import 'package:shopping_2/data/cubits/myapp_state.dart';

import '../widgets/contents.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        toolbarHeight: 76,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Welcome to \nEGYDYNAMIC..',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        actions: const [
          Image(
            image: AssetImage('assets/photos/img.png'),
            height: 57,
          )
        ],
      ),
      body: BlocBuilder<MyAppCubit, MyAppState>(
        builder: (context, state) {
          if (state is LoadingGridState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DoneGridState ||
              context.read<MyAppCubit>().products.isNotEmpty) {
            return GridView.builder(
              itemBuilder: (context, index) {
                return Contents(
                  products: context.read<MyAppCubit>().products[index],
                );
              },
              itemCount: context.read<MyAppCubit>().products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
            );
          } else {
            return const Center(
              child: Text(
                'Error, please try again later',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            );
          }
        },
      ),
    );
  }
}
