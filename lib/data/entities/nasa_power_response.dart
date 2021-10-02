class NasaPowerResponse{
  final String? type;
  final NasaPowerResponseGeometry geometry;
  final Map<String,Map<String,dynamic>> data;
  final Map<String, NasaPowerResponseParameter> parameters;

  const NasaPowerResponse(this.type,this.geometry,this.data,this.parameters);

  factory NasaPowerResponse.fromJson(Map<String,dynamic> json) => NasaPowerResponse(
    json['type'],
    NasaPowerResponseGeometry.fromJson(json['geometry']),
    json['properties']['parameter'].cast<String,Map<String,dynamic>>(),
    json['parameters'].map((key, value) => MapEntry(key, NasaPowerResponseParameter.fromJson(value)))
    .cast<String,NasaPowerResponseParameter>()
  );

}

class NasaPowerResponseGeometry{
  final String? type;
  final List<double>? coordinates;
  const NasaPowerResponseGeometry(this.type,this.coordinates);

  factory NasaPowerResponseGeometry.fromJson(Map<String,dynamic> json)=>
    NasaPowerResponseGeometry(json['type'], json['coordinates'].cast<double>());

}

class NasaPowerResponseParameter{
  final String? units;
  final String? longname;

  const NasaPowerResponseParameter(this.units,this.longname);
  
  factory NasaPowerResponseParameter.fromJson(Map<String,dynamic> json) =>
    NasaPowerResponseParameter(json['units'], json['longname']);

}