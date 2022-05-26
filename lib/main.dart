import 'package:app_lock_face/pages/faceidpage.dart';
import 'package:app_lock_face/pages/signinpage.dart';
import 'package:app_lock_face/Utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,

      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return FaceIdPage();

          } else {
            return SignInPage();
          }
        },),
    );
  }
}

/*class MainPage extends StatefulWidget {
  const MainPage({ Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {

    /*final firebaseUser =  Provider.of<AuthenticationService>(context);
    context.watch<User>();

    if(firebaseUser != null){
      return FaceIdPage();
    }

    return SignInPage();

    return StreamBuilder<User?>(
      stream: AuthenticationService.user,
      builder: (_, AsyncSnapshot<User?> snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          final User? user = snapshot.data;
          return user == null ? SignInPage() ? FaceIdPage();
        }
      });*/
  
  }
}*/



















