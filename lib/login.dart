import 'package:credit_card_project/credit_cards_page.dart';
import 'package:credit_card_project/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  bool _isLoginFailed = false;

  void _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String email = _emailcontroller.text;

    Map<String, dynamic> data = {"email": email, "password": password};

    if (email.isNotEmpty && password.isNotEmpty) {
      final response = await http.post(
        Uri.parse("https://interview-api.onrender.com/v1/auth/login"),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2M2M2YzI5ZmFmYTVkMTAwMWRlNDkwZjYiLCJpYXQiOjE2Nzk0Mjg5MzAsImV4cCI6MzQ3OTQyODkzMCwidHlwZSI6ImFjY2VzcyJ9.3GZU2CjalRjcOHRhqm-WCvCdWaHoD5Js32VvqO2j2uY',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      print(response.body);

      if (response.statusCode == 200) {
        setState(() {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return Scaffold(
              body: CreditCardsPage(),
            );
          }),
              ModalRoute.withName(
                  '/') // Replace this with your root screen's route name (usually '/')
              );
        });
      } else {
        setState(() {
          _isLoginFailed = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // TextFormField(
              //   controller: _usernameController,
              //   decoration: InputDecoration(
              //     labelText: "username",
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _emailcontroller,
                decoration: InputDecoration(
                  labelText: "email",
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text("Login"),
              ),
              if (_isLoginFailed)
                Text(
                  "Invalid username or password",
                  style: TextStyle(color: Colors.red),
                ),
             Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(child: Text("not have an account? register"),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                return  Register();
                }));
              },
              ),
             )   
            ],
          ),
        ),
      ),
    );
  }
}
