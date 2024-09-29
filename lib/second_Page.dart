import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdg_app/Pages/kit_List.dart';
import 'package:gdg_app/firebase_Auth/databaseFunction.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  Future<void> uploadImageAndCreateEntry() async {
    try {
      final imagePath = 'assets/NbBat.jpg'; // Replace with your actual image path
      final byteData = await getByteData(imagePath);
      final storageRef = FirebaseStorage.instance.ref().child(imagePath);
      await storageRef.putData(byteData);
      final downloadedImageUrl = await storageRef.getDownloadURL();

      create(
        'Cricket Kit',
        'Bats',
        'New Balance',
        'English Willow',
        1300,
        'Pat Cummins',
        downloadedImageUrl,
      );
    } catch (e) {
      print("Error Uploading the image: $e");
    }
  }

  Future<Uint8List> getByteData(String imagePath) async {
    if (imagePath.startsWith('http')) {
      final response = await Dio().get(Uri.parse(imagePath) as String);
      return response.data;
    } else {
      final imageData = await rootBundle.load(imagePath);
      return await imageData.buffer.asUint8List();
    }
  }

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
        title: Text(
          "Database",
          style: GoogleFonts.aclonica(
            fontSize: fontSize * 2,
            fontWeight: FontWeight.w700,
            color: Colors.lightGreen[700],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.leave_bags_at_home),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.lime[50],
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  uploadImageAndCreateEntry();
                  print("Image uploaded !!!");
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.lime[50]!),
                    side: WidgetStateProperty.all(BorderSide(color: Colors.lightGreen[900]!))
                ),
                child: Text(
                  "Create",
                  style: TextStyle(
                    color: Colors.green[900],
                    fontSize: fontSize,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const KitList()),
                  );
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.lime[50]!),
                    side: WidgetStateProperty.all(BorderSide(color: Colors.lightGreen[900]!))
                ),
                child: Text(
                  "Retrieve",
                  style: TextStyle(
                    color: Colors.green[900],
                    fontSize: fontSize,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  update('Cricket Kit', 'Bats', 'ambassador', 'Pat Cummins');
                  update('Cricket Kit', 'Bats', 'brand', 'New Balance');
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.lime[50]!),
                    side: WidgetStateProperty.all(BorderSide(color: Colors.lightGreen[900]!))
                ),
                child: Text(
                  "Update",
                  style: TextStyle(
                    color: Colors.green[900],
                    fontSize: fontSize,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  delete("Cricket Kit", "Helmet");
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.lime[50]!),
                    side: WidgetStateProperty.all(BorderSide(color: Colors.lightGreen[900]!))
                ),
                child: Text(
                  "Delete",
                  style: TextStyle(
                    color: Colors.green[900],
                    fontSize: fontSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

