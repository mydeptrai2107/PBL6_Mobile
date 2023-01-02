import 'package:flutter/material.dart';
import 'package:pbl6/config/value.dart';
import 'package:pbl6/models/cart.dart';
import 'package:pbl6/services/repository_cart.dart';
import 'package:pbl6/values/app_colors.dart';

class CardProductByCartWidget extends StatefulWidget {
  CardProductByCartWidget(
      {Key? key,
      required this.cart,
      required this.setCourtCart,
      required this.setCost,
      required this.getCartChecked})
      : super(key: key);

  final Cart cart;
  Function setCourtCart;
  Function setCost;
  Function getCartChecked;
  @override
  State<CardProductByCartWidget> createState() =>
      _CardProductByCartWidgetState();
}

class _CardProductByCartWidgetState extends State<CardProductByCartWidget> {
  bool _isCheck = false;

  int count = 1;
  RepositoryCart repositoryCart = RepositoryCart();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 1 / 5,
      margin: const EdgeInsets.only(bottom: 10),
      color: const Color.fromARGB(255, 245, 238, 217),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Checkbox(
                value: _isCheck,
                onChanged: (value) {
                  setState(() {
                    _isCheck = value!;
                  });

                  if (widget.cart.productCount <=
                      widget.cart.productQuantityLeft) {
                    widget.setCourtCart(value);
                    widget.setCost(value,
                        widget.cart.pricePerOne * widget.cart.productCount);
                    widget.getCartChecked(widget.cart, value);
                  }

                  if (_isCheck) {
                    if (widget.cart.productCount >
                        widget.cart.productQuantityLeft) {
                      setState(() {
                        _isCheck = false;
                      });
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Thông báo"),
                          content: const Text("Sản phẩm trong kho không đủ"),
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
                        ),
                      );
                    }
                  }
                },
              ),
              Container(
                height: size.width * 1 / 5,
                width: size.width * 1 / 5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            '${iPURL}api/Product/GetProductImage?productId=${widget.cart.productId}&imgNumber=1'),
                        fit: BoxFit.cover)),
              ),
              Container(
                width: size.width * 4 / 7,
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cart.productName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.cart.description,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.cart.pricePerOne.toInt()} đ',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.red),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      setState(() {
                                        widget.cart.productCount > 1
                                            ? widget.cart.productCount--
                                            : widget.cart.productCount;

                                        if (widget.cart.productCount > 1 &&
                                            _isCheck) {
                                          widget.setCost(
                                              false, widget.cart.pricePerOne);
                                        }
                                      });

                                      await repositoryCart.editCartItem(
                                          widget.cart.id,
                                          widget.cart.productCount,
                                          widget.cart.description);
                                    },
                                    icon: const Icon(
                                      Icons.remove_circle,
                                      color: AppColors.primaryColor,
                                    )),
                                Text(
                                  widget.cart.productCount.toString(),
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      setState(() {
                                        widget.cart.productCount++;
                                        if (_isCheck) {
                                          if (widget.cart.productCount >
                                              widget.cart.productQuantityLeft) {
                                            _isCheck = false;
                                            widget.setCourtCart(_isCheck);
                                            widget.setCost(
                                                _isCheck,
                                                widget.cart.pricePerOne *
                                                    (widget.cart.productCount -
                                                        1));
                                            widget.getCartChecked(
                                                widget.cart, _isCheck);
                                            showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                      title: const Text(
                                                          "Thông báo"),
                                                      content: const Text(
                                                          "Sản phẩm trong kho không đủ"),
                                                      actions: <Widget>[
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(ctx)
                                                                  .pop();
                                                              setState(() {
                                                                _isCheck =
                                                                    false;
                                                              });
                                                            },
                                                            child: const Text(
                                                              'Quay lại',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .red),
                                                            )),
                                                      ],
                                                    ));
                                          } else {
                                            widget.setCost(
                                                true, widget.cart.pricePerOne);
                                          }
                                        }
                                      });

                                      if (widget.cart.productCount <=
                                          widget.cart.productQuantityLeft) {
                                        await repositoryCart.editCartItem(
                                            widget.cart.id,
                                            widget.cart.productCount,
                                            widget.cart.description);
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.add_circle,
                                      color: AppColors.primaryColor,
                                    ))
                              ],
                            ),
                            widget.cart.productCount >
                                    widget.cart.productQuantityLeft
                                ? const Text(
                                    'Không đủ hàng',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12),
                                  )
                                : Container()
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Sản phẩm còn lại trong kho: ${widget.cart.productQuantityLeft}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
