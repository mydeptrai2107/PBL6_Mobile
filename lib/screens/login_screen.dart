import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6/blocs/auth_bloc/auth_bloc.dart';
import 'package:pbl6/config/value.dart';
import 'package:pbl6/icons/my_icon_icons.dart';
import 'package:pbl6/screens/home_screen.dart';
import 'package:pbl6/screens/register_screen.dart';
import 'package:pbl6/services/repository_account.dart';
import 'package:pbl6/values/app_assets.dart';
import 'package:pbl6/values/app_colors.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassWord = TextEditingController();

  bool _obscureText = true;
  // ignore: unused_field
  late String _password;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassWord.dispose();
    super.dispose();
  }

  void _toogle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocProvider(
        create: (context) => AuthBloc(RepositoryAccount()),
        child: Builder(builder: (context) {
          return BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is UserLoginSuccessState) {
                ValueInfo.user = state.user;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(
                              currentIndex: 0,
                            )));
              }
            },
            builder: (context, state) {
              return Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      //logo
                      SizedBox(
                        height: size.height * 0.2,
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(AppAssets.logo),
                                  fit: BoxFit.contain)),
                        ),
                      ),

                      // textfield email and password
                      Container(
                        height: size.height * 0.25,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // email
                            Material(
                              elevation: 10,
                              borderRadius: BorderRadius.circular(20),
                              child: TextField(
                                controller: controllerEmail,
                                decoration: const InputDecoration(
                                    hintText: "Email hoặc tên đăng nhập",
                                    hintStyle: TextStyle(color: Colors.black26),
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      color: Colors.black,
                                    ),
                                    border: InputBorder.none),
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            //password
                            Material(
                              elevation: 10,
                              borderRadius: BorderRadius.circular(20),
                              child: TextFormField(
                                controller: controllerPassWord,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle:
                                        const TextStyle(color: Colors.black26),
                                    prefixIcon: const Icon(
                                      Icons.lock_outline,
                                      color: Colors.black,
                                    ),
                                    suffixIcon: _obscureText
                                        ? IconButton(
                                            icon: const Icon(MyIcon.eye_off,
                                                color: Colors.black),
                                            onPressed: () {
                                              _toogle();
                                            },
                                          )
                                        : IconButton(
                                            icon: const Icon(MyIcon.eye,
                                                color: Colors.black),
                                            onPressed: () {
                                              _toogle();
                                            },
                                          ),
                                    border: InputBorder.none),
                                onSaved: (val) => _password = val!,
                              ),
                            ),

                            const SizedBox(
                              height: 13,
                            ),

                            //Quên mật khẩu
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: const Text(
                                "Quên mật khẩu",
                                style: TextStyle(color: AppColors.primaryColor),
                              ),
                            ),

                            if (state is LoginErrorState)
                              Text(state.message)
                            else
                              Container()
                          ],
                        ),
                      ),

                      //button login, button register
                      SizedBox(
                        height: size.height * 0.3,
                        width: size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Button Login
                            ElevatedButton(
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  backgroundColor: AppColors.primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 16)),
                              child: const Text(
                                "Đăng nhập",
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                    LoginButtonPressEvent(controllerEmail.text,
                                        controllerPassWord.text));
                              },
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            //TextButton Register
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Chưa có tài khoản? ",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black54),
                                ),
                                TextButton(
                                  child: const Text("Đăng ký ngay",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterScreen(),
                                        ));
                                  },
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            //Divider Login
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: size.width * 0.25,
                                  child: const Divider(
                                    color: Colors.black54,
                                  ),
                                ),
                                const Text(
                                  'Hoặc',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black38),
                                ),
                                SizedBox(
                                  width: size.width * 0.3,
                                  child: const Divider(
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      //button login with google and facebook
                      Column(
                        children: [
                          SignInButton(Buttons.facebookNew, onPressed: () {}),
                          const SizedBox(
                            height: 10,
                          ),
                          SignInButton(Buttons.googleDark, onPressed: () {})
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
