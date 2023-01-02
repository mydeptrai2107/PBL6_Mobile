import 'package:flutter/material.dart';
import 'package:pbl6/models/product.dart';
import 'package:pbl6/widgets/card_product_widget.dart';

// ignore: must_be_immutable
class MyProduct extends StatefulWidget {
  MyProduct({Key? key, required this.list}) : super(key: key);
  List<Product> list;

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        const Text(
          'Bộ sưu tập',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 460,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.list.length,
              itemBuilder: (context, index) {
                Product value = widget.list[index];
                return CardProduct(
                  product: value,
                );
              }),
        ),
      ],
    );
  }
}
