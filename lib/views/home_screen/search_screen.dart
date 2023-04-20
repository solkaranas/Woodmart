import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:wood_mart/consts/consts.dart';

import '../../consts/controllers/services/firestore_services.dart';
import '../category_screen/item_details_page.dart';

class SearchScreen extends StatelessWidget {
  final String title;
  const SearchScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: false,
          iconTheme: const IconThemeData(size: 25, color: Colors.black),
          title: title.text
              .fontWeight(FontWeight.bold)
              .color(Colors.black)
              .size(25)
              .make(),
        ),
        body: FutureBuilder(
            future: FirestoreServices.searchProducts(title),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return "No Products Found"
                    .text
                    .size(25)
                    .color(darkFontGrey)
                    .makeCentered();
              } else {
                var searchData = snapshot.data!.docs;
                var filtered = searchData
                    .where((element) => element['p_name']
                        .toString()
                        .toLowerCase()
                        .contains(title.toLowerCase()))
                    .toList();
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filtered.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              mainAxisExtent: 270),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                filtered[index]['p_imgs'][0],
                                height: 150,
                                width: 200,
                                fit: BoxFit.fill,
                              ),
                              10.heightBox,
                              Text(
                                filtered[index]['p_name'],
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              10.heightBox,
                              "${filtered[index]['p_price']}"
                                  .numCurrency
                                  .text
                                  .fontWeight(FontWeight.bold)
                                  .color(Colors.black)
                                  .size(15)
                                  .make()
                            ],
                          ).box.make().onTap(() {
                            Get.to(() => ItemDetails(
                                  title: "${filtered[index]['p_name']}",
                                  data: filtered[index],
                                ));
                          }),
                        );
                      }),
                );
              }
            }));
  }
}
