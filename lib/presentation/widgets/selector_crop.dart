import 'package:flutter/material.dart';
import 'package:space_farm/data/entities/vegetable.dart';

class SelectorCrop extends StatelessWidget {
  
  final List<Vegetable> vegetables;
  final Vegetable selected;
  final VoidCallback? onBack;
  final Function(Vegetable selected)? onChange;

  const SelectorCrop({
    Key? key,
    required this.vegetables,
    required this.selected,
    this.onChange,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key("key-1"),
      width: 365,
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.loose,
            flex: 1,
            child: VegetableInfoContainer(vegetable: selected,onBack: onBack,),
          ),
          SelectionCrop(
            vegetables: vegetables,
            selected: selected,
            onChange: onChange,
          ),
        ],
      ),
    );
  }
}

class VegetableInfoContainer extends StatelessWidget {

  final Vegetable vegetable;
  final VoidCallback? onBack;

  const VegetableInfoContainer({Key? key, required this.vegetable, this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            bottomLeft: Radius.circular(40),
          )),
      child: DescriptionCrop(vegetable: vegetable, onBack: onBack,),
    );
  }
}

class SelectionCrop extends StatelessWidget {
  const SelectionCrop({
    Key? key,
    required this.vegetables,
    required this.selected,
    this.onChange
  }) : super(key: key);
  final Vegetable selected;
  final List<Vegetable> vegetables;
  final Function(Vegetable selected)? onChange;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OptionsCrops(
            selected: selected,
            vegetables: vegetables,
            onChange: onChange,
          ),
          Flexible(
            fit: FlexFit.loose,
            flex: 1,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(30, 81, 74, 1),
                  borderRadius: BorderRadius.circular(15)),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OptionsCrops extends StatelessWidget {
  const OptionsCrops({
    Key? key,
    required this.vegetables,
    required this.selected,
    this.onChange
  }) : super(key: key);
  final Vegetable selected;
  final List<Vegetable> vegetables;
  final Function(Vegetable selected)? onChange;
  @override
  Widget build(BuildContext context) {
    double _whidthButton = 48;
    double _heightButton = 70;
    double _marginBotom = 25;
    return Flexible(
        fit: FlexFit.tight,
        flex: 4,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 11, vertical: 11),
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(10),
          ),
          width: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.spaceAround,
                children:[
                  ...vegetables.map((value)=>ButtonVegetable(
                  marginBotom: _marginBotom, 
                  whidthButton: _whidthButton, 
                  heightButton: _heightButton, 
                  icon: value.icon!=null?Image.network(value.icon!):Image.asset('assets/potato_icon.png'), 
                  setVegetable: (){
                    onChange!(value);
                  })).toList(),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "?",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

class ButtonVegetable extends StatelessWidget {
  const ButtonVegetable({
    Key? key,
    required double marginBotom,
    required double whidthButton,
    required double heightButton,
    required this.icon,
    required this.setVegetable,
  })  : _marginBotom = marginBotom,
        _whidthButton = whidthButton,
        _heightButton = heightButton,
        super(key: key);

  final double _marginBotom;
  final double _whidthButton;
  final double _heightButton;
  final Image icon;
  final VoidCallback setVegetable;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: _marginBotom, top: 10),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5.0,
            offset: Offset(2.0, 2.0),
          )
        ],
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
          ),
          onPressed: setVegetable,
          child: icon),
      width: _whidthButton,
      height: _heightButton,
    );
  }
}

//Description
class DescriptionCrop extends StatelessWidget {

  final Vegetable vegetable;
  final VoidCallback? onBack;

