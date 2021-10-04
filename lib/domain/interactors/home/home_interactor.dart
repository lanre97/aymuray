import 'package:space_farm/common/utils.dart';
import 'package:space_farm/data/repositories/geolocation_repository.dart';
import 'package:space_farm/data/repositories/vegetable_repository.dart';
import 'package:space_farm/data/entities/vegetable.dart';

abstract class HomeInteractor{
  Future<Location> getCurrenLocation();
  Future<List<Vegetable>> getVegetables();
}

class HomeInteractorImplementation implements HomeInteractor{
  final GeolocationRepository geolocationRepository;
  final VegetableRepository vegetableRepository;

  const HomeInteractorImplementation({
    required this.geolocationRepository, 
    required this.vegetableRepository});

  @override
  Future<Location> getCurrenLocation() {
    return geolocationRepository.getCurrentLocation();
  }

  @override
  Future<List<Vegetable>> getVegetables() {
    return vegetableRepository.getAll();
  }
}