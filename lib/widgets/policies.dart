import 'package:flutter/material.dart';
import 'package:pbl6/values/app_assets.dart';

class Policies extends StatefulWidget {
  const Policies({Key? key}) : super(key: key);

  @override
  State<Policies> createState() => _PoliciesState();
}

class _PoliciesState extends State<Policies> {
  _buildPolicies(String icon, String name, String description) {
    return Container(
      height: 200,
      width: 200,
      decoration: const BoxDecoration(
          //color: Colors.red
          ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration:
                BoxDecoration(image: DecorationImage(image: AssetImage(icon))),
          ),
          Text(
            name,
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
          SizedBox(
            child: Center(
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: GridView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1 / 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: [
          _buildPolicies(AppAssets.truck_icon, 'Miễn phí vận chuyển',
              'Nhận hàng trong vòng 3 ngày'),
          _buildPolicies(AppAssets.gift_icon, 'Quà tặng hấp dẫn',
              'Nhiều ưu đãi khuyến mãi hot'),
          _buildPolicies(AppAssets.medal_icon, 'Bảo đảm chất lượng',
              'Sản phẩm đã được kiểm định'),
          _buildPolicies(AppAssets.hotline_icon, 'Hotline 19001202',
              'Dịch vụ hỗ trợ bạn 24/7'),
        ],
      ),
    );
  }
}
