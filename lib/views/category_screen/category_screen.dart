import 'package:get/get.dart';
import 'package:wood_mart/consts/consts.dart';
import 'package:wood_mart/consts/lists.dart';
import 'package:wood_mart/views/category_screen/category_details_page.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        iconTheme: const IconThemeData(size: 25, color: Colors.black),
        title: "Categories"
            .text
            .fontWeight(FontWeight.bold)
            .color(Colors.black)
            .size(25)
            .make(),
      ),
      body: Container(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 8,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 200),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(
                      categoryImages[index],
                      height: 130,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    10.heightBox,
                    categoriesList[index]
                        .text
                        .size(18)
                        .align(TextAlign.center)
                        .fontWeight(FontWeight.w600)
                        .color(Colors.black)
                        .make()
                  ],
                )
                    .box
                    .white
                    .rounded
                    .clip(Clip.antiAlias)
                    .outerShadowSm
                    .make()
                    .onTap(() {
                  Get.to(() => CategoryDetails(title: categoriesList[index]));
                });
              })),
    );
  }
}

/*Column(
            children: [
              categoryWidget(
                  category: "Sofa",
                  ontap: () {
                    Get.to(const SofaPage());
                  },
                  imgList: imgSofaList,
                  title: sofaList),
              10.heightBox,
              categoryWidget(
                  category: "Chair",
                  ontap: () {},
                  imgList: imgChairList,
                  title: chairList),
              10.heightBox,
              categoryWidget(
                  category: "Table",
                  ontap: () {},
                  imgList: imgTableList,
                  title: tableList),
              10.heightBox,
              categoryWidget(
                  category: "Kitchen",
                  ontap: () {},
                  imgList: imgKitchenList,
                  title: kitchenList),
              10.heightBox,
              categoryWidget(
                  category: "Lamp",
                  ontap: () {},
                  imgList: imgLampList,
                  title: lampList),
              10.heightBox,
              categoryWidget(
                  category: "Cupboard",
                  ontap: () {},
                  imgList: imgCupboardList,
                  title: cupboardList),
              10.heightBox,
              categoryWidget(
                category: "Vase",
                ontap: () {},
                imgList: imgVaseList,
                title: vaseList,
              ),
            ],
          ), */
          