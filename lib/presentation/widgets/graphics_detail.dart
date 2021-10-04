import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
class Graphics extends StatefulWidget {
  Graphics({Key? key}) : super(key: key);

  @override
  GraphicsState createState() => GraphicsState();
}

class GraphicsState extends State<Graphics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 239, 245, 1),
      appBar: AppBar(
        title: Text("INSERTE BOTON DE CAMBIO"),
        elevation: 2.5,
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            
            //Navigator.of(context).pop();
          },
        ),
        ),
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<_SalesData> data = [
      _SalesData('Jan', 35),
      _SalesData('Feb', 28),
      _SalesData('Mar', 100),
      _SalesData('Apr', 32),
      _SalesData('May', 40),
      _SalesData('Jun', 35),
      _SalesData('Jul', 28),
      _SalesData('Ago', 100),
      _SalesData('Sep', 32),
      _SalesData('Oct', 40),
      _SalesData('Nov', 32),
      _SalesData('Dic', 40)
    ];
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Row(
            children: <Widget>[
              Text('Detalles de la zona',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. At erat fermentum, sed eget rutrum ut condimentum. Tempor nisl, congue quam feugiat leo sed arcu. Faucibus velit enim, felis, platea vitae orci quisque. Fringilla aliquam tortor aliquam sed eu.'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: <Widget>[
              Spacer(),
              Container(
                height: 23,
                width: 60,
                child: Center(
                    child: Text("Perú",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text('Hoy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        Container(
          height: 100,
          child: Row(
            children: [
              Expanded(
                  child: Caracteristica(
                      title: "Temperature",
                      image: "assets/caracteristicas/temp.png",
                      magnitude: "°C",
                      unit: 25,
                      press: () {})),
              Expanded(
                child: Caracteristica(
                    title: "Humidity",
                    image: "assets/caracteristicas/humd.png",
                    magnitude: "%",
                    unit: 35,
                    press: () {}),
              ),
              Expanded(
                child: Caracteristica(
                    title: "Wind",
                    image: "assets/caracteristicas/wind.png",
                    magnitude: "m/s",
                    unit: 15,
                    press: () {}),
              ),
            ],
          ),
        ),
        Container(
          height: 100,
          padding: EdgeInsets.only(left: 48, right: 48, top: 20, bottom: 20),
          child: Row(
            children: [
              Expanded(
                  child: Caracteristica(
                      title: "Luminescence",
                      image: "assets/caracteristicas/sun.png",
                      magnitude: "kLux",
                      unit: 22,
                      press: () {})),

                    /*  Container(
          height: 100,
          child: Row(children: [])),*/
              Expanded(
                child: Caracteristica(
                    title: "Pressure",
                    image: "assets/caracteristicas/cloud.png",
                    magnitude: "kPa",
                    unit: 20,
                    press: () {}),
              ),
              /*Expanded(
                child: Container(
                    
              ),)*/
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          child: Text('Humidity Graph',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        Container(
            height: 250,
            child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500)),
                primaryYAxis: NumericAxis(maximum: 100),

                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<_SalesData, String>>[
                  LineSeries<_SalesData, String>(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'Probabilidad',
                      color: Colors.black,
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: false))
                ])),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          child: Text('Temperature Graph',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        Container(
            height: 250,
            child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500)),
                primaryYAxis: NumericAxis(maximum: 100),

                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<_SalesData, String>>[
                  LineSeries<_SalesData, String>(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'Probabilidad',
                      color: Colors.black,
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: false))
                ])),
      ],
    ));
  }
}

class Caracteristica extends StatelessWidget {
  const Caracteristica(
      {Key? key,
      required this.title,
      required this.image,
      required this.magnitude,
      required this.unit,
      required this.press})
      : super(key: key);
  final String title;
  final String image;
  final int unit;
  final String magnitude;
  final Function press;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(title,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                child: Row(children: [
                  Container(
                    height: 45,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                    child: Image.asset(image),
                  ),
                  Container(
                    height: 45,
                    width: 55,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10),
                        )),
                    child: Center(
                        child: Text("${unit}$magnitude",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold))),
                  )
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
