import 'package:flutter/material.dart';
import 'package:pbl6/values/app_assets.dart';
import 'package:pbl6/values/app_colors.dart';

class Sale extends StatefulWidget {
  const Sale({Key? key}) : super(key: key);

  @override
  State<Sale> createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  _buildSale(String ma, String anh, String dieukien, bool checkCopy) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      height: 220,
      width: 330,
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
      child: Row(
        children: [
          Container(
            height: 150,
            width: 100,
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(AppAssets.sale_10))),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: Text(
                    'NHẬP MÃ: $ma',
                    style: const TextStyle(
                        fontSize: 22, color: AppColors.primaryColor),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: 200,
                child: Center(
                  child: Text(
                    dieukien,
                    style: const TextStyle(fontSize: 19, color: Colors.grey),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    checkCopy = true;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 10, top: 15),
                  padding: const EdgeInsets.all(8),
                  decoration:
                      const BoxDecoration(color: AppColors.primaryColor),
                  child: Text(
                    checkCopy ? 'Đã sao chép' : 'Sao chép',
                    style: const TextStyle(fontSize: 19, color: Colors.white),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(left: 10, top: 10),
                  child: const Text(
                    'Điều Kiện',
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildSale('EGA10', AppAssets.sale_10,
              'Giảm 10% cho đơn hàng tối thiếu 2tr', false),
          _buildSale('EGA15', AppAssets.sale_15,
              'Giảm 15% cho đơn hàng tối thiếu 5tr', false),
          _buildSale('EGA9', AppAssets.sale_99,
              'Giảm 10% cho đơn hàng tối thiếu 2tr', false),
          _buildSale('EGAFREESHIP', AppAssets.sale_free_ship,
              'FreeShip cho đơn hàng tối thiếu 2tr', false)
        ],
      ),
    );
  }
}
