import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_2/data/cubits/myapp_cubit.dart';
import 'package:shopping_2/data/cubits/myapp_state.dart';
import 'package:shopping_2/ui/screens/cre_account_page.dart';
import 'package:shopping_2/ui/screens/home_page.dart';

// ignore: must_be_immutable
class LogInPage extends StatelessWidget {
  LogInPage({super.key});

  TextEditingController emailControl = TextEditingController();

  TextEditingController passwordControl = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: const Text(
      //     'Log in',
      //     style: TextStyle(
      //         fontSize: 30
      //     ),
      //   ),
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.white,
      //   foregroundColor: Colors.black,
      //   elevation: 0,
      //
      // ),

      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.23,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
                'Welcome back! Glad to see you, Again!',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  TextFormField(
                    controller: emailControl,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Enter your email here:',
                        hintStyle: const TextStyle(
                          color: Colors.black
                        )
                    ),
                    validator: (value) {
                      if (value!.isEmpty)
                      {
                        return 'This field shouldn\'t be empty ';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                    controller: passwordControl,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Enter your password here:',
                        hintStyle: const TextStyle(
                            color: Colors.black
                        )
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field shouldn\'t be empty ';
                      } else if (value.length < 6) {
                        return 'This field should have more than 6 characters';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: BlocConsumer<MyAppCubit, MyAppState>(
                      listener: (context, state) {
                        if(state is DoneLoginState) {
                          Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => const MyHomePage()));
                        } else if (state is ErrorLoginState) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  title: Center(
                                    child: Text(
                                      'Error,please try again later.',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                );
                            }
                          );
                        }
                      },
                      builder:  (context,state) {
                        return ElevatedButton(
                          onPressed: () {
                            if(formKey.currentState!.validate()) {
                              context.read<MyAppCubit>().login(
                              email: emailControl.text,
                              password: passwordControl.text,
                            );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: (state is LoadingLoginState)
                                  ? Colors.grey
                                  : const Color(0xff300046),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 35,
                              )

                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: (state is LoadingLoginState)
                                ? const CircularProgressIndicator(
                              color: Colors.white,
                              backgroundColor: Colors.black,
                            )
                                : const Text(
                                'Log in'
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 10,
                    indent: 5,
                    endIndent: 5,
                  ),
                ),

                Text(
                    'Or Login with',
                style: TextStyle(
                  fontSize: 17.5,
                  fontFamily: 'RobotoCondensed',
                  fontStyle: FontStyle.italic
                ),),

                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 10,
                    indent: 5,
                    endIndent: 5,
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                  child: IconButton(
                      onPressed: () {

                      },
                      icon: SvgPicture.asset('assets/icons/google.svg')
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.black
                      )
                  ),
                  child: IconButton(
                      onPressed: () {

                      },
                      icon: SvgPicture.asset('assets/icons/apple.svg',)
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.black
                      )
                  ),
                  child: IconButton(
                      onPressed: () {

                      },
                      icon: SvgPicture.asset('assets/icons/twitter.svg',height: 100,)
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 50,
          ),

          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account?',
                  style:TextStyle(
                    fontSize: 20
                  ),),

                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) {
                              return CreateAccount();
                            }));
                    },
                  child: const Text(
                    'Register Now',
                    style:TextStyle(
                        fontSize: 20,
                      color: Colors.red,
                    ),
                  ),)
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ElevatedButton(
// onPressed: () {

// },
// style: ElevatedButton.styleFrom(
// foregroundColor: Colors.black,
// backgroundColor: Colors.green,
// shape: const RoundedRectangleBorder(
// borderRadius: BorderRadius.all(Radius.circular(10)),
// ),
// textStyle: const TextStyle(
// fontSize: 35,
// )
//
// ),

// ),

