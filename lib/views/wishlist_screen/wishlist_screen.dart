import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wood_mart/consts/consts.dart';
import 'package:wood_mart/consts/controllers/services/firestore_services.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

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
        title: "Wishlist"
            .text
            .fontWeight(FontWeight.bold)
            .color(Colors.black)
            .size(25)
            .make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getWishlists(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "You Haven't added anything in wishlist :(".text.size(20).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network(
                              "${data[index]['p_imgs'][0]}",
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            title: "${data[index]['p_name']}"
                                .text
                                .fontFamily(semibold)
                                .size(16)
                                .make(),
                            subtitle: "${data[index]['p_price']}"
                                .numCurrency
                                .text
                                .fontWeight(FontWeight.bold)
                                .color(Colors.black)
                                .make(),
                            trailing: IconButton(
                                onPressed: () {
                                  firestore
                                      .collection(productsCollection)
                                      .doc(data[index].id).set({
                                        'p_wishlist' : FieldValue.arrayRemove([currentUser!.uid])
                                      },SetOptions(merge: true));
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )),
                          );
                        }),
                  ),
                ],
              );
            }
          }),
    );
  }
}
