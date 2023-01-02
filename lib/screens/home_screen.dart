import 'package:flutter/material.dart';
import 'package:pbl6/pages/category_page.dart';
import 'package:pbl6/pages/chat_page.dart';
import 'package:pbl6/screens/cart_screen.dart';
import 'package:pbl6/screens/information_user_screen.dart';
import 'package:pbl6/values/app_colors.dart';

import '../pages/home_page.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.currentIndex}) : super(key: key);
  int currentIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final tabs = [
    const HomePage(),
    const CategoryPage(),
    const ChatPage(),
    CartScreen(),
    const InformationUserScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.currentIndex,
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: "Trang chủ",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category_outlined,
            ),
            label: "Danh mục",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_outlined,
            ),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_outlined,
            ),
            label: "Giỏ hàng",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
            ),
            label: "Tài khoản",
          ),
        ],

        //lable
        showSelectedLabels: true,
        selectedFontSize: 16,

        type: BottomNavigationBarType.fixed,

        fixedColor: AppColors.primaryColor,
        iconSize: 25,
        currentIndex: widget.currentIndex,
        onTap: (index) {
          setState(() {
            widget.currentIndex = index;
          });
        },
      ),
    );
  }
}
