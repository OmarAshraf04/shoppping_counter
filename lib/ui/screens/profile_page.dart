import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_2/ui/screens/login_page.dart';
import '../../data/data_source/data_source.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


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
  void initState() {
    super.initState();

    if (DataSource.isLoadingProfile) {
      Future.delayed(Duration.zero, () async {
        var data = await DataSource.receiveFromFireStore();
        setState(() {
          DataSource.userData = data;
          DataSource.isLoadingProfile = false;
        });
      });
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
            )
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xffCC725D),
        title: const Text(
            'Profile'
        ),

      ),

      body: DataSource.isLoadingProfile
      ? const Center(child: CircularProgressIndicator())
      : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(7),
            child: Stack(
              children: [
                Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              DataSource.userData!.name,
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ))
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Name:',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                    ),
                  ),
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(7),
            child: Stack(
              children: [
                Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            DataSource.userData!.email,
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ))
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Email:',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                )

              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(7),
            child: Stack(
              children: [
                Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            DataSource.userData!.password,
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ))
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Password:',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                )

              ],
            ),
          ),

        ],
      )
    );
  }
}
