import 'package:wood_mart/consts/consts.dart';

Widget categoryWidget({imgList, title, String? category, ontap}) {
  return Column(
    children: [
        Row(
                children :[
              category!.text.fontWeight(FontWeight.bold).size(28).color(Colors.black).make(),
              const Spacer(),
               TextButton(
                            onPressed: ontap,
                            child: const Text(
                              "See All",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            )),
              ]),
      GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 200,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Image.asset(
                  imgList[index],
                  height: 150,
                  width: 200,
                  fit: BoxFit.fill,
                ),
                Text(
                  (title[index]),
                  style: const TextStyle(
                      fontSize: 15, color: Colors.black, fontFamily: regular),
                )
              ],
            );
          }),
    ],
  );
}
