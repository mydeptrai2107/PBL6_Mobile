// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6/blocs/auth_bloc/auth_bloc.dart';
import 'package:pbl6/icons/my_icon_icons.dart';
import 'package:pbl6/screens/login_screen.dart';
import 'package:pbl6/services/repository_account.dart';
import 'package:pbl6/values/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController controllerEmail;
  late TextEditingController controllerPassWord;
  late TextEditingController controllerConfirmPW;

  bool _obscurePassWord = true;
  bool _obscureConfirmPW = true;
  late String _password;
  late String _confirmPW;

  bool _isCheckbox = false;

  RepositoryAccount repositoryAccount = RepositoryAccount();

  void _tooglePassword() {
    setState(() {
      _obscurePassWord = !_obscurePassWord;
    });
  }

  void _toogleConfirmPW() {
    setState(() {
      _obscureConfirmPW = !_obscureConfirmPW;
    });
  }

  @override
  void initState() {
    controllerEmail = TextEditingController();
    controllerPassWord = TextEditingController();
    controllerConfirmPW = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: BlocProvider(
        create: (context) => AuthBloc(RepositoryAccount()),
        child: Builder(builder: (context) {
          return BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is RegisterSuccessState) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Thông báo'),
                          content: const Text('Đăng ký thành công'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ));
                                },
                                child: const Text('Đăng nhập'))
                          ],
                        ));
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    //logo
                    Container(
                      height: size.height * 0.2,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'))),
                    ),

                    //EditText email, password, confirm password
                    Container(
                      height: size.height * 0.4,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
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
                            height: 30,
                          ),

                          //password
                          Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(20),
                            child: TextFormField(
                              controller: controllerPassWord,
                              obscureText: _obscurePassWord,
                              decoration: InputDecoration(
                                  hintText: "Mật khẩu",
                                  hintStyle:
                                      const TextStyle(color: Colors.black26),
                                  prefixIcon: const Icon(
                                    Icons.lock_outline,
                                    color: Colors.black,
                                  ),
                                  suffixIcon: _obscurePassWord
                                      ? IconButton(
                                          icon: const Icon(MyIcon.eye_off,
                                              color: Colors.black),
                                          onPressed: () {
                                            _tooglePassword();
                                          },
                                        )
                                      : IconButton(
                                          icon: const Icon(MyIcon.eye,
                                              color: Colors.black),
                                          onPressed: () {
                                            _tooglePassword();
                                          },
                                        ),
                                  border: InputBorder.none),
                              onSaved: (val) => _password = val!,
                            ),
                          ),

                          const SizedBox(
                            height: 30,
                          ),

                          //confirm Password
                          Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(20),
                            child: TextFormField(
                              controller: controllerConfirmPW,
                              obscureText: _obscureConfirmPW,
                              decoration: InputDecoration(
                                  hintText: "Xác nhận lại mật khẩu",
                                  hintStyle:
                                      const TextStyle(color: Colors.black26),
                                  prefixIcon: const Icon(
                                    Icons.lock_outline,
                                    color: Colors.black,
                                  ),
                                  suffixIcon: _obscureConfirmPW
                                      ? IconButton(
                                          icon: const Icon(MyIcon.eye_off,
                                              color: Colors.black),
                                          onPressed: () {
                                            _toogleConfirmPW();
                                          },
                                        )
                                      : IconButton(
                                          icon: const Icon(MyIcon.eye,
                                              color: Colors.black),
                                          onPressed: () {
                                            _toogleConfirmPW();
                                          },
                                        ),
                                  border: InputBorder.none),
                              onSaved: (val) => _confirmPW = val!,
                            ),
                          ),

                          if (state is RegisterSuccessState)
                            const Text('Register Success')
                          else if (state is RegisterErrorState)
                            Text(state.message)
                        ],
                      ),
                    ),

                    //checkbox confirm password and button rigister
                    SizedBox(
                      height: size.height * 0.2,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                  fillColor: MaterialStateProperty.all(
                                      AppColors.primaryColor),
                                  shape: const CircleBorder(),
                                  side: const BorderSide(
                                      color: AppColors.primaryColor, width: 2),
                                  value: _isCheckbox,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isCheckbox = value!;
                                    });
                                  }),
                              const Text('Tôi đEồng ý với các diều khoản của '),
                              const Text(
                                'Farmer',
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          //button register
                          ElevatedButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                backgroundColor: _isCheckbox
                                    ? AppColors.primaryColor
                                    : Colors.grey,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 16)),
                            child: const Text(
                              "Đăng ký",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {
                              if (_isCheckbox) {
                                if (controllerPassWord.text !=
                                    controllerConfirmPW.text) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Text('Thông báo'),
                                            content: const Text(
                                                'Xác nhận mật khẩu không chính xác'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Thử lại'))
                                            ],
                                          ));
                                  controllerConfirmPW.text = '';
                                } else {
                                  context.read<AuthBloc>().add(
                                      RegisterButtonPressEvent(
                                          controllerEmail.text,
                                          controllerConfirmPW.text));
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),

                    // textbutton toggle login
                    SizedBox(
                      height: size.height * 0.15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Đã có tài khoản? ",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black54),
                              ),
                              TextButton(
                                child: const Text("Đăng nhập ngay",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 255, 50, 160),
                                        fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }),
      ),
    ));
  }
}
