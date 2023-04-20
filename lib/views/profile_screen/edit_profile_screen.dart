import 'dart:io';

import 'package:get/get.dart';
import 'package:wood_mart/consts/consts.dart';
import 'package:wood_mart/consts/controllers/profile_controller.dart';
import 'package:wood_mart/widgets_common/custom_textfield.dart';
import 'package:wood_mart/widgets_common/our_button.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgProfile,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                      ? Image.network(
                          data['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ourButton(
                  color: Colors.black,
                  onPress: () {
                    controller.changeImage(context);
                  },
                  title: "Change"),
              const Divider(),
              20.heightBox,
              customTextfield(
                  hint: nameHint,
                  title: name,
                  isPass: false,
                  controller: controller.nameController),
              10.heightBox,
              customTextfield(
                  hint: passwordHint,
                  title: oldpass,
                  isPass: true,
                  controller: controller.oldpasssController),
              10.heightBox,
              customTextfield(
                  hint: passwordHint,
                  title: newpass,
                  isPass: true,
                  controller: controller.newpasssController),
              20.heightBox,
              controller.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.black),
                    )
                  : SizedBox(
                      width: context.screenWidth - 60,
                      child: ourButton(
                          color: Colors.black,
                          onPress: () async {
                            controller.isLoading(true);

                            //if image is not selected
                            if (controller.profileImgPath.isNotEmpty) {
                              await controller.uploadProfileImage();
                            } else {
                              controller.profileImageLink = data['imageUrl'];
                            }

                            if (data['password'] ==
                                controller.oldpasssController.text) {
                              await controller.changeAuthPassword(
                                  email: data['email'],
                                  password: controller.oldpasssController.text,
                                  newpassword:
                                      controller.newpasssController.text);

                              await controller.updateProfile(
                                imgUrl: controller.profileImageLink,
                                name: controller.nameController.text,
                                password: controller.newpasssController.text,
                              );
                              // ignore: use_build_context_synchronously
                              VxToast.show(context, msg: "Updated");
                            } else {
                              // ignore: use_build_context_synchronously
                              VxToast.show(context, msg: "Wrong Old Password");
                              controller.isLoading(false);
                            }
                          },
                          title: "Save")),
            ],
          )
              .box
              .shadowSm
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50))
              .white
              .make(),
        ),
      ),
    );
  }
}
