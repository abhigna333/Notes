import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

Widget NoteCard(Function()? onTap, QueryDocumentSnapshot doc){
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(204, 28, 27, 27),
        borderRadius: BorderRadius.circular(10.0),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(doc["title"], 
                style: GoogleFonts.robotoFlex(fontWeight: FontWeight.w700, fontSize: 17, color: Colors.white),
                overflow: TextOverflow.ellipsis,),

          SizedBox(height: 5.0,),

          Text(
            doc["date"],
            style: TextStyle(fontSize: 12,fontFamily: "lato", color: Colors.white70),
            ),

          SizedBox(height: 10.0,),

          Text(
            doc["content"],
            style: GoogleFonts.robotoFlex(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),

        ],
      ),
    ),
  );
}