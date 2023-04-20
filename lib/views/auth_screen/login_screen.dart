import 'package:wood_mart/consts/consts.dart';
import 'package:wood_mart/consts/controllers/auth_controller.dart';
import 'package:wood_mart/consts/lists.dart';
import 'package:wood_mart/views/auth_screen/signup_screen.dart';
import 'package:wood_mart/views/home_screen/home.dart';
import 'package:wood_mart/widgets_common/applogo_widget.dart';
import 'package:wood_mart/widgets_common/custom_textfield.dart';
import 'package:wood_mart/widgets_common/our_button.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.2).heightBox,
              applogoWidget(),
              10.heightBox,
              "Sign in to $appname".text.fontFamily(bold).black.size(22).make(),
              10.heightBox,
              Obx(
                () => Column(
                  children: [
                    customTextfield(
                        hint: emailHint,
                        title: email,
                        isPass: false,
                        controller: controller.emailController),
                    5.heightBox,
                    customTextfield(
                        hint: passwordHint,
                        title: password,
                        isPass: true,
                        controller: controller.passwordController),
                    10.heightBox,
                    controller.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.black),
                          )
                        : ourButton(
                            color: Colors.black,
                            title: signIn,
                            onPress: () async {
                              controller.isLoading(true);
                              await controller
                                  .signinMethod(context: context)
                                  .then((value) {
                                if (value != null) {
                                  VxToast.show(context, msg: signedin);
                                  controller.isLoading(false);
                                  Get.offAll(() => const Home());
                                } else {
                                  controller.isLoading(false);
                                }
                              });
                            },
                          ).box.width(context.screenWidth - 50).make(),
                    5.heightBox,
                    TextButton(
                        onPressed: () {},
                        child: forgetPassword.text
                            .color(Colors.black)
                            .fontFamily(bold)
                            .make()),
                    5.heightBox,
                    orContinue.text.color(fontGrey).make(),
                    5.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          3,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: lightGrey,
                                  radius: 25,
                                  child: Icon(
                                    socialList[index],
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              )),
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        dontHaveAnAccount.text.color(fontGrey).make(),
                        TextButton(
                            onPressed: () {
                              Get.to(const SignupScreen());
                            },
                            child: signUp.text
                                .color(Colors.black)
                                .fontFamily(bold)
                                .make()),
                      ],
                    ),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
