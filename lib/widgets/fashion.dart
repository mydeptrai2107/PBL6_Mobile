import 'package:flutter/material.dart';
import 'package:pbl6/models/category.dart';
import 'package:pbl6/pages/product_by_category.dart';
import 'package:pbl6/services/repository_category.dart';

class Fashion extends StatefulWidget {
  const Fashion({Key? key}) : super(key: key);

  @override
  State<Fashion> createState() => _FashionState();
}

class _FashionState extends State<Fashion> {
  List<CategoryModel> list = [];
  RepositoryCategory repositoryCategory = RepositoryCategory();

  getList() async {
    list = await repositoryCategory.getAllCategory();
    setState(() {
      
    });
  }
  
  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          child: const Text(
            'Thời trang EGA',
            style: TextStyle(
              fontSize: 35,
            ),
          ),
        ),

        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {             
              return _buildFashion(list[index]);
            },
          )
        ),
      ],
    );
  }

  _buildFashion(CategoryModel categoryModel){
    return InkWell(
      onTap: (){
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) {
            return ProductByCategory(categoryModel: categoryModel,);
          },)
        );
      },
      child: SizedBox(
        height: 300,
        width: 170,
        child: Column(
          children: [
            ClipOval(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(categoryModel.imgUrl)
                  )
                ),
              ),
            ),
    
            const SizedBox(height: 20,),
    
            Text(
              categoryModel.categoryName.toUpperCase(),
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
    
            const SizedBox(height: 10,),
    
            const Text(
              '13 sản phẩm',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey
              ),
            )
          ],
        ),
      ),
    );
  }
}