import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pbl6/blocs/auth_bloc/auth_bloc.dart';
import 'package:pbl6/config/value.dart';
import 'package:pbl6/screens/purchase_order.dart';
import 'package:pbl6/services/repository_account.dart';
import 'package:pbl6/values/app_colors.dart';

import '../values/app_assets.dart';
import 'dart:io';

class InformationUserScreen extends StatefulWidget {
  const InformationUserScreen({Key? key}) : super(key: key);

  @override
  State<InformationUserScreen> createState() => _InformationUserScreenState();
}

class _InformationUserScreenState extends State<InformationUserScreen> {
  File? _image;
  final imagePicker = ImagePicker();

  RepositoryAccount repositoryAccount = RepositoryAccount();

  Future getImage() async {
    // ignore: deprecated_member_use
    final image = await imagePicker.getImage(source: ImageSource.camera);

    if (image == null) return;
    final imageTemporary = File(image.path);

    setState(() {
      _image = imageTemporary;
    });
  }

  _getName(String value) {
    String firstName = '';
    String lastName = '';
    int save = 0;
    for (int i = 0; i < value.length; i++) {
      if (value[i] != ' ') {
        firstName += value[i];
        save = i;
      } else {
        save = i;
        break;
      }
    }

    for (int i = save; i < value.length; i++) {
      lastName += value[i];
    }
    ValueInfo.user.firstName = firstName;
    ValueInfo.user.lastName = lastName;
  }

  _getSex(String value) {
    value == "Nam" ? ValueInfo.user.sex = true : ValueInfo.user.sex = false;
  }

  _getAddress(String value) {
    ValueInfo.user.address = value;
  }

  _getPhoneNumber(String value) {
    ValueInfo.user.phoneNumber = value;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AuthBloc(RepositoryAccount()),
      child: Builder(builder: (context) {
        return BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            // ignore: unrelated_type_equality_checks
            if (state is EditUserLoadingState) {
              showDialog(
                context: context,
                builder: (context) {
                  return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 130, vertical: 290),
                      height: 50,
                      width: 50,
                      child: const CircularProgressIndicator());
                },
              );
            }

            if (state is EditUserErrorState) {
              Navigator.pop(context);
              showAboutDialog(context: context);
            }

            if (state is EditUserSuccessState) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text("Information User"),
                  actions: [
                    IconButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                              EditUserButtonPressEvent(user: ValueInfo.user));
                        },
                        icon: const Icon(Icons.done))
                  ],
                ),
                body: ListView(
                  children: [
                    // avatar
                    Container(
                      height: size.height * 1 / 4,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AppAssets.background),
                              fit: BoxFit.cover)),
                      child: InkWell(
                        onTap: () {
                          getImage();
                        },
                        child: Center(
                          child: ClipOval(
                            child: Container(
                              height: 100,
                              width: 100,
                              color: Colors.red,
                              child: _image != null
                                  ? Image.file(
                                      _image!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      'https://cdn.icon-icons.com/icons2/1879/PNG/512/iconfinder-8-avatar-2754583_120515.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(AppAssets.form),
                                    fit: BoxFit.cover)),
                          ),
                          const Text(
                            'Đơn Mua',
                            style: TextStyle(fontSize: 14),
                          ),
                          Expanded(child: Container()),
                          const Text(
                            'Xem lịch sử mua hàng',
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                          const Icon(
                            Icons.chevron_right_outlined,
                            size: 16,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildIcon('Chờ xác nhận', AppAssets.agreement,
                            'cho_xac_nhan'),
                        _buildIcon(
                            'Chờ lấy hàng', AppAssets.pickup, 'cho_lay_hang'),
                        _buildIcon(
                            'Đang giao', AppAssets.fastdelivery, 'dang_giao'),
                        _buildIcon('Đánh giá', AppAssets.rate, ''),
                      ],
                    ),

                    const Divider(
                      thickness: 1,
                    ),
                    // thông tin
                    InputInformation(
                        inf: 'Tên',
                        value:
                            "${ValueInfo.user.firstName} ${ValueInfo.user.lastName}",
                        getValue: _getName),

                    InputInformation(
                        inf: 'Địa chỉ',
                        value: ValueInfo.user.address,
                        getValue: _getAddress),

                    InputInformation(
                        inf: 'Số điện thoại',
                        value: ValueInfo.user.phoneNumber,
                        getValue: _getPhoneNumber),

                    InputSex(
                        inf: 'Giới tính',
                        value: ValueInfo.user.sex ? 'Nam' : 'Nữ',
                        getValue: _getSex),

                    const InputDatetime()
                  ],
                ));
          },
        );
      }),
    );
  }

  void _routePage(String value) {
    switch (value) {
      case 'cho_xac_nhan':
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PurchaseOrder(indexTab: 0),
            ));
        break;
      case 'cho_lay_hang':
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PurchaseOrder(indexTab: 2),
            ));
        break;
      case 'dang_giao':
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PurchaseOrder(indexTab: 3),
            ));
        break;
      default:
    }
  }

  Widget _buildIcon(String name, String url, String route) {
    return InkWell(
      onTap: () {
        _routePage(route);
      },
      child: Column(
        children: [
          Container(
            height: 25,
            width: 25,
            margin: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(url), fit: BoxFit.cover),
            ),
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 11),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class InputInformation extends StatefulWidget {
  InputInformation(
      {Key? key,
      required this.inf,
      required this.value,
      required this.getValue})
      : super(key: key);
  final String inf;
  String value;
  final void Function(String) getValue;

  @override
  State<InputInformation> createState() => _InputInformationState();
}

class _InputInformationState extends State<InputInformation> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (context, animation, secondaryAnimation) {
            return Scaffold(
                appBar: AppBar(
                  title: Text('Sửa ${widget.inf}'),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            widget.value = _controller.text;
                            widget.getValue(_controller.text);
                          });
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.done,
                          color: AppColors.primaryColor,
                        ))
                  ],
                  backgroundColor: Colors.white,
                ),
                body: Container(
                  color: Colors.grey[300],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.white,
                        child: TextField(
                          controller: _controller,
                          autofocus: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                        child: Text(
                          '100 characters only',
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    ],
                  ),
                ));
          },
        );
      },
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(widget.inf),
                Expanded(child: Container()),
                widget.value.isEmpty
                    ? const Text(
                        'Thiết lập ngay',
                        style: TextStyle(color: Colors.red),
                      )
                    : Text(widget.value),
                const Icon(Icons.chevron_right_outlined)
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 2,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class InputSex extends StatefulWidget {
  InputSex(
      {Key? key,
      required this.inf,
      required this.value,
      required this.getValue})
      : super(key: key);
  final String inf;
  String value;
  final void Function(String) getValue;

  @override
  State<InputSex> createState() => _InputSexState();
}

