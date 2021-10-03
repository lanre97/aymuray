import 'package:space_farm/data/entities/vegetable.dart';

abstract class VegetableRepository{
  Future<List<Vegetable>> getAll();
}

class VegetableRepositoryImplementation implements VegetableRepository{
  @override
  Future<List<Vegetable>> getAll() {
    throw UnimplementedError();
  }

}