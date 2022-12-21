// ignore_for_file: prefer_final_fields, unused_local_variable, avoid_print, use_build_context_synchronously, prefer_const_constructors

import 'package:app/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool passenable = true;

  saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('usernameUser', _username.text.toString());
    prefs.setString('passwordUser', _password.text.toString());

    final String? usernameUser = prefs.getString('usernameUser');

    if (_username.text == "" && _password.text == "") {
      print("Tidak Bisa Login!");
    } else if (_username.text == "" || _password.text == "") {
      print("Tidak Bisa Login!");
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Dashboard()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                    child: const Center(
                        child:
                            Icon(Icons.person, size: 50, color: Colors.white)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _username,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        prefixIcon: Icon(
                          Icons.account_circle_outlined,
                          size: 40,
                        ),
                        hintText: "Masukkan Username",
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: "Username",
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: passenable,
                    controller: _password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 40,
                      ),
                      hintText: "Masukkan Password",
                      hintStyle: TextStyle(color: Colors.black),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.black),
                      suffixIcon: IconButton(
                        color: Colors.green,
                        onPressed: () {
                          setState(() {
                            if (passenable) {
                              passenable = false;
                            } else {
                              passenable = true;
                            }
                          });
                        },
                        icon: Icon(passenable == true
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Colors.green,
                    elevation: 5,
                    child: SizedBox(
                      height: 50,
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: saveData,
                        child: const Center(
                          child: Text(
                            "Masuk",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
