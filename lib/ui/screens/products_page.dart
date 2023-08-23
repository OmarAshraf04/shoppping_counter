import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_2/data/cubits/myapp_cubit.dart';
import 'package:shopping_2/data/cubits/myapp_state.dart';
import 'package:shopping_2/ui/screens/login_page.dart';
import '../widgets/contents.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  // @override
  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
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
              if (value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return LogInPage();
                }));
              }
            });
          },
          icon: const Icon(Icons.logout_sharp),
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


      body: BlocBuilder < MyAppCubit , MyAppState >(
        builder: (context , state) {
          if (state is LoadingGridState)
            {
              return const Center(child: CircularProgressIndicator());
            }

          else if (state is DoneGridState ||
              context.read<MyAppCubit>().products.isNotEmpty){
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
          } else{
            return const Center(
              child: Text(
                'Error, please try again later',
                style: TextStyle(
                    fontSize:25,
                    fontWeight: FontWeight.bold
                ),
              ),
            );
          }
        },
      )
    );
  }
}


