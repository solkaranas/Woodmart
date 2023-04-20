import 'package:get/get.dart';
import 'package:wood_mart/consts/consts.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;

  var userName = '';

  var searchController = TextEditingController();

  getUserName() async {
    var n = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });

    userName = n;
  }
}
