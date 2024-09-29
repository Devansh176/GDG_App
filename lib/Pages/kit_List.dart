import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'images_n_Cost.dart';

class KitList extends StatefulWidget {
  const KitList({super.key});

  @override
  State<KitList> createState() => _KitListState();
}

class _KitListState extends State<KitList> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;
    final double padding = width * 0.05;
    final double fontSize = width * 0.05;

    return Scaffold(
      backgroundColor: Colors.lime[50],
      appBar: AppBar(
        backgroundColor: Colors.lime[50],
        title: Text(
          "Cricket Kit",
          style: GoogleFonts.aclonica(
            fontSize: fontSize * 2,
            fontWeight: FontWeight.w700,
            color: Colors.lightGreen[700],
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(padding),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Cricket Kit').snapshots(),
            builder: (context, batSnapshot){
              if(batSnapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              else{
                final batDocs = batSnapshot.data!.docs;
                return ListView.builder(
                    itemCount: batDocs.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: EdgeInsets.only(bottom: padding * 0.9),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ImagesNCost(),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 15,
                            color: Colors.lime[600],
                            child : ListTile(
                              title: Text(batDocs[index]['brand'],
                                style: TextStyle(
                                  color: Colors.lightGreen[900],
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(batDocs[index]['type'],
                                style: TextStyle(
                                  fontSize: fontSize * 0.75,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                );
              }
            }
        ),
      ),
    );
  }
}