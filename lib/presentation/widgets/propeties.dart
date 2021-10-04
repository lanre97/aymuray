import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'selector_crop.dart';

List crop_datta = [potato, maize, onion];
Map potato = {
  "title": "POTATO",
  "vitamins": ["C", "B1", "B3", "B6"],
  "minerals": [
    "Pantothenic Acid",
    "Potassium",
    "Phosphorus",
    "Magnesium",
    "Riboflavine",
    "Folate"
  ],
  "image": Image.asset('assets/potato.png'),
  "icon": 1,
  "description":
      'The potato or potato is an edible tuber that is extracted from the American herbaceous plant "Solanum tuberosum", of Andean origin. '
};
Map maize = {
  "title": "MAIZE",
  "vitamins": ["A", "B", "C", "E"],
  "minerals": [
    "Corbre",
    "Zinc",
    "Phosphorus",
    "Magnesium",
    "Riboflavine",
    "Folate"
  ],
  "image": Image.asset('assets/maize.png'),
  "icon": 1,
  "description":
      'Is a cereal grain first domesticated by indigenous peoples in southern Mexico about 10,000 years ago. '
};
Map onion = {
  "title": "ONION",
  "vitamins": ["A", "B", "C", "E"],
  "minerals": [
    "Calcium",
    "Potassium",
    "Phosphorus",
    "Magnesium",
    "Iron",
    "Folate"
  ],
  "image": Image.asset('assets/onion.png'),
  "icon": Image.asset('assets/maize_icon.png'),
  "description":
      'Red onions are onion cultivars with purple-red skin, and white flesh with reddish undertones. It tends to be medium to large in size and has a mild to sweet taste.'
};

/*class Propeties extends StatelessWidget {
  const Propeties({Key? key}) : super(key: key);

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
      body: Body2(),
    );
  }
}

class Body2 extends StatelessWidget {
  const Body2({Key? key}) : super(key: key);
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
        AllPropierties(),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          child: Text('Humidity Graph',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        Container(
            height: 250,
            child: SfCartesianChart (
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
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}*/
