import 'package:get/get.dart';
import 'package:wood_mart/consts/consts.dart';
import 'package:wood_mart/consts/controllers/cart_controller.dart';
import 'package:wood_mart/views/home_screen/home.dart';

import '../../widgets_common/our_button.dart';

enum SingingCharacter { payapal, gPay, applePay, cod }

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  SingingCharacter? radioCharacter = SingingCharacter.payapal;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Obx(
      () => 
        Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: "Payment Method"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        height: 70,
        child: controller.placingOrder.value
              ? const Center(
                  child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                ))
              : 
            ourButton(
                onPress: () async {
                  await controller.placeMyOrder(
                      orderPaymentMethod:
                          radioCharacter == SingingCharacter.payapal
                              ? "Paypal"
                              : radioCharacter == SingingCharacter.gPay
                                  ? "Gpay"
                                  : radioCharacter == SingingCharacter.applePay
                                      ? "Apple Pay"
                                      : "COD",
                      totalAmount: controller.totalP.value);

                  await controller.clearCart();

                  // ignore: use_build_context_synchronously
                  VxToast.show(context, msg: "Order Placed Successfully");
                  Get.offAll(const Home());
                },
                color: Colors.black,
                title: "Place my order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Select the payment method you want to use.".text.make(),
            10.heightBox,
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: ListTile(
                    leading: Image.asset(
                      imgPaypal,
                      height: 30,
                    ),
                    title: "PayPal".text.make(),
                    trailing: Radio<SingingCharacter>(
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => Colors.black),
                      value: SingingCharacter.payapal,
                      groupValue: radioCharacter,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          radioCharacter = value;
                        });
                      },
                    ),
                  ),
                ).box.height(80).make()),
            10.heightBox,
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: ListTile(
                    leading: Image.asset(
                      imgGpay,
                      height: 30,
                    ),
                    title: "Gpay".text.make(),
                    trailing: Radio<SingingCharacter>(
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => Colors.black),
                      value: SingingCharacter.gPay,
                      groupValue: radioCharacter,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          radioCharacter = value;
                        });
                      },
                    ),
                  ),
                ).box.height(80).make()),
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: ListTile(
                    leading: Image.asset(
                      imgApplepay,
                      height: 30,
                    ),
                    title: "Apple Pay".text.make(),
                    trailing: Radio<SingingCharacter>(
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => Colors.black),
                      value: SingingCharacter.applePay,
                      groupValue: radioCharacter,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          radioCharacter = value;
                        });
                      },
                    ),
                  ),
                ).box.height(80).make()),
            10.heightBox,
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: ListTile(
                    leading: Image.asset(
                      imgcod,
                      height: 30,
                    ),
                    title: "Cash on delivery".text.make(),
                    trailing: Radio<SingingCharacter>(
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => Colors.black),
                      value: SingingCharacter.cod,
                      groupValue: radioCharacter,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          radioCharacter = value;
                        });
                      },
                    ),
                  ),
                ).box.height(80).make()),
            10.heightBox,
          ],
        ),
      ),
        ),
    );
  }
}
