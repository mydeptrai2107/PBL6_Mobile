import 'package:flutter/material.dart';

class FormShip extends StatelessWidget {
  const FormShip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Hình thức giao hàng',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                'Xem tất cả >',
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 80,
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'GH tiêu chuẩn',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '48 000 đ',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Text(
                  'Nhận vào: ' + DateTime.now().toString(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
