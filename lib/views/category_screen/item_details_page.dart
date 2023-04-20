import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wood_mart/consts/consts.dart';
import 'package:wood_mart/consts/controllers/product_controller.dart';
import 'package:wood_mart/widgets_common/our_button.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({Key? key, this.title, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.resetValues();
                Get.back();
              },
              icon: const Icon(FontAwesomeIcons.arrowLeft)),
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      VxSwiper.builder(
                          viewportFraction: 1.0,
                          aspectRatio: 16 / 9,
                          height: 350,
                          itemCount: data['p_imgs'].length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              data['p_imgs'][index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          }),
                      10.heightBox,
                      Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                title!.text
                                    .size(40)
                                    .color(Colors.black)
                                    .fontWeight(FontWeight.bold)
                                    .make(),
                                const Spacer(),
                                Obx(
                                  () => IconButton(
                                      onPressed: () {
                                        if (controller.isFav.value) {
                                          controller.removeFromWishlist(
                                              data.id, context);
                                        } else {
                                          controller.addToWishlist(
                                              data.id, context);
                                        }
                                      },
                                      icon: Icon(
                                        Icons.favorite,
                                        size: 35,
                                        color: controller.isFav.value
                                            ? redColor
                                            : darkFontGrey,
                                      )),
                                )
                              ],
                            ),
                            VxRating(
                              isSelectable: false,
                              value: double.parse(data['p_rating']),
                              onRatingUpdate: (value) {},
                              normalColor: textfieldGrey,
                              selectionColor: golden,
                              count: 5,
                              maxRating: 5,
                              size: 25,
                            ),
                            10.heightBox,
                            "${data['p_price']}".numCurrency
                                .text
                                .size(20)
                                .fontWeight(FontWeight.bold)
                                .color(Colors.black)
                                .make(),
                            20.heightBox,
                            description.text
                                .size(20)
                                .fontWeight(FontWeight.bold)
                                .color(Colors.black)
                                .make(),
                            5.heightBox,
                            "${data['p_desc']}"
                                .text
                                .size(15)
                                .fontWeight(FontWeight.w300)
                                .color(Colors.black)
                                .make(),
                            15.heightBox,
                            "Color"
                                .text
                                .size(20)
                                .fontWeight(FontWeight.bold)
                                .color(Colors.black)
                                .make(),
                            10.heightBox,
                            Row(
                              children: List.generate(
                                  data['p_colors'].length,
                                  (index) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          VxBox()
                                              .size(40, 40)
                                              .roundedFull
                                              .color(
                                                  Color(data['p_colors'][index])
                                                      .withOpacity(1.0))
                                              .margin(
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4))
                                              .make()
                                              .onTap(() {
                                            controller.changeColorIndex(index);
                                          }),
                                          Visibility(
                                            visible: index ==
                                                controller.colorIndex.value,
                                            child: const Icon(
                                              Icons.done,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      )),
                            ),
                            15.heightBox,
                            Row(
                              children: [
                                "Quantity"
                                    .text
                                    .size(20)
                                    .fontWeight(FontWeight.bold)
                                    .color(Colors.black)
                                    .make(),
                                10.widthBox,
                                Obx(
                                  () => Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.decreaseQuantity();
                                            controller.calculateTotalPrice(
                                                int.parse(data['p_price']));
                                          },
                                          icon: const Icon(
                                              FontAwesomeIcons.minus)),
                                      const Spacer(),
                                      controller.quantity.value.text
                                          .size(20)
                                          .fontWeight(FontWeight.bold)
                                          .color(Colors.black)
                                          .make(),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            controller.increaseQuantity(
                                                int.parse(data['p_quantity']));
                                            controller.calculateTotalPrice(
                                                int.parse(data['p_price']));
                                          },
                                          icon: const Icon(
                                              FontAwesomeIcons.plus)),
                                    ],
                                  )
                                      .box
                                      .withRounded(value: 25)
                                      .color(Colors.grey.shade200)
                                      .size(140, 50)
                                      .make(),
                                ),
                              ],
                            ),
                            5.heightBox,
                            "${data['p_quantity']} available"
                                .text
                                .size(15)
                                .fontWeight(FontWeight.w300)
                                .color(Colors.black)
                                .make(),
                            15.heightBox,
                            seller.text
                                .size(20)
                                .fontWeight(FontWeight.bold)
                                .color(Colors.black)
                                .make(),
                            5.heightBox,
                            "${data['p_seller']}"
                                .text
                                .size(15)
                                .fontWeight(FontWeight.w300)
                                .color(Colors.black)
                                .make(),
                            15.heightBox,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(
                () => SizedBox(
                  height: 100,
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
                          "${controller.totalPrice.value}"
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
                                if (controller.quantity.value > 0) {
                                  controller.addToCart(
                                    color: data['p_colors']
                                        [controller.colorIndex.value],
                                    context: context,
                                    vendorID: data['vendor_id'],
                                    img: data['p_imgs'][0],
                                    qty: controller.quantity.value,
                                    sellername: data['p_seller'],
                                    title: data['p_name'],
                                    tprice: controller.totalPrice.value,
                                  );
                                  VxToast.show(context, msg: "Added to Cart");
                                } else {
                                  VxToast.show(context,
                                      msg: "Quantity cannot be 0");
                                }
                              },
                              title: "Add to cart",
                              color: Colors.black)
                          .box
                          .withRounded(value: 50.0)
                          .size(context.screenWidth * 0.60, 60)
                          .make()
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
