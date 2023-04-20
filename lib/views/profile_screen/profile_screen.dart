import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wood_mart/consts/consts.dart';
import 'package:wood_mart/consts/controllers/auth_controller.dart';
import 'package:wood_mart/consts/controllers/profile_controller.dart';
import 'package:wood_mart/consts/controllers/services/firestore_services.dart';
import 'package:wood_mart/views/auth_screen/login_screen.dart';
import 'package:wood_mart/views/order_screen/order_screen.dart';
import 'package:wood_mart/views/privacy_policy/privacy_policy.dart';
import 'package:wood_mart/views/profile_screen/edit_profile_screen.dart';
import 'package:wood_mart/views/wishlist_screen/wishlist_screen.dart';
import 'package:wood_mart/widgets_common/profile_section_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: FirestoreServices.getUser(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                  ),
                );
              } else {
                var data = snapshot.data!.docs[0];

                return SafeArea(
                    child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(icApplogo)
                              .box
                              .white
                              .size(40, 40)
                              .padding(const EdgeInsets.all(8))
                              .rounded
                              .make(),
                          "Profile"
                              .text
                              .fontFamily(bold)
                              .size(25)
                              .fontWeight(FontWeight.bold)
                              .make(),
                        ],
                      ),
                      10.heightBox,
                      data['imageUrl'] == ''
                          ? Image.asset(
                              imgProfile,
                              width: 100,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make()
                          : Image.network(
                              data['imageUrl'],
                              width: 100,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make(),
                      10.heightBox,
                      "${data['name']}"
                          .text
                          .size(25)
                          .fontWeight(FontWeight.w700)
                          .black
                          .make(),
                      5.heightBox,
                      "${data['email']}"
                          .text
                          .color(Colors.black)
                          .fontWeight(FontWeight.w500)
                          .fontFamily(semibold)
                          .make(),
                      const Divider(thickness: 1),
                      profileWidget(
                          title: "Edit Profile",
                          icon: const Icon(FontAwesomeIcons.user),
                          onPress: () {
                            controller.nameController.text = data['name'];

                            Get.to(() => EditProfileScreen(
                                  data: data,
                                ));
                          }),
                      profileWidget(
                          title: "My Orders",
                          icon: const Icon(Icons.file_copy_sharp),
                          onPress: () {
                            Get.to(() => const OrderScreen());
                          }),
                      profileWidget(
                          title: "Wishlist",
                          icon: const Icon(FontAwesomeIcons.heart),
                          onPress: () {
                            Get.to(() => const WishlistScreen());
                          }),
                      profileWidget(
                          title: "Privacy Policy",
                          icon: const Icon(FontAwesomeIcons.lock),
                          onPress: () {
                            Get.to(const PrivacyPolicyScreen());
                          }),
                      profileWidget(
                          title: "Invite Friends",
                          icon: const Icon(FontAwesomeIcons.users)),
                      ListTile(
                        leading: const Icon(
                          FontAwesomeIcons.rightFromBracket,
                          color: Colors.red,
                        ),
                        title: "Logout"
                            .text
                            .color(Colors.red)
                            .fontWeight(FontWeight.w500)
                            .fontFamily(semibold)
                            .make(),
                        onTap: () async {
                          await Get.put(
                              AuthController().signoutMethod(context));
                          Get.offAll(() => const LoginScreen());
                        },
                      ),
                    ],
                  ),
                ));
              }
            }));
  }
}
