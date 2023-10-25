import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:registation_db/db/sql_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/user.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void _deleteUser(int? id) async {
    await SqlHelper.deleteUser(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ro’yxatdan o’tgan foydalanuvchilar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
            future: SqlHelper.getUsers(),
            builder:
                (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    final user = snapshot.data?[index];
                    return ListTile(
                      onTap: () {
                        _showCurrentUser(context, user);
                      },
                      leading: CircleAvatar(
                          radius: 80,
                          foregroundImage:
                              FileImage(File(user?.imagePath ?? ""))),
                      title: Text(user?.fullName ?? "Name",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black)),
                      subtitle: Text(user?.phoneNumber ?? "Number"),
                      trailing: IconButton(
                        onPressed: () {
                          _deleteUser(user?.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: const Text("User Deleted"),
                              action: SnackBarAction(label: 'Undo', onPressed: () {

                              })));
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Platform.isIOS
                      ? const CupertinoActivityIndicator()
                      : const CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  void _showCurrentUser(BuildContext context, User? user) {
    showModalBottomSheet(
        isScrollControlled: false,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 80,
                      foregroundImage: FileImage(File(user?.imagePath ?? "")),
                    ),
                    title: Text(user?.fullName ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                    subtitle: Text(user?.password ?? ""),
                  ),
                  const SizedBox(height: 30),
                  const Divider(thickness: 2, color: Colors.black38),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        onPressed: () async {
                          final Uri url = Uri.parse('tel:${user?.phoneNumber}');
                          if (!await launchUrl(url)) {}
                        },
                        child: Icon(Icons.call),
                        backgroundColor: Colors.green,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          final Uri url = Uri.parse('sms:${user?.phoneNumber}');
                          if (!await launchUrl(url)) {}
                        },
                        child: Icon(Icons.sms),
                        backgroundColor: Colors.red,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
