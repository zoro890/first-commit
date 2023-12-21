import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homechat/screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homechat/widget/chat.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Center(
          child: Column(
        children: [
          TextField(
            controller: email,
            decoration: const InputDecoration(hintText: "Register"),
          ),
          TextField(
            controller: pass,
            decoration: const InputDecoration(hintText: "Password"),
          ),
          ElevatedButton(
              onPressed: () async {
                setState(() {});
                try {
                  UserCredential newUser = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email.text,
                    password: pass.text,
                  );

                  final user = newUser.user;

                  await user!.sendEmailVerification();

                  if (context.mounted) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreeen()));
                  }
                } on FirebaseAuthException catch (e) {
                  print(e.code);
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                } finally {
                  setState(() {});
                }
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                minimumSize: MaterialStatePropertyAll(Size(700, 50))),
              child:const Text("Register"),),
                const SizedBox(height: 50,),
          ElevatedButton(
              onPressed: () async {
                UserCredential googleUser = await signInWithGoogle();
                if (context.mounted) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatScreen()));
                }
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                minimumSize: MaterialStatePropertyAll(Size(700, 50))),
              child: const Text("google singIn"),)
        ],
      )),
    );
  }
}
