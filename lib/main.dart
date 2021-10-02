import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_farm/common/constants.dart';
import 'package:space_farm/data/entities/nasa_power_response.dart';
import 'package:space_farm/data/repositories/nasa_power_repository.dart';
import 'package:space_farm/presentation/pages/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<NasaPowerResponse>(
        future: NASAPowerRepositoryImplementation().getData(
          NASAPowerServices.DAILY, 
          [
            NASAPowerParameters.REALATIVE_HUMIDITY_AT_2_METERS,
            NASAPowerParameters.TEMPERATURE_AT_2_METERS
          ], 
          NASAPowerCommunities.AGROCLIMATOLOGY, 
          Location(-6.487490, -76.363251), 
          DateTime(2015), 
          DateTime(2018)
        ),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(snapshot.hasError){
            return Center(child: Text("Something went wrong", style: TextStyle(color: Colors.red)));
          }

          final data = snapshot.data;

          final properties = data?.data.map((key, value) => MapEntry(key, ListView.builder(
            itemCount: value.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return ListTile(
                title: Text(value.keys.elementAt(index)),
                subtitle: Text(value.values.elementAt(index).toString()),
              );
            }
          )));

          return ListView(
            children: [
              Text("Location(${data?.geometry?.coordinates?[1]??""},${data?.geometry.coordinates?[0]??""})"),
              Text(data?.parameters[NASAPowerParameters.REALATIVE_HUMIDITY_AT_2_METERS]?.longname??""),
              properties?[NASAPowerParameters.REALATIVE_HUMIDITY_AT_2_METERS]??Container(),
              Text(data?.parameters[NASAPowerParameters.TEMPERATURE_AT_2_METERS]?.longname??""),
              properties?[NASAPowerParameters.TEMPERATURE_AT_2_METERS]??Container()              
            ],
          );
        },
      )
    );
  }
}
