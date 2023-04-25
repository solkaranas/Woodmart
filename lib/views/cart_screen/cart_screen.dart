import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wood_mart/consts/consts.dart';
import 'package:wood_mart/consts/controllers/cart_controller.dart';
import 'package:wood_mart/consts/controllers/services/firestore_services.dart';
import 'package:wood_mart/views/cart_screen/shipping_screen.dart';

import '../../widgets_common/our_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: "My Cart"
              .text
              .fontWeight(FontWeight.bold)
              .color(Colors.black)
              .size(25)
              .make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black),
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
                      "Cart is Empty".text.size(25).color(darkFontGrey).make(),
                    ],
                  ),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot = data;
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: Image.network(
                                    "${data[index]['img']}",
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  title:
                                      "${data[index]['title']} (x${data[index]['qty']})"
                                          .text
                                          .fontFamily(semibold)
                                          .size(16)
                                          .make(),
                                  subtitle: /* "${data[index]['tprice']}"
                                      .numCurrency
                                      .text
                                      .fontWeight(FontWeight.bold)
                                      .color(Colors.black)
                                      .make() */
                                      Text(
                                          "₹${(data[index]['tprice']).toString().numCurrency}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15.0)),
                                  trailing: IconButton(
                                      onPressed: () {
                                        FirestoreServices.deleteDocument(
                                            data[index].id);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                );
                              })),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          height: context.screenHeight * 0.09,
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Total price"
                                      .text
                                      .size(15)
                                      .fontWeight(FontWeight.w300)
                                      .color(Colors.black)
                                      .make(),
                                  5.heightBox,
                                  Obx(
                                      () => /* "${controller.totalP.value}"
                                        .numCurrency
                                        .text
                                        .size(20)
                                        .fontWeight(FontWeight.bold)
                                        .color(Colors.black)
                                        .make(), */
                                          Text(
                                              "₹${(controller.totalP.value).toString().numCurrency}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 15.0))),
                                ],
                              ).box.size(context.screenWidth * 0.30, 90).make(),
                              const Spacer(),
                              ourButton(
                                      onPress: () {
                                        Get.to(() => const ShippingDetails());
                                      },
                                      title: "Checkout",
                                      color: Colors.black)
                                  .box
                                  .withRounded(value: 50.0)
                                  .size(context.screenWidth * 0.50, 60)
                                  .make()
                            ],
                          ),
                        ),
                      ),
                    ]));
              }
            }));
  }
}


/*Padding(padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(child: Container(color: Colors.white,)),
          const Divider(),

    
          Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                    height: context.screenHeight * 0.09,
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Total price"
                                .text
                                .size(15)
                                .fontWeight(FontWeight.w300)
                                .color(Colors.black)
                                .make(),
                            5.heightBox,
                            "50000"
                                .numCurrency
                                .text
                                .size(20)
                                .fontWeight(FontWeight.bold)
                                .color(Colors.black)
                                .make(),
                          ],
                        ).box.size(context.screenWidth * 0.30, 90).make(),
                        const Spacer(),
                        ourButton(
                                onPress: () {
                                
                                },
                                title: "Checkout",
                                color: Colors.black)
                            .box
                            .withRounded(value: 50.0)
                            .size(context.screenWidth * 0.50, 60)
                            .make()
                      ],
                    ),
                  ),
                ),
         
        ],
      ),
      ),*/