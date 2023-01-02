import 'package:flutter/material.dart';
import 'package:pbl6/values/app_assets.dart';

class DealProduct extends StatefulWidget {
  const DealProduct({Key? key}) : super(key: key);

  @override
  State<DealProduct> createState() => _DealProductState();
}

class _DealProductState extends State<DealProduct> {
  _buildProduct(String img, String name, String cost){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 580,
      width: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 350,
            width: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.cover
              )
            ),
          ),

          const SizedBox(height: 10,),
          Text(
            name,
            style: const TextStyle(
              fontSize: 20
            ),
          ),

          const SizedBox(height: 10,),
          const Text(
            '⭐ ⭐ ⭐ ⭐ ⭐',
            style: TextStyle(
              fontSize: 20
            )
          ),

          const SizedBox(height: 10,),
          Text(
            '$cost đ',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.red
            ),
          ),

          const SizedBox(height: 10,),
          const Text(
            '240000' ' đ',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough
            ),
          ),
          Expanded(child: Container()),
          
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.fire)
                  )
                ),
              ),
              
              const Text(
                'Sắp cháy hàng',
                style: TextStyle(
                  fontSize: 18
                ),
              )
            ],
          ),

          const SizedBox(height: 10,),

          Stack(
            children: [
              Container(
                width: 250,
                height: 9,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10)
                ),
              ),

              Container(
                width: 230,
                height: 9,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30,),
        Row(
          children: [
            const Padding(
              padding:  EdgeInsets.all(10.0),
              child:  Text(
                'Giảm giá sốc 50%',
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            ),

            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.hot_deal)
                )
              ),
            )
          ],
        ),


        const SizedBox(height: 20,),
        SizedBox(
          height: 580,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildProduct(AppAssets.gym_nu, 'Áo sơ mi nữ tay dài', '120000'),
              _buildProduct(AppAssets.gym_nu, 'Áo sơ mi nữ tay dàidsadas asdsadsa', '120000'),
              _buildProduct(AppAssets.gym_nu, 'Áo sơ mi nữ tay dàidasdas gdfg', '120000'),
              _buildProduct(AppAssets.gym_nu, 'Áo sơ mi nữ tay dài dasd', '120000'),
              _buildProduct(AppAssets.gym_nu, 'Áo sơ mi nữ tay dài', '120000'),
            ],
          ),
        ),
      ],
    );
  }
}