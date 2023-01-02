import 'package:flutter/material.dart';
import 'package:pbl6/config/value.dart';
import 'package:pbl6/values/app_assets.dart';
import 'package:pbl6/values/app_colors.dart';

class InformationOrder extends StatelessWidget {
  const InformationOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(10),
      width: size.height,
      height: 70,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Image.asset(AppAssets.map),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    ValueInfo.user.firstName + ValueInfo.user.lastName,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    ValueInfo.user.phoneNumber,
                    style: const TextStyle(fontSize: 14),
                  )
                ],
              ),
              Text(
                ValueInfo.user.address,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              )
            ],
          ),
          Expanded(child: Container()),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ))
        ],
      ),
    );
  }
}
