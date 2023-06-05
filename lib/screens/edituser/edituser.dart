import 'package:flutter/material.dart';
import 'package:money_management/constants/color.dart';
import 'package:money_management/db/model/userdata.dart';
import 'package:money_management/providers/userprovider.dart';
import 'package:money_management/screens/edituser/widgets/edituserbg.dart';
import 'package:money_management/widgets/bottomnavigation.dart';
import 'package:money_management/widgets/widgets.dart';
import 'package:provider/provider.dart';

class EditUser extends StatefulWidget {
  const EditUser({super.key});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool obscure = true;

  @override
  void initState() {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    final userName = userprovider.userName;
    final userPhone = userprovider.userPhone;
    final userEmail = userprovider.userEmail;

    name.text = userName;
    phone.text = userPhone;
    email.text = userEmail;
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secColor,
        body: SafeArea(
          child: Stack(alignment: Alignment.center, children: [
            editUserBackground(context),
            Positioned(
              top: MediaQuery.of(context).size.height * .15,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: plain),
                height: MediaQuery.of(context).size.height * .78,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      customBox(height: 50.0),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            controller: name,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                labelText: 'Name',
                                labelStyle: const TextStyle(
                                  fontSize: 17,
                                  color: unselected,
                                ),
                                enabledBorder: unselectedBorder(),
                                focusedBorder: selectedBorder()),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Name Required';
                              }
                              return null;
                            },
                          )),
                      box20(),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            controller: phone,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                labelText: 'Phone No.',
                                labelStyle: const TextStyle(
                                    fontSize: 17, color: unselected),
                                enabledBorder: unselectedBorder(),
                                focusedBorder: selectedBorder()),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Phone No. Required';
                              }
                              if (value.length > 10 || value.length < 10) {
                                return 'Invalid Phone Number';
                              }
                              return null;
                            },
                          )),
                      box20(),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            controller: email,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                labelText: 'Email',
                                labelStyle: const TextStyle(
                                  fontSize: 17,
                                  color: unselected,
                                ),
                                enabledBorder: unselectedBorder(),
                                focusedBorder: selectedBorder()),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email Required';
                              }
                              if (value.contains('@gmail.com')) {
                                return null;
                              } else {
                                return 'Invalid email';
                              }
                            },
                          )),
                      box20(),
                      box10(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: prColor),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              onbuttonclick();
                            }
                          },
                          child: secText600(data: 'Update')),
                    ],
                  ),
                ),
              ),
            )
          ]),
        ));
  }

  Future<void> onbuttonclick() async {
    final namedb = name.text.trim();
    final phonedb = phone.text.trim();
    final usernamedb = email.text.trim();

    if (phonedb.contains('-') ||
        phonedb.contains('.') ||
        phonedb.contains(',') ||
        phonedb.contains(' ')) {
      showSnackBarr(context, 'Data contains Invalid Characters');
    } else {
      showToast(message: 'User Details Modified');
      final userprovider = Provider.of<UserProvider>(context, listen: false);
      final userId = userprovider.userId;
      final useredit = UserModel(
        id: userId,
        name: namedb,
        phn: phonedb,
        mail: usernamedb,
      );
      userprovider.editUser(useredit);
      await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavigation(),
          ));
    }
  }
}
