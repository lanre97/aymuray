import 'package:space_farm/common/utils.dart';
import 'package:space_farm/data/repositories/geolocation_repository.dart';
import 'package:space_farm/data/repositories/vegetable_repository.dart';
import 'package:space_farm/data/entities/vegetable.dart';

abstract class HomeInteractor{
  final GeolocationRepository geolocationRepository;
  final VegetableRepository vegetableRepository;

  const HomeInteractor({required this.geolocationRepository, required this.vegetableRepository});

  Future<Location> getCurrenLocation();
  Future<List<Vegetable>> getVegetables();

}