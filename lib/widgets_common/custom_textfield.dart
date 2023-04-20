import 'package:wood_mart/consts/consts.dart';

Widget customTextfield({String? title, String? hint, controller,isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(Colors.black).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
          hintStyle:
              const TextStyle(fontFamily: semibold, color: textfieldGrey),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
        ),
      ),
    ],
  );
}
