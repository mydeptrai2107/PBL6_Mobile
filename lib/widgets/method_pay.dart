import 'package:flutter/material.dart';

class MethodPay extends StatelessWidget {
  const MethodPay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 300,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Chọn phương thức thanh toán',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                'Xem tất cả >',
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),

          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: size.width * 1/2,
                  height: 100,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: const [
                      Text(
                        'Thanh toán khi nhận hàng',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }


}