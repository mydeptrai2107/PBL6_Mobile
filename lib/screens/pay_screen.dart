import 'package:flutter/material.dart';
import 'package:pbl6/config/value.dart';
import 'package:pbl6/models/cart.dart';
import 'package:pbl6/screens/information_user_screen.dart';
import 'package:pbl6/screens/order_success.dart';
import 'package:pbl6/services/repository_cart.dart';
import 'package:pbl6/values/app_colors.dart';
import 'package:pbl6/widgets/form_ship.dart';
import 'package:pbl6/widgets/information_order.dart';
import 'package:pbl6/widgets/information_product_pay.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({Key? key, required this.list}) : super(key: key);

  final List<Cart> list;

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  int totalProduct = 0;
  double totalCost = 0;
  List<int> idCarts = [];
  RepositoryCart repositoryCart = RepositoryCart();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.list.length; i++) {
      totalProduct += widget.list[i].productCount;
      totalCost += widget.list[i].productCount * widget.list[i].pricePerOne;
      idCarts.add(widget.list[i].id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kiểm tra'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_left)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const InformationOrder(),
                for (int i = 0; i < widget.list.length; i++)
                  InformationProductPay(
                    cart: widget.list[i],
                  ),
                const FormShip(),
                const SizedBox(
                  height: 20,
                ),
                //const MethodPay(),

                //Thông tin liên hệ và hóa đơn

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Thông tin liên hệ và hóa đơn',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Tiền Hàng (Tạm Tính)',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            ' ($totalProduct Sản phẩm)',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                          Expanded(child: Container()),
                          Text(
                            '${totalCost.toInt()} đ',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Phí vận chuyển',
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                          Expanded(child: Container()),
                          const Text(
                            '48000 đ',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Tổng Tiền',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          const Text(
                            ' (Đã bao gồm VAT)',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Expanded(child: Container()),
                          Text(
                            '${totalCost.toInt() + 48000} đ',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Tổng cộng: ',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '${(totalCost + 48000).toInt()} đ',
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.red),
              ),
              InkWell(
                onTap: () async {
                  if (ValueInfo.user.address == 'Unknow' ||
                      ValueInfo.user.lastName == 'Unknow' ||
                      ValueInfo.user.firstName == 'Unknow' ||
                      ValueInfo.user.phoneNumber == 'Unknow') {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: const Text("Không hợp lệ"),
                              content:
                                  const Text("Thông tin cá nhân chưa đầy đủ"),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const InformationUserScreen(),
                                      ));
                                    },
                                    child: const Text(
                                      'Điền thông tin',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.red),
                                    )),
                              ],
                            ));
                  } else {
                    var checkOrderSuccess = await repositoryCart.onPayment(
                        ValueInfo.user.userId,
                        idCarts,
                        ValueInfo.user.address,
                        48000);
                    // ignore: use_build_context_synchronously
                    checkOrderSuccess
                        // ignore: use_build_context_synchronously
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderSuccess(cost: totalCost),
                            ))
                        : showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  title:
                                      const Text("Đặt hàng không thành công"),
                                  content: const Text("Vui lòng thử lại sau"),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: const Text(
                                          'Quay lại',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.red),
                                        )),
                                  ],
                                ));
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.primaryColor),
                  child: const Center(
                    child: Text(
                      'ĐẶT HÀNG',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
