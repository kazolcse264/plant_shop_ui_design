import 'package:flutter/cupertino.dart';

import '../models/plants.dart';

class PlantProvider extends ChangeNotifier{
  List<Plant> plants = [];
/*  RxList orderedPlantsId = [].obs;
  RxMap numberOfOrdered = {}.obs;
  RxDouble totalPrice = 0.0.obs;*/

  void initPlants()  {

    for (int i = 0; i < plantsList.length; i++) {
      Plant plant = Plant(
        id: i,
        name: plantsList[i]["name"],
        description: plantsList[i]['description'],
        heightRange: plantsList[i]['heightRange'],
        temperatureRange: plantsList[i]['temperatureRange'],
        price: plantsList[i]['price'],
        images: plantsList[i]['images'],
        isFavorite: false,
        pot: plantsList[i].containsKey('pot')
            ? plantsList[i]['pot']
            : 'Ciramic Pot',
        smallDescription: plantsList[i].containsKey('smallDescription')
            ? plantsList[i]['smallDescription']
            : '',
      );
      plants.add(plant);

    }
  }

}