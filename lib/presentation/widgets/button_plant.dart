import 'package:flutter/material.dart';

class ButtonPlant extends StatelessWidget {
  const ButtonPlant({
    Key? key,
    required this.switchVegetable,
    required this.size,
  }) : super(key: key);
  final VoidCallback switchVegetable;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key("key-2"),
      width: 70,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        )),
      child: ElevatedButton(
        onPressed: () {
          switchVegetable();
        },
        child: Icon(Icons.accessibility_new_rounded),
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          shape: StadiumBorder(),
        )),
    );
  }
}