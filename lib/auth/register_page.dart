import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:registation_db/component/my_text_field.dart';
import 'package:registation_db/db/sql_helper.dart';
import 'package:registation_db/main_page.dart';
import 'package:registation_db/model/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _name = TextEditingController();
  final _number = TextEditingController();
  final _country = TextEditingController();
  final _address = TextEditingController();
  final _parol = TextEditingController();
  var _selectedCountry = 'Uzbekistan';
  final _countries = [
    'Uzbekistan',
    'Russia',
    'England'
        'Korea',
    'USA'
  ];
  final _picker = ImagePicker();
  XFile? _xFile;

  void _saveNewUser() async {
    final newUser = User(null,
        imagePath: _xFile?.path ?? "",
        fullName: _name.text,
        phoneNumber: _number.text,
        country: _selectedCountry,
        address: _address.text,
        password: _parol.text);
    await SqlHelper.saveUser(newUser);
  }

  bool _isSecureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(22),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Ro‘yxatdan o‘tish',
                    style: TextStyle(
                        fontSize: 28,
                        color: CupertinoColors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                _roundImage(),
                MyTextField(controller: _name, hint: 'Ism, familya'),
                MyTextField(controller: _number, hint: 'Telefon raqami'),
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(hintText: 'Davlat'),
                    value: _selectedCountry,
                    items: _countries
                        .map((e) => DropdownMenuItem(
                            value: e, child: Text(e.toString())))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCountry = value ?? "Uzbekistan";
                      });
                    },
                  ),
                ),
                MyTextField(controller: _address, hint: 'Manzil'),
                TextField(
                  controller: _parol,
                  obscureText: _isSecureText,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isSecureText = !_isSecureText;
                        });
                      },
                      icon: Icon(
                        _isSecureText ? Icons.visibility_off : Icons.visibility
                      ),
                    )
                  ),
                ),
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        _saveNewUser();
                        Navigator.of(context)
                            .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MainPage()), (Route<dynamic> route) => false);
                      },
                      child: Text("Ro’yxatdan o’tish"),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF166BFA))),
                ),
                Text('Version 1.0')
              ],
            ),
          )),
    );
  }

  Widget _roundImage() {
    return InkWell(
      onTap: () async {
        final image = await _picker.pickImage(source: ImageSource.gallery);
        setState(() {
          _xFile = image;
        });
      },
      borderRadius: BorderRadius.circular(50),
      child: Stack(children: [
        Container(
          height: 100,
          width: 100,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(color: Colors.blue)),
          child: _xFile == null
              ? Icon(Icons.image)
              : CircleAvatar(
                  foregroundImage: FileImage(File(_xFile?.path ?? "")),
                ),
        ),
        Positioned(
          bottom: 15,
          right: 15,
          child: Container(
            width: 30,
            height: 30,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0xFF166BFA)),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        )
      ]),
    );
  }
}
