import 'package:flutter/material.dart';
import 'package:pbl6/icons/my_icon_icons.dart';
import 'package:pbl6/pages/home_page.dart';
import 'package:pbl6/screens/cart_screen.dart';
import 'package:pbl6/screens/purchase_order.dart';
import 'package:pbl6/values/app_colors.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({Key? key, required this.cost}) : super(key: key);
  final double cost;
  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ));
              },
              icon: const Icon(MyIcon.shopping_bag)),
        ],
      ),
      body: ListView(
        children: [
          Container(
            width: size.width,
            height: size.height * 1 / 4.5,
            padding: const EdgeInsets.all(10),
            color: AppColors.primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '✔ Đặt hàng thành công',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Text(
                  'Vui lòng chuẩn bị ${widget.cost} để thanh toán khi nhận hàng. Chọn mục đơn mua để xem thêm thông tin',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ));
                      },
                      child: Container(
                        width: size.width * 1 / 2 - 20,
                        height: 35,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(7)),
                        child: const Center(
                          child: Text(
                            'Trang chủ',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PurchaseOrder(indexTab: 0),
                            ));
                      },
                      child: Container(
                        width: size.width * 1 / 2 - 20,
                        height: 35,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(7)),
                        child: const Center(
                          child: Text(
                            'Đơn mua',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey[300],
                  height: 1,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Text(
                  'Có thể bạn cũng thích',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.grey[300],
                  height: 1,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
