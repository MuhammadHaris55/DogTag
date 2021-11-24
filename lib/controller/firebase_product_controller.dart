import 'package:flutterdogtagapp/model/product_modal.dart';
import 'package:flutterdogtagapp/services/firebase_db.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  // 1  //Add a List of Product Object
  final products = <Product>[].obs;

  @override
  void onInit() {
    products.bindStream(FirestoreDB().getAllProduct());
    super.onInit();
  }
}
