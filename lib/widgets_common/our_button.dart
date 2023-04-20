import 'package:wood_mart/consts/consts.dart';

Widget ourButton({onPress,String? title, color}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          // ignore: deprecated_member_use
          primary: color,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)))),
      onPressed: onPress,
      child: title!.text.white.fontFamily(bold).make());
}