class _InputSexState extends State<InputSex> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 70, vertical: size.width - 130),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Giới tính',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          widget.value = 'Nam';
                          widget.getValue('Nam');
                          Navigator.pop(context);
                        });
                      },
                      child: const Text(
                        'Nam',
                        style: TextStyle(color: Colors.grey),
                      )),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          widget.value = 'Nữ';
                          widget.getValue('Nữ');
                          Navigator.pop(context);
                        });
                      },
                      child: const Text('Nữ',
                          style: TextStyle(color: Colors.grey))),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          widget.value = 'Khác';
                          Navigator.pop(context);
                        });
                      },
                      child: const Text('Khác',
                          style: TextStyle(color: Colors.grey)))
                ],
              ),
            );
          },
        );
      },
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(widget.inf),
                Expanded(child: Container()),
                widget.value.isEmpty
                    ? const Text(
                        'Thiết lập ngay',
                        style: TextStyle(color: Colors.red),
                      )
                    : Text(widget.value),
                const Icon(Icons.chevron_right_outlined)
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 2,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

class InputDatetime extends StatefulWidget {
  const InputDatetime({Key? key}) : super(key: key);

  @override
  State<InputDatetime> createState() => _InputDatetimeState();
}

class _InputDatetimeState extends State<InputDatetime> {
  String value = "";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1990),
                lastDate: DateTime.now())
            .then((pickedTime) {
          if (pickedTime == null) return;
          setState(() {
            value = DateFormat.yMd().format(pickedTime);
          });
        });
      },
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Text("Ngày sinh"),
                Expanded(child: Container()),
                value.isEmpty
                    ? const Text(
                        'Thiết lập ngay',
                        style: TextStyle(color: Colors.red),
                      )
                    : Text(value),
                const Icon(Icons.chevron_right_outlined)
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 2,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
