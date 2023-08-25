import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_2/data/cubits/myapp_cubit.dart';
import 'package:shopping_2/data/cubits/myapp_state.dart';
import 'package:shopping_2/ui/screens/home_page.dart';
import 'package:shopping_2/ui/widgets/textfields.dart';

// ignore: must_be_immutable
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 65, bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffE8ECF4)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new)),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Text(
                    'Welcome back! Glad\nto see you, Again!',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff1E232C)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFields(
                      controller: nameControl,
                      hint: 'Username',
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'This field shouldn\'t be empty ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomTextFields(
                      controller: emailControl,
                      hint: 'Email',
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'This field shouldn\'t be empty ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomTextFields(
                      controller: passwordControl,
                      hint: 'Password',
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'This field shouldn\'t be empty ';
                        } else if (value.length < 6) {
                          return 'This field should have more than 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomTextFields(
                      controller: passwordConfirm,
                      hint: 'Confirm Password',
                      validation: (value) {
                        if (value != passwordControl.text) {
                          return 'This field should match your password.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: BlocConsumer<MyAppCubit, MyAppState>(
                          listener: (context, state) {
                        if (state is DoneCreateState) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const MyHomePage();
                            }),
                            (route) => false,
                          );
                        } else if (state is ErrorCreateState) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  title: Center(
                                    child: Text(
                                      'Error,please try again later.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              });
                        }
                      }, builder: (context, state) {
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
                              minimumSize: const Size(double.infinity, 56),
                              backgroundColor: (state is LoadingLoginState)
                                  ? Colors.grey
                                  : const Color(0xff300046),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: (state is LoadingLoginState)
                                ? const CircularProgressIndicator(
                                    color: Color(0xff300046),
                                    backgroundColor: Colors.white,
                                  )
                                : const Text('Register'),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Color(0xffE8ECF4),
                      height: 20,
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
                    ),
                  ),
                  Text(
                    'Or Login with',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff6A707C)),
                  ),
                  Expanded(
                    child: Divider(
                      color: Color(0xffE8ECF4),
                      height: 20,
                      thickness: 1,
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
                        borderRadius: const BorderRadiusDirectional.all(
                            Radius.circular(10)),
                        color: Colors.white,
                        border: Border.all(color: const Color(0xffDADADA))),
                    child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset('assets/icons/facebook.svg')),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadiusDirectional.all(
                            Radius.circular(10)),
                        color: Colors.white,
                        border: Border.all(color: const Color(0xffDADADA))),
                    child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/icons/google.svg',
                        )),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadiusDirectional.all(
                            Radius.circular(10)),
                        color: Colors.white,
                        border: Border.all(color: const Color(0xffDADADA))),
                    child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/icons/apple.svg',
                          height: 100,
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 142,
            )
          ],
        ),
      ),
    );
  }
}
