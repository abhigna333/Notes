import 'package:app_lock_face/main.dart';
import 'package:app_lock_face/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final FormKey = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();

  Future resetPassword() async {
    showDialog(
      context: context, 
      builder: (context) => Center(child: CircularProgressIndicator(color: Colors.blueGrey),));


    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailcontroller.text.trim());

      Utils.showSnackBar("Reset Password Email Sent");
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
    
    
    
  }

  @override
  void dispose(){
    _emailcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Forgot Password",
                style: GoogleFonts.nunito(fontSize: 30, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "A mail will be sent to the registered email",
              style: GoogleFonts.nunito(fontWeight: FontWeight.w600),
            ),
            
            SizedBox(height: 50,),

            Container(
              padding: EdgeInsets.fromLTRB(27, 0, 27, 0),
              child: TextFormField(
                  controller: _emailcontroller,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: "Email"),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) => 
                        email != null && !EmailValidator.validate(email) ? 'Enter valid email' : null,
                ),
            ),

            SizedBox(height: 20,),

            ElevatedButton.icon(
              onPressed: () {
                resetPassword();
              }, 
              icon: Icon(Icons.mark_email_read_sharp), 
              label: Text("Reset Password"),)
          ],
        ),),
    );


  }
}