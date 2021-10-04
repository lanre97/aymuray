import 'package:flutter/material.dart';
import 'package:space_farm/data/entities/vegetable.dart';

import 'button_plant.dart';
import 'selector_crop.dart';

List<Vegetable> cropData = [potato, maize, onion];

Vegetable potato = Vegetable(
  name: "POTATO",
  vitamins: ["C", "B1", "B3", "B6"],
  minerals: [
    "Pantothenic Acid",
    "Potassium",
    "Phosphorus",
    "Magnesium",
    "Riboflavine",
    "Folate"
  ],
  image: 'assets/potato.png',
  icon: '1',
  description:
      'The potato or potato is an edible tuber that is extracted from the American herbaceous plant "Solanum tuberosum", of Andean origin.',
  environment: VegetableEnvironment()
);

Vegetable maize = Vegetable(
  name: "POTATO",
  vitamins: ["C", "B1", "B3", "B6"],
  minerals: [
    "Pantothenic Acid",
    "Potassium",
    "Phosphorus",
    "Magnesium",
    "Riboflavine",
    "Folate"
  ],
  image: 'assets/potato.png',
  icon: '1',
  description:
      'The potato or potato is an edible tuber that is extracted from the American herbaceous plant "Solanum tuberosum", of Andean origin.',
  environment: VegetableEnvironment()
);
Vegetable onion = Vegetable(
  name: "POTATO",
  vitamins: ["C", "B1", "B3", "B6"],
  minerals: [
    "Pantothenic Acid",
    "Potassium",
    "Phosphorus",
    "Magnesium",
    "Riboflavine",
    "Folate"
  ],
  image: 'assets/potato.png',
  icon: '1',
  description:
      'The potato or potato is an edible tuber that is extracted from the American herbaceous plant "Solanum tuberosum", of Andean origin.',
  environment: VegetableEnvironment()
);

class PlantPopUp extends StatefulWidget {
  PlantPopUp({Key? key}) : super(key: key);

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
        selected: potato,
        vegetables: cropData,
      )
      : 
      ButtonPlant(
        size: MediaQuery.of(context).size,
        switchVegetable: () {
          setState(() {
            open = !open;
          });
        }
      )
    );
  }
}