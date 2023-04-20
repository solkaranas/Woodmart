import 'package:firebase_auth/firebase_auth.dart';
import 'package:wood_mart/consts/consts.dart';
import 'package:wood_mart/views/auth_screen/login_screen.dart';
import 'package:wood_mart/views/home_screen/home.dart';
import 'package:wood_mart/widgets_common/applogo_widget.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      //   Get.to(const LoginScreen());
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => const LoginScreen());
        } else {
          Get.to(() => const Home());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Image.asset(icSplashBg, width: 300)),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(20).black.make(),
            5.heightBox,
            appversion.text.black.make(),
            const Spacer(),
            credits.text.black.fontFamily(semibold).make(),
          ],
        ),
      ),
    );
  }
}
