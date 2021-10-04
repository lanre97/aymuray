import 'package:flutter/material.dart';
import 'package:space_farm/data/entities/vegetable.dart';


import 'button_plant.dart';
import 'selector_crop.dart';

class PlantPopUp extends StatefulWidget {
  final List<Vegetable> vegetables;
  final Vegetable selected;

  final Function(Vegetable selected)? onChange;

  PlantPopUp({
    Key? key, this.onChange,
    required this.vegetables,
    required this.selected
  }) : super(key: key);

  @override
  _PlantPopUpState createState() => _PlantPopUpState();
}

class _PlantPopUpState extends State<PlantPopUp> {

  bool open = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder:
          (Widget child, Animation<double> animation) =>
              ScaleTransition(scale: animation, child: child),
      child: open? 
      SelectorCrop(
        selected: widget.selected,
        vegetables: widget.vegetables,
        onChange: widget.onChange,
        onBack: (){
          setState(() {
            open = !open;
          });
        },
      )
      : 
      ButtonPlant(
        size: MediaQuery.of(context).size,
        switchVegetable: () {
          setState(() {
            open = !open;
          });
        }
      ),
    
    );
  }
}