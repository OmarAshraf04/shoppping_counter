import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_2/ui/screens/cre_account_page.dart';
import 'package:shopping_2/ui/screens/home_page.dart';
import 'package:shopping_2/ui/widgets/text_fields.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future <void> login(
      {
        required String email,
        required String password,
      }) async
  {
    if (formKey.currentState!.validate())
    {
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password
        )
            .then((value) => {
              if (value.user != null) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                return const MyHomePage();
              }))
        }});
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()))
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text(
          'Log in',
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
                validator: (value)
                {
                  if (value!.isEmpty)
                  {
                    return 'This field shouldn\'t be empty ';
                  } else if (value.length < 6)
                  {
                    return 'This field should have more than 6 characters';
                  }
                },
              ),

              const SizedBox(
                height: 30,
              ),

              //END of Password Text Field
              SizedBox(
                width: 289,
                child: ElevatedButton(
                    onPressed: () {
                      login(
                        email: emailControl.text,
                        password: passwordControl.text,
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
                          'Log in'
                      ),
                    ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'OR',
                  style: TextStyle(
                     fontSize: 25,
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) {
                        return const CreateAccount();
                      } ));
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
