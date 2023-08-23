import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_2/data/cubits/myapp_cubit.dart';
import 'package:shopping_2/data/cubits/myapp_state.dart';
import 'package:shopping_2/ui/screens/home_page.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({super.key});

  TextEditingController emailControl = TextEditingController();

  TextEditingController passwordControl = TextEditingController();

  TextEditingController passwordConfirm = TextEditingController();

  TextEditingController nameControl = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  child: IconButton(onPressed: () {
                    Navigator.pop(context);
                  },
                      icon: const Icon(Icons.arrow_back_sharp,)
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 20,
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
            height: 60,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  TextFormField(
                    controller: nameControl,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Username:',
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

                  const SizedBox(height: 12,),

                  TextFormField(
                    controller: emailControl,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Email:',
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

                  const SizedBox(height: 12,),

                  TextFormField(
                    controller: passwordControl,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Password:',
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

                  const SizedBox(height: 12,),

                  TextFormField(
                    controller: passwordConfirm,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Confirm Password:',
                        hintStyle: const TextStyle(
                            color: Colors.black
                        )
                    ),
                    validator: (value) {
                      if (value!.isEmpty)
                      {
                        return 'This field shouldn\'t be empty ';
                      } else if (value != passwordControl.text)
                        {
                          return 'This field should match your password.';
                        }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: BlocConsumer<MyAppCubit, MyAppState>(
                      listener: (context, state) {
                        if (state is DoneCreateState)
                          {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                                  return const MyHomePage();
                                }));
                          } else if (state is ErrorCreateState)
                            {
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
                      builder: (context, state) {
                        return ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await context.read<MyAppCubit>().createAccount(
                                  email: emailControl.text,
                                  password: passwordControl.text,
                                  name: nameControl.text,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: (state is LoadingCreateState)
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
                              child: (state is LoadingCreateState)
                                  ? const Center(child: CircularProgressIndicator(
                                color: Colors.white,
                                backgroundColor: Colors.black
                              ))
                                  : const Text('Register')
                            )
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10,),

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
            crossAxisAlignment: CrossAxisAlignment.end,
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
          )
        ],
      ),
    );
  }
}

