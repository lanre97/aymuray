import 'package:flutter/material.dart';
import 'package:space_farm/common/constants.dart';
import 'package:space_farm/data/entities/nasa_power_response.dart';
import 'package:space_farm/data/repositories/nasa_power_repository.dart';

import 'common/utils.dart';

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
      home: MyHomePage(title: 'Hola mundo'),
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
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<NasaPowerResponse>(
        future: NASAPowerRepositoryImplementation().getData(
          [
            NASAPowerParameters.ROOT_ZONE_SOIL_WETNESS,
            NASAPowerParameters.GLOBAL_ILLUMINANCE
          ], 
          NASAPowerCommunities.AGROCLIMATOLOGY, 
          Location(-15.018368730360278, -73.78063749521971), 
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
              Text("Location(${data?.geometry.coordinates?[1]??""},${data?.geometry.coordinates?[0]??""})"),
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
