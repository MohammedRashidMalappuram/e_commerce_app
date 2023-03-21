import 'package:flutter/material.dart';


class BuyNow extends StatefulWidget {
   const BuyNow({super.key});

  @override
  State<BuyNow> createState() => _BuyNowState();
}

class _BuyNowState extends State<BuyNow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
          onPressed: (() {
            Navigator.pop(context);
          }),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          )),
      title: const Text(
        "Add address",
        style: TextStyle(color: Colors.black),
      ),
    ),);
  }
}
