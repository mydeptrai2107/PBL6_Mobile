import 'package:flutter/material.dart';
import 'package:pbl6/config/value.dart';
import 'package:pbl6/screens/home_screen.dart';
import 'package:pbl6/screens/information_user_screen.dart';
import 'package:pbl6/screens/login_screen.dart';

class NavBarPage extends StatelessWidget {
  const NavBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName:
                Text('${ValueInfo.user.firstName}${ValueInfo.user.lastName}'),
            accountEmail: Text(ValueInfo.user.email),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                    'https://cdn.icon-icons.com/icons2/1879/PNG/512/iconfinder-8-avatar-2754583_120515.png'),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            currentIndex: 0,
                          )));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: const Text(
                'Trang chủ',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InformationUserScreen(),
                  ));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: const Text(
                'Cá nhân',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: const Text(
                'Tin tức',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: const Text(
                'Liên hệ',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              accessToken = '';
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: const Text(
                'Đăng xuất',
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
