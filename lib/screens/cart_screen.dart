import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6/blocs/cart_bloc/cart_bloc.dart';
import 'package:pbl6/config/value.dart';
import 'package:pbl6/models/cart.dart';
import 'package:pbl6/screens/pay_screen.dart';
import 'package:pbl6/services/repository_cart.dart';
import 'package:pbl6/values/app_colors.dart';
import 'package:pbl6/widgets/card_product_by_cart_widget.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key, this.cart}) : super(key: key);
  Cart? cart;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  RepositoryCart repositoryCart = RepositoryCart();
  List<Cart> list = [];

  int countCart = 0;
  double cost = 0;
  bool _isCheck = false;
  List<Cart> listCartChecked = [];

  final CartBloc _cartBloc = CartBloc(RepositoryCart());

  @override
  void initState() {
    _cartBloc.add(GetCartListEvent(ValueInfo.user.userId));
    super.initState();
  }

  void setCourtCart(bool value) {
    value ? countCart++ : countCart--;
    setState(() {});
  }

  void setCost(bool check, double value) {
    check ? cost += value : cost -= value;
    setState(() {});
  }

  getListCartChecked(Cart cart, bool check) {
    check ? listCartChecked.add(cart) : listCartChecked.remove(cart);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => _cartBloc,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            title: const Text('Giỏ hàng'),
            actions: [
              IconButton(
                  onPressed: () async {
                    if (listCartChecked.isNotEmpty) {
                      for (int i = 0; i < listCartChecked.length; i) {
                        await repositoryCart
                            .deleteCartItemByID(listCartChecked[i].id);
                        listCartChecked.remove(listCartChecked[i]);
                      }
                      _cartBloc.add(GetCartListEvent(ValueInfo.user.userId));
                      setState(() {});
                    } else {
                      showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                title: const Text("Thông báo"),
                                content: const Text("Vui lòng chọn sản phẩm"),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                        setState(() {
                                          _isCheck = false;
                                        });
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
                  icon: const Icon(Icons.delete_outline))
            ],
          ),
          body: Column(
            children: [
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoadingState) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is CartLoadedState) {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: state.listCart.length,
                            itemBuilder: (context, index) {
                              Cart cart = state.listCart[index];
                              return CardProductByCartWidget(
                                cart: cart,
                                setCourtCart: setCourtCart,
                                setCost: setCost,
                                getCartChecked: getListCartChecked,
                              );
                            }));
                  } else {
                    return Container();
                  }
                },
              ),
              const Divider(
                thickness: 1,
              ),
              SizedBox(
                width: size.width,
                height: size.height * 1 / 11,
                child: Row(
                  children: [
                    Checkbox(
                      value: _isCheck,
                      onChanged: (value) {
                        setState(() {
                          _isCheck = value!;
                        });
                      },
                    ),
                    const Text('Tất cả',
                        style: TextStyle(
                          fontSize: 12,
                        )),
                    Expanded(child: Container()),
                    const Text('Tổng cộng: ',
                        style: TextStyle(
                          fontSize: 12,
                        )),
                    Text(
                      '${cost.toInt()} đ',
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    Expanded(child: Container()),
                    InkWell(
                      onTap: () async {
                        if (listCartChecked.isNotEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PayScreen(list: listCartChecked),
                              ));
                        } else {
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                    title: const Text("Thông báo"),
                                    content:
                                        const Text("Vui lòng chọn sản phẩm"),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                            setState(() {
                                              _isCheck = false;
                                            });
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
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        //width: 100,
                        height: 45,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(50)),

                        child: Center(
                          child: Text(
                            'Thanh toán (${listCartChecked.length})',
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
