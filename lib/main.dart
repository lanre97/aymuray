import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'presentation/app.dart';
import 'presentation/widgets/button_plant.dart';
import 'presentation/widgets/selector_crop.dart';

void main() {
  Firebase.initializeApp();
  runApp(MyApp());
}




