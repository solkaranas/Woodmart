import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wood_mart/consts/consts.dart';
import 'package:wood_mart/views/category_screen/item_details_page.dart';
import 'package:get/get.dart';

Widget categoryDetail({imglist, title}) {
  return GridView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 8,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
              Stack(children: [
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  alignment: Alignment.center,
                  child: Image.asset(
                    imglist[index],
                    width: 200,
                    fit: BoxFit.fill,
                  ),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(FontAwesomeIcons.heart),
                  ),
                )
              ]),
              5.heightBox,
              Text(
                title[index],
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              5.heightBox,
              "2000 Rs"
                  .text
                  .fontWeight(FontWeight.bold)
                  .color(Colors.black)
                  .size(15)
                  .make()
            ],
          ),
        );
      }).onTap(() {
    Get.to(const ItemDetails());
  });
}
