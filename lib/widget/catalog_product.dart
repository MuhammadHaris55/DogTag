import 'package:flutter/material.dart';
import 'package:flutterdogtagapp/controller/firebase_product_controller.dart';
import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutterdogtagapp/screens/dogInfo.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CatalogProduct extends StatelessWidget {
  final productController = Get.put(ProductController());
  CatalogProduct({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productController.products.length,
            itemBuilder: (BuildContext context, int index) {
              return CatalogProductCard(index: index);
            }),
      ),
    );
  }
}

class CatalogProductCard extends StatelessWidget {
  final ProductController productController = Get.find();
  final int index;
  CatalogProductCard({
    Key key,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        // Get.to(dogInfo(
        //   index: index,
        // ));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => dogInfo(
              index: index,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        width: screen.width / 3,
        height: screen.width / 2.2,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 5.0,
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: screen.width / 3,
              height: screen.width / 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    productController.products[index].ImageUrl ??
                        'https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg',
                  ),
                ),
              ),
            ),

            // Container(
            //   width: screen.width / 3,
            //   height: screen.width / 4,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       // image: NetworkImage(
            //       //     // image: AssetImage(
            //       //     //   'images/home-database-data.png',
            //       //     // ),
            //       //     fit: BoxFit.fill,
            //       //     image: NetworkImage(documentSnapshot['ImageUrl'] != null
            //       //         ? documentSnapshot['ImageUrl']
            //       //         : 'https://firebasestorage.googleapis.com/v0/b/dog-tag-b247e.appspot.com/o/files%2Fimage_picker6390889753745392588.jpg?alt=media&token=3e949f56-6911-4fe5-b857-b0a8469a90d0'),
            //       //   ),
            //     ),
            //       // color: Colors.red,
            //       borderRadius: BorderRadius.circular(15.0),
            //       boxShadow: [
            //         BoxShadow(
            //           color: shadowColor,
            //           blurRadius: 5.0,
            //         ),
            //       ]),
            //   // child: Image(
            //   //   // image: AssetImage(
            //   //   //   'images/home-database-data.png',
            //   //   // ),
            //   //   fit: BoxFit.fill,
            //   //   image: NetworkImage(documentSnapshot['ImageUrl'] != null
            //   //       ? documentSnapshot['ImageUrl']
            //   //       : 'https://firebasestorage.googleapis.com/v0/b/dog-tag-b247e.appspot.com/o/files%2Fimage_picker6390889753745392588.jpg?alt=media&token=3e949f56-6911-4fe5-b857-b0a8469a90d0'),
            //   // ),
            // ),
            SizedBox(height: 10.0),
            Text(
              productController.products[index].DogName ?? 'Zoey, Female',
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              padding: EdgeInsets.only(left: 5.0),
              child: Text(
                productController.products[index].DogDescription ??
                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod',
                // 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       CircleAvatar(
    //         radius: 40,
    //         backgroundImage:
    //             NetworkImage(productController.products[index].ImageUrl),
    //       ),
    //       SizedBox(
    //         width: 20,
    //       ),
    //       Expanded(
    //         child: Text(
    //           '${productController.products[index].DogName}',
    //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    //         ),
    //       ),
    //       Expanded(
    //           child:
    //               Text('${productController.products[index].DogDescription}')),
    //     ],
    //   ),
    // );
  }
}
