import 'package:flutter/material.dart';
import 'package:pbl6/config/value.dart';
import 'package:pbl6/models/product.dart';

import '../pages/detail_product.dart';

// ignore: must_be_immutable
class CardProductTwoColumn extends StatelessWidget {
  CardProductTwoColumn({Key? key, required this.product}) : super(key: key);
  Product product;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => DetailProduct(product: product))));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        height: size.width * 3 / 4,
        width: size.width * 1 / 2 * 0.9,
        //color: Colors.white,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.width * 1 / 2,
              width: size.width * 1 / 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(
                          '${iPURL}api/Product/GetProductImage?productId=${product.id}&imgNumber=1'),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              ' ${product.productName}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 17),
            ),
            Expanded(child: Container()),
            const Text('  ⭐ ⭐ ⭐ ⭐ ⭐', style: TextStyle(fontSize: 17)),
            const SizedBox(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Text(
                    '${product.pricePerOne.toInt()} đ',
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.red),
                  ),
                  Expanded(child: Container()),
                  Text(
                    'Đã bán  ${product.soldQuantity}',
                    style: const TextStyle(fontSize: 13, color: Colors.black45),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
