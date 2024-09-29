import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ImagesNCost Class (unchanged)
class ImagesNCost extends StatefulWidget {
  const ImagesNCost({super.key});

  @override
  State<ImagesNCost> createState() => _ImagesNCostState();
}

class _ImagesNCostState extends State<ImagesNCost> {
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
          "For You",
          style: GoogleFonts.aclonica(
            fontSize: fontSize * 2,
            fontWeight: FontWeight.w700,
            color: Colors.lightGreen[700],
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('Cricket Kit').doc('Bats').snapshots(),
        builder: (context, productSnapshot) {
          if (productSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(),
            );
          } else if (productSnapshot.hasError) {
            return Center(
              child: Text('Error: ${productSnapshot.error}'),
            );
          } else if (productSnapshot.data == null) {
            return Center(
              child: Text('Document not found'),
            );
          } else {
            final productData = productSnapshot.data!.data() as Map<String, dynamic>;
            // Handle potential null values in productData
            final imageUrl = productData['images']?.first ?? ''; // Use null check and default value
            final brand = productData['brand'];
            final type = productData['type'];
            final weight = productData['weight (in grams)'];
            final ambassador = productData['ambassador'];

            return ListView(
              children: [
                Image.network(
                  imageUrl,
                  width: width,
                  height: height * 0.4,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Brand : $brand',
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: padding),
                      Text(
                        'Type : $type',
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: padding),
                      Text(
                        'Weight : $weight',
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: padding),
                      Text(
                        'Ambassador : $ambassador',
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
