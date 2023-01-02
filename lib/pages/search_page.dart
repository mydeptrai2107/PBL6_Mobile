import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6/blocs/product_bloc/product_bloc.dart';
import 'package:pbl6/services/repository_product.dart';
import 'package:pbl6/values/app_colors.dart';
import 'package:pbl6/widgets/cart_product_two_column.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => ProductBloc(RepositoryProduct()),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
              ),
              actions: [
                const SizedBox(
                  width: 50,
                ),
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 7),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 2, color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                      child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(border: InputBorder.none),
                  )),
                )),
                InkWell(
                  onTap: () {
                    context
                        .read<ProductBloc>()
                        .add(SearchProductEvent(name: _controller.text));
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(100)),
                    child: const Center(
                      child: Text(
                        'Tìm kiếm',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductLoaded) {
                  return ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                          color: Colors.grey[200],
                          height: state.product.length / 2 * (size.width),
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
                          )),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
