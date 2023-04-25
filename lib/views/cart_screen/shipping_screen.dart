import 'package:get/get.dart';
import 'package:wood_mart/consts/consts.dart';
import 'package:wood_mart/consts/controllers/cart_controller.dart';
import 'package:wood_mart/views/cart_screen/payment_method.dart';
import 'package:wood_mart/widgets_common/custom_textfield.dart';
import 'package:wood_mart/widgets_common/our_button.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        height: 70,
        child: ourButton(
            onPress: () {
              if (controller.addressController.text.length > 10) {
                Get.to(() => const PaymentMethod());
              } else {
                VxToast.show(context, msg: "Please fill the Form");
              }
            },
            color: Colors.black,
            title: "Continue"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextfield(
                hint: "Address",
                title: "Address",
                isPass: false,
                controller: controller.addressController),
            customTextfield(
                hint: "City",
                title: "City",
                isPass: false,
                controller: controller.cityController),
            customTextfield(
                hint: "State",
                title: "State",
                isPass: false,
                controller: controller.stateController),
            pinCodefield(
                hint: "Postal Code",
                title: "Postal Code",
                controller: controller.postalcodeController),
            mobNumberfield(
                hint: "2991992194",
                title: "Phone",
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
