import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:space_farm/data/entities/vegetable.dart';

abstract class VegetableRepository{
  Future<List<Vegetable>> getAll();
}

class VegetableRepositoryImplementation implements VegetableRepository{
  
  @override
  Future<List<Vegetable>> getAll() async {
    final response = await FirebaseFirestore.instance.collection('vegetable').get();
    return response.docs.map((e) => Vegetable.fromJson(e.data())).toList();
  }

}