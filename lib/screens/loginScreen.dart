import 'dart:convert';

import 'package:DELIVERY_APP/screens/navbarScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController _uname = TextEditingController();

TextEditingController _pass = TextEditingController();
final Future<SharedPreferences> _token = SharedPreferences.getInstance();

Future<void> authethicate(
    BuildContext context, String uname, String pass) async {
  try {
    final url = Uri.parse('https://mmpl.vivekenterprise.org/public/api/login');
    Map<String, String> requestBody = <String, String>{
      'username': uname,
      'password': pass,
    };
    final SharedPreferences token = await _token;
    var request = http.MultipartRequest(
      'POST',
      url,
    )..fields.addAll(requestBody);

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(
      jsonDecode(respStr),
    );
    print("This is the Status Code$respStr");
    var encoded = json.decode(respStr);

    if (encoded['status'] == true) {
      token.setString("token", encoded['token']);
      _uname.clear();
      _pass.clear();
      Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => BottomNavBarScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          content: Text("Please check your username and password")));
    }
    // print(encoded['status']);
    // print('This is the userId${encoded['data']['user_id']}');
  } catch (error) {
    print(error);
  }
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // authethicate();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment(0, -0.7),
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.white,
                Color(
                  0xfff43A047,
                )
              ])),
        ),
        SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                Image.asset("assets/logo.png"),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "WELCOME",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                SizedBox(
                  height: 30,
                ),
                SvgPicture.asset("assets/arrow.svg"),
                SizedBox(
                  height: 19,
                ),
                Container(
                  height: 55,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    controller: _uname,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(top: 5, left: 15, right: 15),
                      hintText: "username",
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 3),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 3),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 55,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    obscureText: true,
                    controller: _pass,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(top: 5, left: 15, right: 15),
                      hintText: "password",
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 3),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 3),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    authethicate(context, _uname.text, _pass.text);
                  },
                  child: Container(
                    // padding: EdgeInsets.symmetric(),
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    width: double.infinity,
                    height: 49,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xfffFFF9C5),
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
