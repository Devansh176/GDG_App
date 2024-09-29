import 'package:cloud_firestore/cloud_firestore.dart';

create(String collection, docName, brand, type, int weight, String ambassador, String imageUrl) async {
  await FirebaseFirestore.instance
      .collection(collection)
      .doc(docName)
      .set({
    'brand': brand,
    'type': type,
    'weight (in grams)': weight,
    'ambassador': ambassador,
    'images': FieldValue.arrayUnion([imageUrl]),
  });
  print("Database Updated");
}

update(String collection, docName, attribute, var newAttribute) async {
  await FirebaseFirestore.instance
      .collection(collection)
      .doc(docName)
      .update({attribute : newAttribute}
  );
  print("Fields Updated");
}

delete(String collection, docName) async {
  await FirebaseFirestore.instance.collection(collection).doc(docName).delete();
  print("Document Deleted");
}