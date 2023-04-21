import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wood_mart/consts/consts.dart';
import 'package:wood_mart/consts/controllers/home_controller.dart';
import 'package:wood_mart/consts/controllers/services/firestore_services.dart';
import 'package:wood_mart/consts/lists.dart';
import 'package:wood_mart/views/category_screen/category_details_page.dart';
import 'package:wood_mart/views/category_screen/item_details_page.dart';
import 'package:wood_mart/views/home_screen/search_screen.dart';
import 'package:wood_mart/views/wishlist_screen/wishlist_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return /*StreamBuilder(
        stream: FirestoreServices.getUser(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                ),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.cartArrowDown,
                    size: 30,
                  ),
                  "No User".text.size(25).color(darkFontGrey).make(),
                ],
              ),
            );
          } else {
            var data = snapshot.data!.docs[0];
            return */ Container(
              padding: const EdgeInsets.all(12),
              color: Colors.white,
              width: context.screenWidth,
              height: context.screenHeight,
              child: SafeArea(
                  child: Column(
                children: [
                  Row(
                    children: [
                 /*   data['imageUrl'] == ""?
                         Image.asset(imgProfile,
                         width: 60,
                         fit: BoxFit.cover,)
                          : Image.network(
                              data['imageUrl'],
                              width: 70,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make(),*/
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Hey!",
                              style: TextStyle(color: fontGrey, fontSize: 15),
                            ),
                            "Shamil Solkar"
                                .text
                                .size(18)
                                .fontWeight(FontWeight.w700)
                                .black
                                .make(),
                          ],
                        ),
                      ),
                      const Spacer(),
                      10.widthBox,
                      IconButton(
                          onPressed: () {
                            Get.to(() => const WishlistScreen());
                          },
                          icon: const Icon(FontAwesomeIcons.heart))
                    ],
                  ),
                  10.heightBox,
                  Container(
                    alignment: Alignment.center,
                    height: context.screenHeight * 0.06,
                    width: context.screenWidth * 0.95,
                    child: TextFormField(
                      
                      controller: controller.searchController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        suffixIconColor: Colors.black,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.0)),
                          suffixIcon: IconButton(
                              onPressed: () {
                                if (controller.searchController.text
                                    .isNotEmptyAndNotNull) {
                                  Get.to(() => SearchScreen(
                                      title: controller.searchController.text));
                                }
                              },
                              icon:
                                  const Icon(FontAwesomeIcons.magnifyingGlass)),
                          filled: true,
                          fillColor: lightGrey,
                          hintText: search,
                          hintStyle: const TextStyle(color: fontGrey)),
                    ),
                  ),
                  2.heightBox,
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: const [
                                  Text(
                                    "Special Offers",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            2.heightBox,
                            VxSwiper.builder(
                                viewportFraction: 0.9,
                                aspectRatio: 16 / 9,
                                autoPlay: true,
                                height: 200,
                                enlargeCenterPage: true,
                                itemCount: slidersLists.length,
                                itemBuilder: (context, index) {
                                  return Image.asset(
                                    slidersLists[index],
                                    fit: BoxFit.fill,
                                  )
                                      .box
                                      .rounded
                                      .clip(Clip.antiAlias)
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 8))
                                      .make();
                                }),
                            10.heightBox,
                            Container(
                                padding: const EdgeInsets.all(12),
                                child: GridView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 8,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            mainAxisSpacing: 8,
                                            crossAxisSpacing: 8,
                                            mainAxisExtent: 95),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: lightGrey,
                                                  border: Border.all(
                                                      color: whiteColor),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(30))),
                                              child: Icon(
                                                categoryIcons[index],
                                                size: 22,
                                              )),
                                          10.heightBox,
                                          categoriesList[index]
                                              .text
                                              .size(18)
                                              .align(TextAlign.center)
                                              .fontWeight(FontWeight.w600)
                                              .color(Colors.black)
                                              .make()
                                        ],
                                      ).box.make().onTap(() {
                                        Get.to(() => CategoryDetails(
                                            title: categoriesList[index]));
                                      });
                                    })),
                       
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: const [
                                  Text(
                                    "Featured Products",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            FutureBuilder(
                                future: FirestoreServices.getFeaturedProduct(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.black),
                                    );
                                  } else if (snapshot.data!.docs.isEmpty) {
                                    return "No Featured Products"
                                        .text
                                        .size(25)
                                        .color(darkFontGrey)
                                        .makeCentered();
                                  } else {
                                    var featuredProductdata =
                                        snapshot.data!.docs;
                                    return GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: featuredProductdata.length,
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.network(
                                                  featuredProductdata[index]
                                                      ['p_imgs'][0],
                                                  height: 150,
                                                  width: 200,
                                                  fit: BoxFit.fill,
                                                ),
                                                10.heightBox,
                                                Text(
                                                  featuredProductdata[index]
                                                      ['p_name'],
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                10.heightBox,
                                                "${featuredProductdata[index]['p_price']}"
                                                    .numCurrency
                                                    .text
                                                    .fontWeight(FontWeight.bold)
                                                    .color(Colors.black)
                                                    .size(15)
                                                    .make()
                                              ],
                                            ).box.make().onTap(() {
                                              Get.to(() => ItemDetails(
                                                    title:
                                                        "${featuredProductdata[index]['p_name']}",
                                                    data: featuredProductdata[
                                                        index],
                                                  ));
                                            }),
                                          );
                                        });
                                  }
                                })
                          ]),
                    ),
                  )
                ],
              )),
            );
          
  }
}
