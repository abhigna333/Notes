import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;
  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  bool edit = false;
  String? title;
  String? content;
  String date = (DateTime.now().toString().split(" "))[0];
  GlobalKey<FormState> Formkey = GlobalKey<FormState>();

  void delete() async {
    
    await widget.doc.reference.delete();
    Navigator.pop(context);
  }

  void save() async {
    
      await widget.doc.reference.update({
        'title': title, 
        'date' : date, 
        'content': content},
      );
    
    Navigator.of(context).pop();
    
  }
 

  @override
  Widget build(BuildContext context) {
    title = widget.doc['title'];
    content = widget.doc['content'];

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 24, 24),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 57, 56, 54),
        elevation: 0.5,
        title: TextFormField(
          decoration: InputDecoration.collapsed(
            hintText: "Title",
          ),
          style: TextStyle(
            fontSize: 20.0,
            
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          initialValue: widget.doc['title'],
          enabled: edit,
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
        actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  edit = !edit;
                });
              }, 
              icon: Icon(Icons.edit)),
    
          
            IconButton(
              onPressed: delete, 
              icon: Icon(Icons.delete),)
          ],
          ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Form(
                    child: Column(
                      children: [    
                        //Text(date, style: TextStyle(color: Color.fromARGB(255, 248, 247, 247),)),
      
                        SizedBox(height: 20.0,),
      
                        TextFormField(
                          maxLines : null,
                          
                          decoration: InputDecoration.collapsed(
                            hintText: "Note Description",
                          ),
                          style: TextStyle(
                            fontSize: 20.0,
                            
                            color: Colors.white,
                          ),
                          initialValue: widget.doc['content'],
                          enabled: edit,
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
          onPressed: save, 
          
          child: Icon(Icons.save),
          backgroundColor: Color.fromARGB(255, 57, 56, 54),
        ),
    );
    
  }
}


















/*return SingleChildScrollView(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 24, 24, 24),
        appBar: AppBar(
          title: Text("Your note"),
          backgroundColor: Color.fromARGB(255, 57, 56, 54),
          elevation: 0.5,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  edit = !edit;
                });
              }, 
              icon: Icon(Icons.edit)),
    
          
            IconButton(
              onPressed: () {
                
              }, 
              icon: Icon(Icons.delete),)
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: Formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    initialValue: title,
                    enabled: edit,
                    onChanged: (_val) {
                      title = _val;
                    },
                  ),
                      
                  SizedBox(height: 8.0,),
                      
                  Text(
                    widget.doc["date"],
                    style: TextStyle(color: Color.fromARGB(255, 248, 247, 247)),    ),
                      
                  SizedBox(height: 20.0,),
                  
                  TextFormField(
                    maxLines : 20,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration.collapsed(
                      hintText: "Note Description",
                    ),
                    style: TextStyle(
                      fontSize: 20.0,
                      
                      color: Colors.white,
                    ),
                    initialValue: widget.doc['content'],
                    enabled: edit,
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
          
          ),
        ),
      floatingActionButton: edit ?  FloatingActionButton(
                              onPressed: () {}, 
    
                              child: Icon(Icons.save),)
                              : null,
      ),
    );*/