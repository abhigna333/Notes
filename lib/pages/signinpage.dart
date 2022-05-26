import 'package:google_fonts/google_fonts.dart';
import 'package:app_lock_face/main.dart';
import 'package:app_lock_face/pages/forgotPasword.dart';
import 'package:app_lock_face/pages/signuppage.dart';
import 'package:app_lock_face/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool password_visible = true;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  Future signIn() async {
    showDialog(
      context: context, 
      builder: (context) => Center(child: CircularProgressIndicator(color: Colors.blueGrey),));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailcontroller.text.trim(), 
        password: _passwordcontroller.text.trim()
        );
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Login",
                style: GoogleFonts.nunito(fontSize: 30, fontWeight: FontWeight.w700),
              ),
            ),

            SizedBox(height: 50,),

            Container(
              padding: EdgeInsets.fromLTRB(27, 0, 27, 0),
              child: TextField(
                controller: _emailcontroller,
                
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: "Email"),
              ),
            ),

            SizedBox(height: 20.0,),

            Container(
              padding: EdgeInsets.fromLTRB(27, 0, 27, 0),
              child: TextField(
                controller: _passwordcontroller,
                obscureText: password_visible,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outlined),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        password_visible = !password_visible;
                      });
                    }, 
                    icon: Icon(
                      password_visible ? Icons.visibility_off : Icons.visibility
                    ),),
                  hintText: "Password"),
              ),
            ),

            SizedBox(height: 20.0,),

            Container(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  signIn();
                }, 
                child: Text(
                  "SignIn",
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),),
                style:ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 22, 91, 114),
                )
                ),
            ),

            SizedBox(height: 20.0,),

            GestureDetector(
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
              },
            ),

            SizedBox(height: 8.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't register? ",
                  style: TextStyle(fontWeight: FontWeight.bold,),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: ((context) => SignUpPage())));
                  }, 
                  child: Text(
                    "SignUp",
                    style: TextStyle(fontWeight: FontWeight.bold), ))
              ],
            )
          ],
        ),
      ),
    );
    
  }
}