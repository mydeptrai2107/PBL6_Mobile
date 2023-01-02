import 'package:flutter/material.dart';
import 'package:pbl6/config/value.dart';
import 'package:pbl6/models/category.dart';
import 'package:pbl6/services/repository_product.dart';
import 'package:pbl6/widgets/cart_product_two_column.dart';
import 'package:pbl6/widgets/sale.dart';
import '../icons/my_icon_icons.dart';
import '../models/product.dart';
import 'nav_bar_page.dart';

class ProductByCategory extends StatefulWidget {
  const ProductByCategory({super.key, required this.categoryModel});
  final CategoryModel categoryModel;

  @override
  State<ProductByCategory> createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory> {
  late String valueChoose;

  List listItem = [
    'Tên A → Z',
    'Tên Z → A',
    'Giá tăng dần',
    'Giá giảm dần',
    'Hàng mới'
  ];

  RepositoryProduct repositoryProduct = RepositoryProduct();
  List<Product> list = [];

  void getProduct() async {
    list = await repositoryProduct
        .getProductByCategory(widget.categoryModel.id.toString());
    setState(() {});
  }

  @override
  void initState() {
    getProduct();
    super.initState();
    valueChoose = listItem[0];
  }

  @override
  Widget build(BuildContext context) {
    CategoryModel categoryModel = widget.categoryModel;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const NavBarPage(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(shop),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(MyIcon.search)),
          IconButton(onPressed: () {}, icon: const Icon(MyIcon.shopping_bag)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: [
          const Sale(),

          const SizedBox(
            height: 20,
          ),

          Text(
            categoryModel.categoryName,
            style: const TextStyle(fontSize: 35),
          ),

          const SizedBox(
            height: 20,
          ),

          //sort product
          Row(
            children: [
              const Text(
                'Sắp xếp: ',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                child: DropdownButton(
                  hint: Text(valueChoose),
                  onChanged: (value) {
                    setState(() {
                      valueChoose = value.toString();
                    });
                  },
                  items: listItem
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                ),
              )
            ],
          ),

          const SizedBox(
            height: 20,
          ),

          Container(
              color: Colors.grey[200],
              height: list.length / 2 * (size.width * 5 / 6),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: size.width * 1 / 2,
                    childAspectRatio: 1 / 1.7,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1),
                itemBuilder: (context, index) {
                  return CardProductTwoColumn(product: list[index]);
                },
              )),
        ],
      ),
    );
  }
}
