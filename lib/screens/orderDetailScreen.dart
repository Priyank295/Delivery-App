import 'package:DELIVERY_APP/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/bottom_navbar.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff43A047),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 70),
          margin: EdgeInsets.only(top: 70),
          decoration: BoxDecoration(
            color: Color(0xfffFFF9C5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(48),
              topRight: Radius.circular(48),
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              // height: MediaQuery.of(context).size.height - 70,
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
                          "ORDER DETAILS",
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
                // SizedBox(
                //   height: 19,
                // ),
                orderDetailsCard(context),
                orderDetailsCard(context),
                orderDetailsCard(context),
                orderDetailsCard(context),
                orderDetailsCard(context),
                orderDetailsCard(context),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
