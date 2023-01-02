import 'package:flutter/material.dart';

class CardCategory extends StatelessWidget {
  const CardCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white
      ),
      child: Column(
        children: [
          Container(
            width: size.width * 0.3,
            height: size.width * 0.25,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://www.chapi.vn/img/product/2021/6/26/ao-thun-nam-trung-nien-pixi-2-new.jpg",),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 5),
            child: const Text("Thời trang nữ",
            style: TextStyle(
              fontSize: 18
            ),),
          )
        ],
      ),
    );
  }
}