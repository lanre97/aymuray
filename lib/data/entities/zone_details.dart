class ZoneDetails{
  String? name;
  String? description;
  double? temperature;
  double? humidity;
  double? wind;
  double? luminiscence;
  double? rain;
  double? height;

  ZoneDetails({
    this.name,
    this.description, 
    this.temperature, 
    this.humidity, 
    this.wind, 
    this.luminiscence, 
    this.rain, 
    this.height});
  
  factory ZoneDetails.fromJson(Map<String, dynamic> json) => ZoneDetails(
    name: json['name'],
    description: json['description'],
    temperature: json['temperature'],
    humidity: json['humidity'],
    wind: json['wind'],
    luminiscence: json['luminiscence'],
    rain: json['rain'],
    height: json['height']
  );

}