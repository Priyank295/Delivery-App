import 'dart:convert';

import 'package:DELIVERY_APP/screens/navbarScreen.dart';
import 'package:DELIVERY_APP/screens/passwordUpdatedScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../components/bottom_navbar.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

TextEditingController _cur = new TextEditingController();
TextEditingController _new = new TextEditingController();
TextEditingController _confirm = new TextEditingController();
List<bool> num = [false, false, false];
List<bool> eye = [false, false, false];

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  Future<void> _fetchData(String cur, String confirm) async {
    final pref = await SharedPreferences.getInstance();

    Map<String, String> requestBody = <String, String>{
      'current_password': cur,
      'new_password': confirm,
    };
    final Uri url = Uri.parse(
        'https://mmpl.vivekenterprise.org/public/api/change_password');
    ;
    final String? userToken = pref.getString("token");

    var request = http.MultipartRequest(
      'POST',
      url,
    )..fields.addAll(requestBody);

    request.headers['Authorization'] = 'Bearer $userToken';
    request.headers['Content-Type'] = 'multipart/form-data';

    var response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final _body = await json.decode(respStr);
      print(_body);
      if (_body['status'] == true) {
        _cur.clear();
        _new.clear();
        _confirm.clear();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (ctx) => PasswordUpdatedScreen()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(new SnackBar(content: Text(_body['message'])));
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff43a047),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 70),
          decoration: BoxDecoration(
            color: Color(0xffffff9c5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(48),
              topRight: Radius.circular(48),
            ),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height - 70,
            width: double.infinity,
            child: Column(children: [
              Stack(children: [
                Padding(
                  padding: EdgeInsets.all(24),
                  // padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset("assets/back-arrow.svg")),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "CHANGE PASSWORD",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ]),
              SizedBox(
                height: 19,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Current Password",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18,
                                // ignore: use_full_hex_values_for_flutter_colors
                                color: num[0]
                                    ? Color(0xfff43A047)
                                    : Color(0xfffababab),
                                fontWeight: FontWeight.w500),
                          ),
                          TextField(
                            controller: _cur,
                            onTap: () {
                              setState(() {
                                num[0] = true;
                                num[1] = false;
                                num[2] = false;
                              });
                            },
                            onEditingComplete: () {
                              setState(() {
                                num[0] = false;
                              });
                            },
                            obscureText: !eye[0],
                            cursorColor: Color(0xfffababab),
                            decoration: InputDecoration(
                              suffixIcon: eye[0]
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          eye[0] = false;
                                        });
                                      },
                                      child: Icon(
                                        Icons.visibility,
                                        color: Colors.black87,
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          eye[0] = true;
                                        });
                                      },
                                      child: Icon(
                                        Icons.visibility_off,
                                        color: Colors.black87,
                                      ),
                                    ),
                              focusColor: Color(0xfffababab),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xfffababab)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xfffababab)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "New Password",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18,
                                // ignore: use_full_hex_values_for_flutter_colors
                                color: num[1]
                                    ? Color(0xfff43A047)
                                    : Color(0xfffababab),
                                fontWeight: FontWeight.w500),
                          ),
                          TextField(
                            controller: _new,
                            onTap: () {
                              setState(() {
                                num[1] = true;
                                num[0] = false;
                                num[2] = false;
                              });
                            },
                            obscureText: !eye[1],
                            cursorColor: Color(0xfffababab),
                            decoration: InputDecoration(
                              suffixIcon: eye[1]
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          eye[1] = false;
                                        });
                                      },
                                      child: Icon(
                                        Icons.visibility,
                                        color: Colors.black87,
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          eye[1] = true;
                                        });
                                      },
                                      child: Icon(
                                        Icons.visibility_off,
                                        color: Colors.black87,
                                      ),
                                    ),
                              focusColor: Color(0xfffababab),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xfffababab)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xfffababab)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Confirm Password",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18,
                                // ignore: use_full_hex_values_for_flutter_colors
                                color: num[2]
                                    ? Color(0xfff43A047)
                                    : Color(0xfffababab),
                                fontWeight: FontWeight.w500),
                          ),
                          TextField(
                            controller: _confirm,
                            onTap: () {
                              setState(() {
                                num[2] = true;
                                num[1] = false;
                                num[0] = false;
                              });
                            },
                            obscureText: !eye[2],
                            cursorColor: Color(0xfffababab),
                            decoration: InputDecoration(
                              suffixIcon: eye[2]
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          eye[2] = false;
                                        });
                                      },
                                      child: Icon(
                                        Icons.visibility,
                                        color: Colors.black87,
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          eye[2] = true;
                                        });
                                      },
                                      child: Icon(
                                        Icons.visibility_off,
                                        color: Colors.black87,
                                      ),
                                    ),
                              focusColor: Color(0xfffababab),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xfffababab)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xfffababab)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // passwordField(context, "New Password", num[1]),
                    // passwordField(context, "Confirm Password", num[2]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        InkWell(
                          onTap: () {
                            if (_new.text == _confirm.text) {
                              _fetchData(_cur.text, _confirm.text);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  new SnackBar(
                                      content: Text(
                                          "New Password & Confirm password are different...")));
                            }
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (ctx) => PasswordUpdatedScreen()),
                            // );
                          },
                          child: Text(
                            "Ok",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

Widget passwordField(BuildContext context, String label, bool num) {
  return Container(
    margin: EdgeInsets.only(bottom: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
              // ignore: use_full_hex_values_for_flutter_colors
              color: num ? Color(0xfff43A047) : Color(0xfffababab),
              fontWeight: FontWeight.w500),
        ),
        TextField(
          onTap: () {
            num = true;
          },
          obscureText: true,
          cursorColor: Color(0xfffababab),
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.visibility_off,
              color: Colors.black87,
            ),
            focusColor: Color(0xfffababab),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xfffababab)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xfffababab)),
            ),
          ),
        ),
      ],
    ),
  );
}
