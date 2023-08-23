import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_2/data/cubits/myapp_cubit.dart';
import 'package:shopping_2/data/cubits/myapp_state.dart';
import 'package:shopping_2/ui/screens/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // appBar: AppBar(
        //   leading: IconButton(
        //     onPressed: () {
        //       signOut().then((value) {
        //         if (value) {
        //           Navigator.pushReplacement(context,
        //               MaterialPageRoute(builder: (context) {
        //             return LogInPage();
        //           }));
        //         }
        //       });
        //     },
        //     icon: const Icon(Icons.logout_sharp),
        //   ),
        //   shape: const RoundedRectangleBorder(
        //       borderRadius: BorderRadius.only(
        //     bottomRight: Radius.circular(10),
        //     bottomLeft: Radius.circular(10),
        //   )),
        //   foregroundColor: Colors.white,
        //   backgroundColor: const Color(0xffCC725D),
        //   title: const Text('Profile'),
        // ),

        body: Column(
          children: [
            const SizedBox(height: 150,),

            BlocBuilder<MyAppCubit, MyAppState>(
                builder: (context, state) {
                  if (context.read<MyAppCubit>().userData != null
                  || state is DoneProfileState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 190,
                          width:  190,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                            border: Border.all(
                              color: Colors.black
                            )
                          ),
                          child: CircleAvatar(
                            radius: 75,
                            backgroundImage: context.read<MyAppCubit>().userData!.image == ' '
                                ? const NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
                                : NetworkImage(context.read<MyAppCubit>().userData!.image)
                          ),
                        ),

                        Positioned(
                          bottom: 7,
                          right: 10,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              color: Color(0xffF4F4F4),
                              shape: BoxShape.circle
                            ),
                            child: IconButton(
                                onPressed: () {
                                  context.read<MyAppCubit>().getPicture();
                                },
                                icon: const Center(child: Icon(Icons.camera))),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 50,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                          border: Border.all(color: Colors.black)
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 35,
                            ),

                            Text(
                              'User Name : ${context.read<MyAppCubit>().userData!.name}',
                              style: const TextStyle(
                                fontSize: 30,
                                fontFamily: 'RobotoCondensed'
                              ),
                            )
                          ],
                        ),
                      )
                    ),

                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,
                              border: Border.all(color: Colors.black)
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 35,
                              ),

                              Text(
                                'Email : ${context.read<MyAppCubit>().userData!.email}',
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'RobotoCondensed'
                                ),
                              )
                            ],
                          ),
                        )
                    ),

                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,
                              border: Border.all(color: Colors.black)
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 35,
                              ),

                              Text(
                                'Password : ${context.read<MyAppCubit>().userData!.password}',
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'RobotoCondensed'
                                ),
                              )
                            ],
                          ),
                        )
                    ),
                  ],
                );
              }
              else if (state is LoadingProfileState)
                {
                  return const Center(child: CircularProgressIndicator());
                }
              else{
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


              }),
          ],
        ));
  }
}


