import 'package:wood_mart/consts/consts.dart';

Widget homeButtons({icon, title}) {
  return Column(
    children: [
      Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: lightGrey,
            border: Border.all(
              color: whiteColor
            ),
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child:  Icon(icon,size: 22,),  
      ),
      5.heightBox,
      Text(title,style: const TextStyle(fontFamily: bold,fontSize: 15, color: Colors.black),)
    ],
  );
}
