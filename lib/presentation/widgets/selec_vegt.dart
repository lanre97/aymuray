import 'package:flutter/material.dart';

class Vegetable extends StatefulWidget {
  Vegetable({Key? key}) : super(key: key);

  @override
  VegetableState createState() => VegetableState();
}

class VegetableState extends State<Vegetable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 239, 245, 1),
      appBar: AppBar(
        title: Text("Selecciona un cultivo"),
        elevation: 2.5,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            //Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: _llenado()/* Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Text('Tubers',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
                height: 170,
                child: Row(
                  children: [
                    Expanded(
                        child: UnVegetal(image: "assets/verduras/potato.png")),
                    Expanded(
                        child: UnVegetal(image: "assets/verduras/onion.png"))
                  ],
                )),
            Container(
                height: 170,
                child: Row(
                  children: [
                    Expanded(
                        child: UnVegetal(image: "assets/verduras/yuca.png")),
                    Expanded(
                        child: UnVegetal(image: "assets/verduras/carrot.png"))
                  ],
                )),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Text('Cereals',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
                height: 170,
                child: Row(
                  children: [
                    Expanded(
                        child: UnVegetal(image: "assets/verduras/Maize.png")),
                    Expanded(
                        child: UnVegetal(image: "assets/verduras/trigo.png"))
                  ],
                )),
            Container(
                height: 170,
                child: Row(
                  children: [
                    Expanded(
                        child: UnVegetal(image: "assets/verduras/avena.png")),
                    Expanded(child: UnVegetal(image: ""))
                  ],
                ))
          ],
        ),*/
      ),
    );
  }
  Widget _llenado(){
return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Text('Tubers',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
                height: 170,
                child: Row(
                  children: [
                    Expanded(
                        child: UnVegetal(image: "assets/verduras/potato.png")),
                    Expanded(
                        child: UnVegetal(image: "assets/verduras/onion.png"))
                  ],
                )),
            Container(
                height: 170,
                child: Row(
                  children: [
                    Expanded(
                        child: UnVegetal(image: "assets/verduras/yuca.png")),
                    Expanded(
                        child: UnVegetal(image: "assets/verduras/carrot.png"))
                  ],
                )),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Text('Cereals',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
                height: 170,
                child: Row(
                  children: [
                    Expanded(
                        child: UnVegetal(image: "assets/verduras/Maize.png")),
                    Expanded(
                        child: UnVegetal(image: "assets/verduras/trigo.png"))
                  ],
                )),
            Container(
                height: 170,
                child: Row(
                  children: [
                    Expanded(
                        child: UnVegetal(image: "assets/verduras/avena.png")),
                    Expanded(child: UnVegetal(image: ""))
                  ],
                ))
          ],
        );
  }
}

class UnVegetal extends StatelessWidget {
  const UnVegetal({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
        height: 160,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        child: Container(
          height: 60,
          width: 70,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: _condicion(), //agregar la imagen
        ));
  }

  Widget _condicion() {
    if (image == "") {
      return Container();
    }
    return Image.asset(image);
  }
}
