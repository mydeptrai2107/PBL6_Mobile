import 'package:flutter/material.dart';
import 'package:pbl6/config/value.dart';
import 'package:pbl6/models/cart.dart';

class InformationProductPay extends StatelessWidget {
  const InformationProductPay({Key? key, required this.cart}) : super(key: key);
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: size.width,
      height: 160,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(
                          '${iPURL}api/Product/GetProductImage?productId=${cart.productId}&imgNumber=1',
                        ),
                        fit: BoxFit.cover)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: size.width - 150,
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      cart.productName,
                      maxLines: 3,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 20,
                    child: Text(
                      cart.description,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 20,
                    width: size.width - 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${cart.pricePerOne.toInt()} đ',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Số lượng: ${cart.productCount}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(child: Container()),
              Text(
                '${cart.productCount} Items, Subtotal:  ',
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              Text(
                "${(cart.pricePerOne * cart.productCount).toInt()} đ",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                width: 20,
              )
            ],
          ),
        ],
      ),
    );
  }
}
