import 'package:app_lock_face/Utils/card.dart';
import 'package:app_lock_face/pages/note_editor.dart';
import 'package:app_lock_face/pages/note_reader.dart';
import 'package:app_lock_face/pages/signinpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FirebaseAuth auth = FirebaseAuth.instance;
  

  String getuid() {
    return auth.currentUser!.uid.toString();
  }
    

  
  @override
  Widget build(BuildContext context) {  
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 24, 24),
      appBar: AppBar(
        elevation: 0.5,
        title: Text(
          'Notes',
          style: GoogleFonts.nunito(fontWeight: FontWeight.w700),),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 57, 56, 54),
        actions: [
          IconButton(
            onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => SignInPage()));}, 
            icon: Icon(Icons.logout),)
        ],
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            

            SizedBox(
              height: 10,
            ),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                                        .collection("Users")
                                        .doc(FirebaseAuth.instance.currentUser!.uid)
                                        .collection("Notes")
                                        .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(snapshot.hasData){
                    return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.5),
            
                      children: snapshot.data!.docs
                      .map((note) => NoteCard(() {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: ((context) => 
                                NoteReaderScreen(note))));
                      }, note))
                      .toList(),
                      );
                  }
                  return Text("There are no notes", style: GoogleFonts.nunito(color: Colors.white),);
                },),
            ),
              
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: ((context) => NoteEditorScreen())));
        }, 
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 57, 56, 54),
        ),
    );
  }
}