import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wood_mart/consts/consts.dart';
import 'package:wood_mart/consts/lists.dart';
import 'package:wood_mart/widgets_common/category_detail_widget.dart';

class SofaPage extends StatelessWidget {
  const SofaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor :Colors.white,
      appBar:AppBar(
        actionsIconTheme: const IconThemeData(size: 25, color: Colors.black),
        actions:  [
          const Icon(FontAwesomeIcons.magnifyingGlass),
         25.widthBox,
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        iconTheme: const IconThemeData(size: 25, color: Colors.black),
        title: "Sofa"
            .text
            .fontWeight(FontWeight.bold)
            .color(Colors.black)
            .size(25)
            .make(),
      ),
      body: categoryDetail(
        imglist: imgSofaList,
        title: sofaList,
      ),
    );
  }
}
