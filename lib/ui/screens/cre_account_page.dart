import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_2/ui/screens/home_page.dart';
import 'package:shopping_2/ui/widgets/text_fields.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController nameControl = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future <void> createAccount(
      {
        required String email,
        required String password,
        required String name,
        required String uid,
      }) async
  {
    if (formKey.currentState!.validate())
    {
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password
        )
            .then((value) {
              if (value.user != null)
                {
              saveData(
                  email: emailControl.text,
                  name: nameControl.text,
                  password: passwordControl.text,
                  uid: value.user!.uid,
              ).then((value)
              {
                if (value)
                  {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                          return const MyHomePage();
                        }));
                  }
              });

        }});
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()))
        );
      }
    }
  }

  Future<bool> saveData(
  {
    required String email,
    required String name,
    required String password,
    required String uid,
  }) async{
    try
    {
      FirebaseFirestore.instance.collection('Users').doc(uid).set({
        'email' : email,
        'name' : name,
        'password' : password,
        'uid' : uid
      },
        SetOptions(merge: true));
      return true;
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()))
      );
      return false;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text(
          'Create an account',
          style: TextStyle(
              fontSize: 30
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,

      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 10
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextFields(
                controller: nameControl,
                type: 'Name',
              ),

              TextFields(
                controller: emailControl,
                type: 'Email',
              ),

              //Password Text Field
              const Row(
                children: [
                  Text(
                    'Password',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  Text(
                    ':',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              TextFormField(
                controller: passwordControl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty)
                  {
                    return 'This field shouldn\'t be empty ';
                  } else if (value.length < 6)
                  {
                    return 'This field should have more than 6 characters';
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 30,
              ),

              //END of Password Text Field
              ElevatedButton(
                  onPressed: () {
                    createAccount(
                      email: emailControl.text,
                      password: passwordControl.text,
                      name: nameControl.text,
                      uid: '',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.green,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 35,
                    )
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'Create Account'
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
