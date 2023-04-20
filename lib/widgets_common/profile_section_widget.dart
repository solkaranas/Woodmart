import 'package:wood_mart/consts/consts.dart';

Widget profileWidget({String? title, icon,onPress}) {
  return ListTile(
    trailing: const Icon(
      Icons.arrow_right,
      color: Colors.black87,
    ),
    leading: icon,
    title: title!.text
        .color(Colors.black)
        .fontWeight(FontWeight.w500)
        .fontFamily(semibold)
        .make(),
        onTap: onPress,
  );
}
