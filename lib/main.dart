import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_2/BlocObserver.dart';
import 'package:shopping_2/data/cubits/myapp_cubit.dart';
import 'package:shopping_2/firebase_options.dart';
import 'package:shopping_2/ui/screens/home_page.dart';
import 'package:shopping_2/ui/screens/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BlocProvider<MyAppCubit>(
    create: (context) => MyAppCubit()
      ..receive(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Urbanist',
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent
        )
      ),
      home: user == null ? LogInPage() : const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
