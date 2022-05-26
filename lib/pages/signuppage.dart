import 'package:google_fonts/google_fonts.dart';
import 'package:app_lock_face/main.dart';
import 'package:app_lock_face/pages/signinpage.dart';
import 'package:app_lock_face/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _confirmpasswordcontroller = TextEditingController();
  bool password_visible = true;

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;

    showDialog(
      context: context, 
      builder: (context) => Center(child: CircularProgressIndicator(color: Colors.blueGrey),));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
              child: Text(
                "Sign Up",
                style: GoogleFonts.nunito(fontSize: 30, fontWeight: FontWeight.w700),
              ),
            ),

            SizedBox(height: 50,),

              Container(
                padding: EdgeInsets.fromLTRB(27, 0, 27, 0),
                child: TextFormField(
                  controller: _emailcontroller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    hintText: "Email"),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) => 
                        email != null && !EmailValidator.validate(email) ? 'Enter valid email' : null,
                ),
              ),
        
              SizedBox(height: 20.0,),

              Container(
                padding: EdgeInsets.fromLTRB(27, 0, 27, 0),
                child: TextFormField(
                  controller: _passwordcontroller,
                  obscureText: true,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.length < 7 ? "Enter min. of 7 characters" : null,
                ),
              ),
        
              SizedBox(height: 20.0,),

              
        
              Container(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    signUp();
                  }, 
                  child: Text("SignUp")),
              ),
        
              SizedBox(height: 20.0,),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already registered? ",
                    style: TextStyle(fontWeight: FontWeight.bold,), 
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: ((context) => SignInPage())));
                    }, 
                    child: Text(
                      "SignIn",
                      style: TextStyle(fontWeight: FontWeight.bold), ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}