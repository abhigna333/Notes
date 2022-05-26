import 'package:app_lock_face/api/local_auth.dart';
import 'package:app_lock_face/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FaceIdPage extends StatefulWidget {
  const FaceIdPage({Key? key}) : super(key: key);

  @override
  State<FaceIdPage> createState() => _FaceIdPageState();
}

class _FaceIdPageState extends State<FaceIdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
              onPressed: () async{
                final isAuth = await LocalAuthApi.authenticate();
                if (isAuth){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: ((context) => HomePage())),);
                }
              }, 
              icon: Icon(
                Icons.lock_open,
              ), 
              label: Text("Authenticate"),),),
    );
  }
}