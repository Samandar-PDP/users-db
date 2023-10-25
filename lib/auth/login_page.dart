import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:registation_db/auth/register_page.dart';
import 'package:registation_db/component/my_text_field.dart';
import 'package:registation_db/main_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _numberController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(22),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Tizimga kirish',
                  style: TextStyle(fontSize: 28,color: CupertinoColors.black,fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              MyTextField(controller: _numberController, hint: 'Telefon raqami'),
              MyTextField(controller: _passwordController, hint: 'Parol'),
              CupertinoButton(child: Text("Ro'yxatdan o'tish"), onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const RegisterPage()));
              }),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MainPage())
                  );
                }, child: Text("Tizimga kirish"),style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF166BFA)
                )),
              ),
              Text('Version 1.0')
            ],
          ),
        ),
      ),
    );
  }
}
