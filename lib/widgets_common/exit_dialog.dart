import 'package:flutter/services.dart';
import 'package:wood_mart/consts/consts.dart';
import 'package:wood_mart/widgets_common/our_button.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confrim".text.size(18).fontFamily(bold).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exit?"
            .text
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                color: Colors.black,
                title: "Yes",
                onPress: () {
                  SystemNavigator.pop();
                }),
            ourButton(
                color: Colors.black,
                title: "No",
                onPress: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}