  const DescriptionCrop({
    Key? key,
    required this.vegetable,
    this.onBack
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final propertisStyle = TextStyle(
        fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold);
    double paddingTopdata = 35;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      width: 300,
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          Stack(
            children: [
              Container(
                width: 300,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(85, 149, 132, 1),
                    borderRadius: BorderRadius.circular(15)),
                height: 500,
              ),
              Positioned(
                child: Transform.rotate(
                  angle: -2.913 / 2,
                  child: Container(
                    width: 400,
                    height: 400,
                    color: Color.fromRGBO(30, 81, 74, 1),
                  ),
                ),
                right: -260,
                top: -30,
              ),
              Positioned(
                child: Transform.rotate(
                  angle: -2.913 / 2,
                  child: Container(
                    width: 300,
                    height: 300,
                    color: Color.fromRGBO(85, 149, 132, 1),
                  ),
                ),
                right: -280,
                top: 70,
              ),
              Positioned(
                child: IconButton(icon: Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.blueGrey[800],
                  size: 32,
                ),onPressed: onBack,),
                left: 20,
                top: 15,
              ),
              Positioned(
                child: Container(
                    child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text("VEGETABLE",
                        style: TextStyle(fontSize: 11, color: Colors.white)),
                    Text(vegetable.name,
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))
                  ],
                )),
                top: 60,
                left: paddingTopdata,
              ),
              Positioned(
                child: Transform.rotate(
                  angle: -0.25126,
                  child: Container(
                    width: 400,
                    height: 415,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                  ),
                ),
                right: -100,
                bottom: -200,
              ),
              Positioned(
                child: Container(
                  child: vegetable.image!=null?
                  Image.network(vegetable.image!):null),
                right: 20,
                bottom: 150,
              ),
              Positioned(
                child: Minerals(
                  propertiesStyle: propertisStyle,
                  minerals: vegetable.minerals!,
                  vitamins: vegetable.vitamins!
                ),
                left: paddingTopdata,
                top: 100,
              ),
              Positioned(
                child: Image.asset('assets/admiration.png'),
                bottom: 135,
                left: 24,
              ),
              Positioned(
                child: Text("DESCRIPTION:",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                bottom: 135,
                left: 46,
              ),
              Positioned(
                child: Container(
                  width: 220,
                  margin: EdgeInsets.only(right: 30, left: 30),
                  child: Text(
                    vegetable.description!,
                    style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto"),
                  ),
                ),
                left: -5,
                bottom: 60,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Minerals extends StatelessWidget {
  const Minerals({
    Key? key,
    required this.propertiesStyle,
    required this.minerals,
    required this.vitamins
  }) : super(key: key);

  final TextStyle propertiesStyle;
  final List<String> minerals;
  final List<String> vitamins;

  @override
  Widget build(BuildContext context) {
    final vitaminsStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w900);
    return Container(
      width: 200.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Vitamins", style: vitaminsStyle),
          Wrap(
            spacing: 6.0,
            children: vitamins.map((e) => 
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff17342F),
                  borderRadius: BorderRadius.circular(1.0)
                ),
                child: Text(e, style: TextStyle(
                  fontSize:12.0,
                  color: Colors.white, 
                  fontWeight: FontWeight.bold),), 
                padding: EdgeInsets.symmetric(vertical:1.0, horizontal: 5.0),
                margin: EdgeInsets.symmetric(vertical: 3.0),
              )
            ).toList(),
          ),
          Text("Minerals", style: vitaminsStyle),
          Wrap(
            spacing: 6.0,
            children: minerals.map((e) => 
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff17342F),
                  borderRadius: BorderRadius.circular(1.0)
                ),
                child: Text(e, style: TextStyle(
                  fontSize:12.0,
                  color: Colors.white, 
                  fontWeight: FontWeight.bold),), 
                padding: EdgeInsets.symmetric(vertical:1.0, horizontal: 5.0),
                margin: EdgeInsets.symmetric(vertical: 3.0),
              )
            ).toList(),
          )
        ],
      )
    );
  }
}

//Widget other page
/*class AllPropierties extends StatelessWidget {
  const AllPropierties({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 300,
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 20,
              child: Text(
                potato["title"],
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    fontFamily: "Roboto"),
              ),
            ),
            Positioned(
              width: 60,
              top: 20,
              left: 330,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      offset: Offset(2.0, 2.0),
                    )
                  ],
                ),
                child: Image.asset(
                  'assets/green.png',
                  width: 50,
                ),
              ),
            ),
            Positioned(
              width: 380,
              top: 155,
              left: 20,
              child: Image.asset('assets/ground.png'),
            ),
            Positioned(
              top: 80,
              left: 150,
              child: potato["image"],
            ),
            Positioned(
              top: 230,
              left: 20,
              child: Column(
                children: [
                  Row(
                    children: [
                      PropertiesSquare(
                        parameter: "Temperature",
                        value: "30-50",
                      ),
                      PropertiesSquare(
                        parameter: "Wind speed",
                        value: "20km/h",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      PropertiesSquare(
                        parameter: "Lumunescense",
                        value: "50klux",
                      ),
                      PropertiesSquare(
                        parameter: "Humidity",
                        value: "70%",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class PropertiesSquare extends StatelessWidget {
  const PropertiesSquare({
    Key? key,
    required this.parameter,
    required this.value,
  }) : super(key: key);
  final String parameter;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Text(
          "${parameter}: ${value}",
          style: TextStyle(
              color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
        )),
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(bottom: 10, left: 15),
        height: 25,
        width: 165,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(5)));
  }
}*/