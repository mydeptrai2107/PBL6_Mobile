import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6/blocs/product_bloc/product_bloc.dart';
import 'package:pbl6/config/value.dart';
import 'package:pbl6/icons/my_icon_icons.dart';
import 'package:pbl6/pages/deal_product.dart';
import 'package:pbl6/pages/search_page.dart';
import 'package:pbl6/screens/cart_screen.dart';
import 'package:pbl6/services/repository_product.dart';
import 'package:pbl6/widgets/cart_product_two_column.dart';
import 'package:pbl6/widgets/fashion.dart';
import 'package:pbl6/pages/nav_bar_page.dart';
import 'package:pbl6/widgets/policies.dart';
import 'package:pbl6/pages/product.dart';
import 'package:pbl6/widgets/sale.dart';
import 'package:pbl6/values/app_assets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;
  final List<String> list = [
    AppAssets.background,
    AppAssets.slider1,
    AppAssets.slider2
  ];

  final ProductBloc _productBloc = ProductBloc(RepositoryProduct());

  @override
  void initState() {
    _productBloc.add(GetProductListEvent());
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => _productBloc,
      child: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {},
        child: Scaffold(
          drawer: const NavBarPage(),
          appBar: AppBar(
            centerTitle: true,
            title: Text(shop),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(),
                        ));
                  },
                  icon: const Icon(MyIcon.search)),
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
              //slider
              Stack(
                children: [
                  SizedBox(
                    height: size.height * 1 / 4,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(list[index]),
                                  fit: BoxFit.cover)),
                        );
                      },
                    ),
                  ),

                  //Indicator
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 6,
                      width: 150,
                      margin: EdgeInsets.only(top: size.height * 1 / 4 - 30),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return buildIndicator(index == _currentIndex, size);
                          }),
                    ),
                  )
                ],
              ),

              const Policies(),

              const Fashion(),

              const Sale(),

              const SizedBox(
                height: 30,
              ),

              const DealProduct(),

              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: size.height * 1 / 4,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppAssets.background),
                        fit: BoxFit.cover)),
              ),

              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductLoaded) {
                    return MyProduct(list: state.product);
                  } else {
                    return Container();
                  }
                },
              ),

              const SizedBox(
                height: 30,
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: size.height * 1 / 4,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppAssets.slider2),
                        fit: BoxFit.cover)),
              ),

              const SizedBox(
                height: 20,
              ),

              const Text(
                '  GỢI Ý HÔM NAY',
                style: TextStyle(
                  fontSize: 35,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductLoaded) {
                    return Container(
                        color: Colors.grey[200],
                        height: 1260,
                        child: GridView.builder(
                          itemCount: state.product.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: size.width * 1 / 2,
                                  childAspectRatio: 1 / 1.6,
                                  crossAxisSpacing: 1,
                                  mainAxisSpacing: 1),
                          itemBuilder: (context, index) {
                            return CardProductTwoColumn(
                                product: state.product[index]);
                          },
                        ));
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //buildIndicator
  Widget buildIndicator(bool isActive, Size size) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 6,
      width: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isActive ? Colors.black : Colors.white),
    );
  }
}
