import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_2/data/cubits/profile_cubit.dart';
import 'package:shopping_2/data/cubits/profile_state.dart';
import 'package:shopping_2/ui/screens/login_page.dart';
import 'package:shopping_2/ui/widgets/userdata_fields.dart';

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
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Are you sure you want to log out'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        signOut().then((value) {
                          if (value) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return LogInPage();
                              }),
                              (route) => false,
                            );
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Yes',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20)),
                        child: const Text('No'))
                  ],
                ),
              );
            },
            icon: const Icon(Icons.logout_sharp),
          ),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        body: BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit()..receiveFromFireStore(),
          child: Column(
            children: [
              const SizedBox(height: 60),
              BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                if (context.read<ProfileCubit>().userData != null ||
                    state is DoneProfileState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 190,
                            width: 190,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                                border: Border.all(color: Colors.black)),
                            child: CircleAvatar(
                                radius: 75,
                                backgroundImage: context
                                            .read<ProfileCubit>()
                                            .userData!
                                            .image ==
                                        ' '
                                    ? const NetworkImage(
                                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
                                    : NetworkImage(context
                                        .read<ProfileCubit>()
                                        .userData!
                                        .image)),
                          ),
                          Positioned(
                            bottom: 7,
                            right: 10,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                  color: Color(0xffF4F4F4),
                                  shape: BoxShape.circle),
                              child: IconButton(
                                  onPressed: () {
                                    context.read<ProfileCubit>().getPicture();
                                  },
                                  icon:
                                      const Center(child: Icon(Icons.camera))),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      UserDataFields(
                          field: 'User Name',
                          data: context.read<ProfileCubit>().userData!.name),
                      UserDataFields(
                          field: 'Email',
                          data: context.read<ProfileCubit>().userData!.email),
                      UserDataFields(
                          field: 'Password',
                          data: context.read<ProfileCubit>().userData!.password)
                    ],
                  );
                } else if (state is LoadingProfileState) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(
                    child: Text(
                      'Error, please try again later',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  );
                }
              }),
            ],
          ),
        ));
  }
}
