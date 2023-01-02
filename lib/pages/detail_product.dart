import 'package:flutter/material.dart';
import 'package:pbl6/config/value.dart';
import 'package:pbl6/models/cart.dart';
import 'package:pbl6/models/product.dart';
import 'package:pbl6/screens/cart_screen.dart';
import 'package:pbl6/screens/pay_screen.dart';
import 'package:pbl6/services/repository_cart.dart';
import 'package:pbl6/services/repository_product.dart';
import 'package:pbl6/widgets/information_promotion.dart';
import 'package:pbl6/pages/nav_bar_page.dart';
import 'package:pbl6/values/app_colors.dart';

import '../icons/my_icon_icons.dart';
import '../widgets/card_product_widget.dart';

// ignore: must_be_immutable
class DetailProduct extends StatefulWidget {
  DetailProduct({Key? key, required this.product}) : super(key: key);
  Product product;

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  int count = 1;
  int numberImage = 1;
  List<String> listSize = ['S', 'M', 'L', 'XL'];
  String currentSize = 'S';

  int currentColor = 1;

  RepositoryProduct repositoryProduct = RepositoryProduct();
  RepositoryCart repositoryCart = RepositoryCart();
  List<Product> listProduct = [];

  getProductByCategory() async {
    listProduct = await repositoryProduct
        .getProductByCategory(widget.product.categoryId.toString());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getProductByCategory();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: const NavBarPage(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(shop),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(MyIcon.search)),
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
          //image product
          Stack(
            children: [
              GestureDetector(
                onHorizontalDragStart: (details) {
                  if (details.localPosition.dx > details.localPosition.dy) {
                    numberImage < widget.product.numberOfImgs
                        ? numberImage++
                        : numberImage;
                    setState(() {});
                  } else {
                    numberImage > 1 ? numberImage-- : numberImage;
                    setState(() {});
                  }
                },
                child: Container(
                  height: size.height * 0.7,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              '${iPURL}api/Product/GetProductImage?productId=${widget.product.id}&imgNumber=$numberImage'),
                          fit: BoxFit.cover)),
                ),
              ),
              Visibility(
                visible: numberImage == 1 ? false : true,
                child: Positioned(
                  top: size.height * 0.35,
                  left: 10,
                  child: IconButton(
                      onPressed: () {
                        numberImage > 1 ? numberImage-- : numberImage;
                        setState(() {});
                      },
                      icon: const Icon(Icons.chevron_left)),
                ),
              ),
              Visibility(
                visible:
                    numberImage == widget.product.numberOfImgs ? false : true,
                child: Positioned(
                  top: size.height * 0.35,
                  left: size.width - 60,
                  child: IconButton(
                      onPressed: () {
                        numberImage < widget.product.numberOfImgs
                            ? numberImage++
                            : numberImage;
                        setState(() {});
                      },
                      icon: const Icon(Icons.chevron_right)),
                ),
              )
            ],
          ),

          //Name product
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Text(
              widget.product.productName,
              style: const TextStyle(fontSize: 25),
            ),
          ),

          //rate
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Icon(
                  Icons.star,
                  size: 30,
                  color: Colors.blue,
                ),
              ),
              Icon(
                Icons.star,
                size: 30,
                color: Colors.blue,
              ),
              Icon(
                Icons.star,
                size: 30,
                color: Colors.blue,
              ),
              Icon(
                Icons.star,
                size: 30,
                color: Colors.blue,
              ),
              Icon(
                Icons.star,
                size: 30,
                color: Colors.blue,
              ),
              Text(
                ' 0 đánh giá',
                style: TextStyle(fontSize: 20),
              )
            ],
          ),

          //cost
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            child: Text(
              '${widget.product.pricePerOne.toInt()} đ',
              style: const TextStyle(fontSize: 25, color: Colors.red),
            ),
          ),

          //information promotion
          InformationPromotion(size: size),

          //choose size
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Kích Thước: $currentSize',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listSize.length,
                itemBuilder: (context, index) {
                  return _buildButtonSize(
                      listSize[index], currentSize == listSize[index]);
                },
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          //choose color
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              'Màu sắc: ',
              style: TextStyle(fontSize: 20),
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.product.numberOfImgs,
                itemBuilder: (context, index) {
                  return _buildPickColor(
                      index + 1,
                      widget.product.id.toString(),
                      (index + 1) == currentColor);
                },
              )),

          const SizedBox(
            height: 30,
          ),

          //amount and add cart
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: size.width * 0.4,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            count > 1 ? count-- : count;
                          });
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.grey,
                        )),
                    Text(
                      count.toString(),
                      style: const TextStyle(color: Colors.grey, fontSize: 25),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            count++;
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.grey,
                        ))
                  ],
                ),
              ),

              // Button add cart
              InkWell(
                onTap: () async {
                  var value = await repositoryCart.addProductToCart(
                      ValueInfo.user.userId.toString(),
                      widget.product.id.toString(),
                      count.toString(),
                      currentSize);
                  if (value) {
                    // ignore: use_build_context_synchronously
                    _buildBottomSheet(context, size, widget.product);
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text('Thông báo'),
                              content: const Text(
                                  'Thêm vào giỏ hàng không thành công. \nVui lòng kiểm tra lại'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Quay lại'))
                              ],
                            ));
                  }
                },
                child: Container(
                  width: size.width * 0.5,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: AppColors.textColor),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      'Thêm vào giỏ'.toUpperCase(),
                      style: const TextStyle(
                          color: AppColors.textColor, fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          ),

          //buttom mua ngay
          InkWell(
            onTap: () {
              _buildBottomOrder(context, size, widget.product);
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.textColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Center(
                child: Text(
                  'MUA NGAY',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Gọi đặt mua ',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '1800.0000 ',
                style: TextStyle(fontSize: 23),
              ),
              Text(
                '(7:30 - 22:00)',
                style: TextStyle(fontSize: 20),
              )
            ],
          ),

          // description product
          const SizedBox(
            height: 40,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Mô tả sản phẩm',
                  style: TextStyle(
                    fontSize: 45,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  height: 7,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  widget.product.description,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.grey,
                    //decorationThickness: 10
                  ),
                ),
              )
            ],
          ),

          // comment product
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Đánh giá sản phẩm',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              Text(
                'Hỏi đáp - Bình luận',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ],
          ),

          // same product
          const Padding(
            padding: EdgeInsets.only(left: 10.0, top: 40, bottom: 20),
            child: Text(
              'Sản phẩm tương tự',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
          ),

          SizedBox(
            height: 500,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listProduct.length,
                itemBuilder: (context, index) {
                  Product value = listProduct[index];
                  return CardProduct(
                    product: value,
                  );
                }),
          ),

          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  _buildBottomSheet(BuildContext context, Size size, Product product) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              height: size.height * 2 / 3,
              child: Column(
                children: [
                  //add cart success
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.check_box_sharp,
                          color: AppColors.greenCheckSucces),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Thêm vào giỏ hàng thành công',
                        style: TextStyle(
                            color: AppColors.greenCheckSucces, fontSize: 20),
                      )
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  //picture and name
                  SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          height: 150,
                          width: 80,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${iPURL}api/Product/GetProductImage?productId=${product.id}&imgNumber=${product.numberOfImgs}'),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          height: 100,
                          width: size.width - 100,
                          child: Text(
                            product.productName,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(child: Container()),

                  //button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          
                        },
                        child: Container(
                          width: size.width * 0.42,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                            child: Text(
                              'Mua Thêm',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartScreen(),
                              ));
                        },
                        child: Container(
                          width: size.width * 0.42,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black),
                          child: const Center(
                            child: Text(
                              'Xem giỏ hàng',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ));
        });
  }

  _buildButtonSize(String size, bool isChoose) {
    return InkWell(
      onTap: () {
        setState(() {
          currentSize = size;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(
                width: isChoose ? 3 : 1,
                color: isChoose ? Colors.black : Colors.grey),
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            size,
            style: const TextStyle(fontSize: 17),
          ),
        ),
      ),
    );
  }

  _buildPickColor(int index, String idProduct, bool isPick) {
    return InkWell(
      onTap: () {
        setState(() {
          currentColor = index;
        });
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          border: Border.all(
              width: isPick ? 3 : 1,
              color: isPick ? Colors.black : Colors.grey),
          borderRadius: BorderRadius.circular(100),
        ),
        child: CircleAvatar(
          child: ClipOval(
            child: Image.network(
                '${iPURL}api/Product/GetProductImage?productId=$idProduct&imgNumber=$index'),
          ),
        ),
      ),
    );
  }

  _buildBottomOrder(BuildContext context, Size size, Product product) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              height: size.height * 2 / 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //add cart success
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.check_box_sharp,
                          color: AppColors.greenCheckSucces),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Kiểm tra thông tin',
                        maxLines: 2,
                        style: TextStyle(
                            color: AppColors.greenCheckSucces, fontSize: 20),
                      )
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  //picture and name
                  SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          height: 150,
                          width: 80,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${iPURL}api/Product/GetProductImage?productId=${product.id}&imgNumber=${product.numberOfImgs}'),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 20),
                            height: 100,
                            width: size.width - 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.productName,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Expanded(child: Container()),
                                Text(
                                  'Kích Thước: $currentSize',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  'Sống lương: $count',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            )),

                        //choose size
                      ],
                    ),
                  ),
                  Expanded(child: Container()),

                  //button
                  InkWell(
                    onTap: () async {
                      var value = await repositoryCart.addProductToCart(
                          ValueInfo.user.userId.toString(),
                          widget.product.id.toString(),
                          count.toString(),
                          currentSize);

                      if (value) {
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartScreen(),
                            ));
                      }
                    },
                    child: Container(
                      width: size.width,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.primaryColor),
                      child: const Center(
                        child: Text(
                          'Mua ngay',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ));
        });
  }
}
