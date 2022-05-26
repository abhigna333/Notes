import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {

  //TextEditingController _titleController = TextEditingController();
  //TextEditingController _contentController = TextEditingController();
  
  String date = (DateTime.now().toString().split(" "))[0];

  String? title;
  String? content;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 24, 24),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 57, 56, 54),
        elevation: 0.5,
        title: Text("Add a new note"),),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration.collapsed(
                            hintText: "Title",
                          ),
                          style: TextStyle(
                            fontSize: 32.0,
                            
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          onChanged: (_val) {
                            title = _val;
                          },
                          validator: (_val) {
                            if (_val == null) {
                              return "Can't be empty !";
                            } else {
                              return null;
                            }
                          },
                        ),
      
                        SizedBox(height: 10.0,),
      
                        Text(date, style: TextStyle(color: Color.fromARGB(255, 248, 247, 247),)),
      
                        SizedBox(height: 30.0,),
      
                        TextFormField(
                          maxLines : null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration.collapsed(
                            hintText: "Note Description",
                          ),
                          style: TextStyle(
                            fontSize: 20.0,
                            
                            color: Colors.white,
                          ),
                          onChanged: (_val) {
                            content = _val;
                          },
                          validator: (_val) {
                            if (_val == null) {
                              return "Can't be empty !";
                            } else {
                              return null;
                            }
                          },
                         
                        ),
      
                        
                      ],
                    ),
              ),
             
            ],
          ),),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            
            FirebaseFirestore.instance
                              .collection("Users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("Notes")                              
                              .add({
              "title" : title,
              "date" : date,
              "content" : content,
            }).then((value) {
                print(value.id);
                Navigator.pop(context);
          }).catchError((error) => print("Failed to add note $error"));
          }, 
          
          child: Icon(Icons.save),
        ),
    );
  }
}















 /*TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Title"
                ),
                style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 248, 247, 247)),
            ),

            SizedBox(height: 10.0,),

            Text(date, style: TextStyle(color: Color.fromARGB(255, 248, 247, 247),)),

            SizedBox(height: 30.0,),

            TextField(
              controller: _contentController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Content"
                ),
                style: TextStyle(color: Color.fromARGB(255, 248, 247, 247)),
            ),*/