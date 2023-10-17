import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/bottom_navbar.dart';

class PasswordUpdatedScreen extends StatelessWidget {
  const PasswordUpdatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff43A047),
      // bottomNavigationBar: BottomNavBar(context),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 70),
          decoration: BoxDecoration(
            color: Color(0xfffFFF9C5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(48),
              topRight: Radius.circular(48),
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 59),
            height: MediaQuery.of(context).size.height - 70,
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "PASSWORD",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "UPDATED",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SvgPicture.asset("assets/success2.svg")
                ]),
          ),
        ),
      ),
    );
  }
}
