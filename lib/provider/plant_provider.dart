import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../models/plants.dart';

class PlantProvider extends ChangeNotifier{
  List<Plant> plants = [];
List orderedPlantsId = [];
Map numberOfOrdered = {};
double totalPrice = 0.0;
  String generatedTransactionRef = '';
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

  calculateTotal() {
    totalPrice = 0;
    for (int i = 0; i < orderedPlantsId.length; i++) {
      totalPrice = totalPrice +
          (plants[orderedPlantsId[i]].price! *
              numberOfOrdered[orderedPlantsId[i]]);
    }
    notifyListeners();
  }

  orderButtonHandler() async {
    generateTransactionReference();
    if (totalPrice> 0) {
      var headers = {
        'Authorization': 'Bearer CHASECK_TEST-7wwIlZaztz8Bcbzb84qrbCRQEu1Tbvb1',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'POST', Uri.parse('https://api.chapa.co/v1/transaction/initialize'));
      request.body = json.encode({
        "amount": "$totalPrice",
        "email": "mikiyaass@gmail.com",
        "currency": "USD",
        "phone_number": "0900123456",
        "tx_ref": generatedTransactionRef,
        "customization[title]": "Payment for Plant(s)",
        "customization[description]": "I love online payments"
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map res = jsonDecode(await response.stream.bytesToString());
        String urlPayment = res['data']['checkout_url'];
        await launchUrl(Uri.parse(urlPayment));
        if (kDebugMode) {
          print('generatedRef: $generatedTransactionRef');
        }
        //Get.back();
       numberOfOrdered = {};
       orderedPlantsId = [];
       notifyListeners();
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    }
  }
  generateTransactionReference() {
    DateTime now = DateTime.now();
    Random random = Random();
    int randomNumber = random.nextInt(10000);
    String transactionReference =
        '${now.year}${now.month}${now.day}-${now.hour}${now.minute}${now.second}-$randomNumber';
    generatedTransactionRef = transactionReference;
  }
}