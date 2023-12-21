import 'package:flutter/material.dart';
import 'package:homechat/screen/login.dart';
import 'package:homechat/screen/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key});

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: Center(
          child: Column(
        children: [
          Image.network(
              "https://cdn-icons-png.flaticon.com/128/1041/1041916.png"),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginScreeen()));
            },
            child: const Text("Login"),
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                minimumSize: MaterialStatePropertyAll(Size(700, 50))),
          ),
          const SizedBox(
            height: 60,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()));
            },
            child: const Text("Reg"),
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                minimumSize: MaterialStatePropertyAll(Size(700, 50))),
          )
        ],
      )),
    );
  }
}
