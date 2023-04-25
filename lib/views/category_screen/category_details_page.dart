import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:wood_mart/consts/consts.dart';
import 'package:wood_mart/consts/controllers/product_controller.dart';
import 'package:wood_mart/consts/controllers/services/firestore_services.dart';
import 'package:wood_mart/views/category_screen/item_details_page.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;

  const CategoryDetails({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: false,
          iconTheme: const IconThemeData(size: 25, color: Colors.black),
          title: title!.text
              .fontWeight(FontWeight.bold)
              .color(Colors.black)
              .size(25)
              .make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getProducts(title),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                ));
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "No Products found!".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;

                return Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Expanded(
                          child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 250,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      data[index]['p_imgs'][0],
                                      height: 150,
                                      width: 200,
                                      fit: BoxFit.fill,
                                    ),
                                    10.heightBox,
                                    "${data[index]['p_name']}"
                                        .text
                                        .fontWeight(FontWeight.bold)
                                        .color(Colors.black)
                                        .size(18)
                                        .make(),
                                    10.heightBox,
                                    /* "${data[index]['p_price']}"
                                        .numCurrency
                                        .text
                                        .fontWeight(FontWeight.bold)
                                        .color(Colors.black)
                                        .size(15)
                                        .make() */
                                    Text(
                                        "₹${(data[index]['p_price']).toString().numCurrency}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15.0))
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .roundedSM
                                    .outerShadowSm
                                    .padding(const EdgeInsets.all(12))
                                    .make()
                                    .onTap(() {
                                  controller.checkIfFav(data[index]);
                                  Get.to(() => ItemDetails(
                                        title: data[index]['p_name'],
                                        data: data[index],
                                      ));
                                });
                              }))
                    ],
                  ),
                );
              }
            }));
  }
}
