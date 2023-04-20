import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wood_mart/consts/consts.dart';
import 'package:wood_mart/consts/controllers/home_controller.dart';
import 'package:wood_mart/views/cart_screen/cart_screen.dart';
import 'package:wood_mart/views/category_screen/category_screen.dart';
import 'package:wood_mart/views/home_screen/home_screen.dart';
import 'package:wood_mart/views/profile_screen/profile_screen.dart';
import 'package:get/get.dart';
import 'package:wood_mart/widgets_common/exit_dialog.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navBarItem = [
      const BottomNavigationBarItem(
        icon: Icon(
          FontAwesomeIcons.house,
          size: 20,
        ),
        label: home,
      ),
      const BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.cubesStacked, size: 20),
          label: categories),
      const BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.cartShopping,
            size: 20,
          ),
          label: cart),
      const BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.user, size: 20), label: account),
    ];

    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen()
    ];

    return WillPopScope(

      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context, builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Obx(
              () => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.black,
            selectedLabelStyle: const TextStyle(
              fontFamily: semibold,
            ),
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: navBarItem,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
