import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterdogtagapp/model/product_modal.dart';

class FirestoreDB {
  //Initilization Firebase CLoud Firestore
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Stream<List<Product>> getAllProduct() {
  //
  // }
  Stream<List<Product>> getAllProduct() {
    return _firebaseFirestore
        .collection('missingDogs')
        .snapshots()
        .map((snapshot) {
      print('object');
      print(snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList());
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
      // print(object)
    });
  }
}
