import 'package:flutter/material.dart';
import '../widgets/card_category_widget.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Tất cả danh mục"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1/1.1,
          crossAxisCount: 3,
        ), 
        itemCount: 20,
        itemBuilder: (context, index){
          return const CardCategory();
        }
      ),
    );
  }
}