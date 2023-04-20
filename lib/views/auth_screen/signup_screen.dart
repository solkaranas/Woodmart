import 'package:wood_mart/consts/consts.dart';
import 'package:wood_mart/consts/controllers/auth_controller.dart';
import 'package:wood_mart/views/auth_screen/login_screen.dart';
import 'package:wood_mart/views/home_screen/home.dart';

import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/our_button.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controller

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Obx(
            () => Column(
              children: [
                (context.screenHeight * 0.2).heightBox,
                applogoWidget(),
                10.heightBox,
                "Sign up to $appname"
                    .text
                    .fontFamily(bold)
                    .black
                    .size(22)
                    .make(),
                10.heightBox,
                Column(children: [
                  customTextfield(
                      hint: nameHint,
                      title: name,
                      controller: nameController,
                      isPass: false),
                  5.heightBox,
                  customTextfield(
                      hint: emailHint,
                      title: email,
                      controller: emailController,
                      isPass: false),
                  5.heightBox,
                  customTextfield(
                      hint: passwordHint,
                      title: password,
                      controller: passwordController,
                      isPass: true),
                  5.heightBox,
                  customTextfield(
                      hint: passwordHint,
                      title: reTypePass,
                      controller: passwordRetypeController,
                      isPass: true),
                  5.heightBox,
                  Row(
                    children: [
                      Checkbox(
                          activeColor: Colors.white,
                          checkColor: Colors.black,
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue;
                            });
                          }),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: "I agree to the ",
                              style: TextStyle(
                                  fontFamily: regular, color: fontGrey)),
                          TextSpan(
                              text: termsAndCond,
                              style: TextStyle(
                                  fontFamily: regular, color: Colors.black)),
                          TextSpan(
                              text: " & ",
                              style: TextStyle(
                                  fontFamily: regular, color: fontGrey)),
                          TextSpan(
                              text: privacyPolicy,
                              style: TextStyle(
                                  fontFamily: regular, color: Colors.black)),
                        ])),
                      ),
                    ],
                  ),
                  10.heightBox,
                  controller.isLoading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.black),
                        )
                      : ourButton(
                          color: isCheck == true ? Colors.black : lightGrey,
                          title: signUp,
                          onPress: () async {
                            if (isCheck != false) {
                              controller.isLoading(true);
                              try {
                                await controller
                                    .signupMethod(
                                        context: context,
                                        email: emailController.text,
                                        password: passwordController.text)
                                    .then((value) {
                                  return controller.storeUserData(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text);
                                }).then((value) {
                                  VxToast.show(context, msg: signedin);
                                  Get.offAll(() => const Home());
                                });
                              } catch (e) {
                                auth.signOut();
                                VxToast.show(context, msg: e.toString());
                                controller.isLoading(false);
                              }
                            }
                          }).box.width(context.screenWidth - 50).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      alreadyHave.text.color(fontGrey).make(),
                      TextButton(
                          onPressed: () {
                            Get.to(const LoginScreen());
                          },
                          child: signIn.text
                              .color(Colors.black)
                              .fontFamily(bold)
                              .make()),
                    ],
                  ),
                ])
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .make(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
