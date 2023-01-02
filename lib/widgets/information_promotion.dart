import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InformationPromotion extends StatelessWidget {
  InformationPromotion({Key? key, required this.size}) : super(key: key);

  Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: DottedBorder(
          color: Colors.red,
          strokeWidth: 3,
          dashPattern: const [8, 4],
          child: Container(
            padding: const EdgeInsets.all(30),
            width: size.width,
            //height: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '✔   Nhập mã EGANY thêm 5% đơn hàng',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '✔   Đồng giá Ship toàn quốc 25.000',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '✔   Hỗ trợ 10.000 phí Ship cho đơn hàng từ 200.00đ',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '✔   Miễn phí Ship cho đơn hàng từ 300.000đ',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '✔   Đổi trả trong 30 ngày nếu sản phẩm lổi bất kỳ',
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          )),
    );
  }
}
