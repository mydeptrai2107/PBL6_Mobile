import 'package:flutter/material.dart';
import 'package:pbl6/config/value.dart';
import 'package:pbl6/models/cart.dart';
import 'package:pbl6/models/cart_ordered.dart';
import 'package:pbl6/models/order.dart';
import 'package:pbl6/pages/home_page.dart';
import 'package:pbl6/screens/home_screen.dart';
import 'package:pbl6/services/repository_order.dart';
import 'package:pbl6/values/app_assets.dart';

// ignore: must_be_immutable
class PurchaseOrder extends StatefulWidget {
  PurchaseOrder({Key? key, required this.indexTab}) : super(key: key);

  int indexTab;

  @override
  State<PurchaseOrder> createState() => _PurchaseOrderState();
}

class _PurchaseOrderState extends State<PurchaseOrder>
    with SingleTickerProviderStateMixin {
  RepositoryOrder repositoryOrder = RepositoryOrder();
  List<Order> list = [];
  List<Cart> listCart = [];
  List<CartOrder> listCartOrder = [];

  late TabController _tabController;

  bool isLoading = true;

  void _getData() async {
    list = await repositoryOrder.getOrderItemByUserId('1');
    for (int i = 0; i < list.length; i++) {
      listCart =
          await repositoryOrder.getCartItemByOrderId(list[i].id.toString());
      for (int j = 0; j < listCart.length; j++) {
        listCartOrder.add(mappingCartToCartOrder(listCart[j], list[i].id));
      }
    }

    isLoading = false;
    setState(() {});
  }

  CartOrder mappingCartToCartOrder(Cart cart, int idOrder) {
    CartOrder cartOrder = CartOrder(
        id: cart.id,
        userId: cart.userId,
        productId: cart.productId,
        productName: cart.productName,
        productQuantityLeft: cart.productQuantityLeft,
        productCount: cart.productCount,
        pricePerOne: cart.pricePerOne,
        description: cart.description,
        idOrder: idOrder);
    return cartOrder;
  }

  @override
  void initState() {
    _getData();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.animateTo(widget.indexTab);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn mua'),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(currentIndex: 0),
                  ));
            },
            icon: const Icon(Icons.arrow_back)),
        bottom:
            TabBar(controller: _tabController, isScrollable: true, tabs: const [
          Tab(text: 'Chờ xác nhận'),
          Tab(text: 'Xác nhận'),
          Tab(text: 'Chờ lấy hàng'),
          Tab(text: 'Đang giao'),
          Tab(text: 'Hoàn thành'),
          Tab(text: 'Đã hủy'),
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    List<CartOrder> cartOrders = [];
                    if (list[index].status == 1) {
                      for (int i = 0; i < listCartOrder.length; i++) {
                        if (listCartOrder[i].idOrder == list[index].id) {
                          cartOrders.add(listCartOrder[i]);
                        }
                      }
                      return itemOrder(
                          list[index], context, cartOrders, 'Chờ xác nhận');
                    } else {
                      return Container();
                    }
                  }),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    List<CartOrder> cartOrders = [];
                    if (list[index].status == 2) {
                      for (int i = 0; i < listCartOrder.length; i++) {
                        if (listCartOrder[i].idOrder == list[index].id) {
                          cartOrders.add(listCartOrder[i]);
                        }
                      }
                      return itemOrder(
                          list[index], context, cartOrders, 'Đã xác nhận');
                    } else {
                      return Container();
                    }
                  }),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    List<CartOrder> cartOrders = [];
                    if (list[index].status == 3) {
                      for (int i = 0; i < listCartOrder.length; i++) {
                        if (listCartOrder[i].idOrder == list[index].id) {
                          cartOrders.add(listCartOrder[i]);
                        }
                      }
                      return itemOrder(
                          list[index], context, cartOrders, 'Chờ lấy hàng');
                    } else {
                      return Container();
                    }
                  }),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    List<CartOrder> cartOrders = [];
                    if (list[index].status == 4) {
                      for (int i = 0; i < listCartOrder.length; i++) {
                        if (listCartOrder[i].idOrder == list[index].id) {
                          cartOrders.add(listCartOrder[i]);
                        }
                      }
                      return itemOrderCancel(
                          list[index], context, cartOrders, 'Đang giao hàng');
                    } else {
                      return Container();
                    }
                  }),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    List<CartOrder> cartOrders = [];
                    if (list[index].status == 5) {
                      for (int i = 0; i < listCartOrder.length; i++) {
                        if (listCartOrder[i].idOrder == list[index].id) {
                          cartOrders.add(listCartOrder[i]);
                        }
                      }
                      return itemOrderCancel(
                          list[index], context, cartOrders, 'Hoàn thành');
                    } else {
                      return Container();
                    }
                  }),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    List<CartOrder> cartOrders = [];
                    if (list[index].status == 6) {
                      for (int i = 0; i < listCartOrder.length; i++) {
                        if (listCartOrder[i].idOrder == list[index].id) {
                          cartOrders.add(listCartOrder[i]);
                        }
                      }
                      return itemOrderCanceled(
                          list[index], context, cartOrders);
                    } else {
                      return Container();
                    }
                  }),
        ],
      ),
    );
  }

  Widget itemOrderCancel(Order order, BuildContext context,
      List<CartOrder> listCart, String status) {
    Size size = MediaQuery.of(context).size;
    int count = 0;
    int cost = 48000;
    for (int i = 0; i < listCart.length; i++) {
      count += listCart[i].productCount;
      cost += (listCart[i].productCount * listCart[i].pricePerOne).toInt();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage(AppAssets.store))),
              ),
              Text(
                '  $shop',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Expanded(child: Container()),
              Text(
                status,
                style: const TextStyle(fontSize: 14, color: Colors.red),
              ),
            ],
          ),
        ),
        SizedBox(
            width: size.width,
            child: Column(
              children: [
                for (int i = 0; i < listCart.length; i++)
                  itemCart(listCart[i], context),
                const Divider(
                  thickness: 1,
                ),
                Container(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                  child: Row(
                    children: [
                      Text(
                        '$count sản phẩm',
                        style:
                            const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Expanded(child: Container()),
                      const Text(
                        'Tổng thanh toán: ',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      Text(
                        '$cost đ',
                        style: const TextStyle(fontSize: 15, color: Colors.red),
                      )
                    ],
                  ),
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Bạn hãy đánh giá sản phẩm nhé',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black26),
                    borderRadius: BorderRadius.circular(50)),
                child: const Text(
                  'Đánh giá',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black38),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: size.width,
          height: 20,
          color: Colors.grey[350],
        )
      ],
    );
  }

  Widget itemOrder(Order order, BuildContext context, List<CartOrder> listCart,
      String status) {
    Size size = MediaQuery.of(context).size;
    int count = 0;
    int cost = 48000;
    for (int i = 0; i < listCart.length; i++) {
      count += listCart[i].productCount;
      cost += (listCart[i].productCount * listCart[i].pricePerOne).toInt();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage(AppAssets.store))),
              ),
              Text(
                '  $shop',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Expanded(child: Container()),
              Text(
                status,
                style: const TextStyle(fontSize: 14, color: Colors.red),
              ),
            ],
          ),
        ),
        SizedBox(
            width: size.width,
            child: Column(
              children: [
                for (int i = 0; i < listCart.length; i++)
                  itemCart(listCart[i], context),
                const Divider(
                  thickness: 1,
                ),
                Container(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                  child: Row(
                    children: [
                      Text(
                        '$count sản phẩm',
                        style:
                            const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Expanded(child: Container()),
                      const Text(
                        'Tổng thanh toán: ',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      Text(
                        '$cost đ',
                        style: const TextStyle(fontSize: 15, color: Colors.red),
                      )
                    ],
                  ),
                ),
              ],
            )),
        InkWell(
          onTap: () async {
            var check = await repositoryOrder.updateStatusOrder(order.id, 6);
            if (check) {
              // ignore: use_build_context_synchronously
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PurchaseOrder(indexTab: 5),
                  ));
            } else {
              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: const Text("Hủy đơn hàng không thành công"),
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black26),
                borderRadius: BorderRadius.circular(50)),
            child: const Text(
              'Hủy',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black38),
            ),
          ),
        ),
        Container(
          width: size.width,
          height: 20,
          color: Colors.grey[350],
        )
      ],
    );
  }

  Widget itemOrderCanceled(
      Order order, BuildContext context, List<CartOrder> listCart) {
    Size size = MediaQuery.of(context).size;
    int count = 0;
    int cost = 48000;
    for (int i = 0; i < listCart.length; i++) {
      count += listCart[i].productCount;
      cost += (listCart[i].productCount * listCart[i].pricePerOne).toInt();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage(AppAssets.store))),
              ),
              Text(
                '  $shop',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Expanded(child: Container()),
              const Text(
                'Đã hủy',
                style: TextStyle(fontSize: 14, color: Colors.red),
              ),
            ],
          ),
        ),
        SizedBox(
            width: size.width,
            child: Column(
              children: [
                for (int i = 0; i < listCart.length; i++)
                  itemCart(listCart[i], context),
                const Divider(
                  thickness: 1,
                ),
                Container(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                  child: Row(
                    children: [
                      Text(
                        '$count sản phẩm',
                        style:
                            const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Expanded(child: Container()),
                      const Text(
                        'Tổng thanh toán: ',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      Text(
                        '$cost đ',
                        style: const TextStyle(fontSize: 15, color: Colors.red),
                      )
                    ],
                  ),
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Đã hủy bởi bạn',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black26),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Text(
                    'Mua lại',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black38),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: size.width,
          height: 20,
          color: Colors.grey[350],
        )
      ],
    );
  }

  Widget itemCart(CartOrder cart, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image: NetworkImage(
                      '${iPURL}api/Product/GetProductImage?productId=${cart.productId}&imgNumber=1',
                    ),
                    fit: BoxFit.cover)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: size.width - 150,
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  cart.productName,
                  maxLines: 3,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 20,
                child: Text(
                  cart.description,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                height: 20,
                width: size.width - 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${cart.pricePerOne.toInt()} đ',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Số lượng: ${cart.productCount}',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
