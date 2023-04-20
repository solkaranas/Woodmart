import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:wood_mart/consts/consts.dart';
import 'package:wood_mart/consts/controllers/services/firestore_services.dart';
import 'package:wood_mart/views/order_screen/oreder_details.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

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
        title: "My Orders"
            .text
            .fontWeight(FontWeight.bold)
            .color(Colors.black)
            .size(25)
            .make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getAllOrders(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Orders Yet".text.makeCentered();
            } else {
              var data = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: "${index + 1}"
                          .text
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .xl
                          .make(),
                      title: data[index]['order_code']
                          .toString()
                          .text
                          .color(redColor)
                          .fontFamily(semibold)
                          .make(),
                      subtitle: data[index]['total_amount']
                          .toString()
                          .numCurrency
                          .text
                          .fontFamily(semibold)
                          .make(),
                      trailing: IconButton(
                          onPressed: () {
                            Get.to(()=> OrderDetails(data: data[index],));
                          },
                          icon: const Icon(Icons.arrow_forward_rounded)),
                    );
                  });
            }
          }),
    );
  }
}
