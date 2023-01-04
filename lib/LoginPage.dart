import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'KonfirmasiPassword.dart';
import 'HalamanUtama.dart';
import 'Daftar.dart';
import 'dart:convert';
import 'dart:async';


class Response {
  final String status;
  final String message;

  Response({this.status, this.message});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(status: json['status'], message: json['message']);
  }
}

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'avenir'),
      home: loginPage(),
    );
  }
}

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

TextEditingController username = TextEditingController();
TextEditingController password = TextEditingController();
String _response = '';

class _loginPageState extends State<loginPage> {
  // fungsi untuk kirim http post
  Future<Response> post(String url, var body) async {
    return await http.post(Uri.parse(url),
        body: body,
        headers: {"Accept": "application/json"}).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return Response.fromJson(json.decode(response.body));
    });
  }

  // login shared prefs

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  void _kirimAPI() {
    post('http://192.168.1.17/api/masuk.php', {
      "username": username.text,
      "password": password.text,
    }).then((response) async {
      // jika respon normal
      setState(() {
        _response = response.message;
      });

      //print(_response);

      if (response.status == 'success') {
        // menuju route list product
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    },
        // jika respon error
        onError: (error) {
          _response = error.toString();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Work Project",
              style: TextStyle(fontSize: 35),
            ),
            Text(
              "Sign in to continue...",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "User Name",
              style: TextStyle(
                fontSize: 23,
              ),
            ),
            TextField(
              controller: username,
              decoration: InputDecoration(hintText: "Example: Latifah Arum"),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Password",
              style: TextStyle(
                fontSize: 23,
              ),
            ),
            TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(hintText: "Enter your password here",
                prefixIcon: Icon(Icons.vpn_key),
                suffixIcon: IconButton(
                  onPressed: showHide,
                  color: Colors.grey,
                  icon: Icon(_secureText
                      ? Icons.visibility_off
                      : Icons.visibility),
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: openForgotPassword,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
            InkWell(
              onTap: openHomePage,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      color: Color(0xFF2596BE)),
                  child: Text(
                    "Log In",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: RegisterPage,
                  child: Text(
                    "Dont have account? Create Here",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
            InkWell(
              onTap: RegisterPage,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      color: Color(0xFF2596BE)),
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void openForgotPassword() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgotPassword()));
  }

  void openHomePage() {
    _kirimAPI();
  }

  void RegisterPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Register()));
  }
}
