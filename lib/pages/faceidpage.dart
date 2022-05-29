import 'package:app_lock_face/api/local_auth.dart';
import 'package:app_lock_face/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Heyy There!",
              style: GoogleFonts.nunito(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10.0,),

            Text(
              "Let's get your notes"
            ),

            SizedBox(height: 30.0,),

            Icon(Icons.face_outlined, size: 75,),

            SizedBox(height: 30.0,),

            ElevatedButton.icon(
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
                  label: Text("Authenticate"),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 21, 137, 214),
                  ),
            )
          ],
        ),
      ),
    );
  }
}