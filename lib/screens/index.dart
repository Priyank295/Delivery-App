import 'package:DELIVERY_APP/components/widgets.dart';
import 'package:DELIVERY_APP/screens/loginScreen.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

int a = 0;

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Center(
          //   child: InkWell(
          //     onTap: () => {
          //       setState(() {
          //         a = a + 1;
          //       }),
          //     },
          //     child: Container(
          //       height: 50,
          //       width: 200,
          //       decoration: BoxDecoration(color: Colors.red),
          //       child: Center(child: Text("Button")),
          //     ),
          //   ),
          // ),
          // Text(a.toString()),
          redBtn(context, "Priyank"),
          redBtn(context, "jenmish"),
        ],
      ),
    );
  }
}
