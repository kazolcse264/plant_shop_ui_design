import 'package:flutter/material.dart';

import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../provider/plant_provider.dart';
import '../utils/color_pallet.dart';

class PlantDetail extends StatefulWidget {
  static const String routeName = '/plant_detail';
  final int id;

  const PlantDetail({super.key, required this.id});

  @override
  State<PlantDetail> createState() => _PlantDetailState();
}

class _PlantDetailState extends State<PlantDetail> {
  int currentIndex = 0;
  PageController pageController = PageController();
  bool isAddButtonClicked = false;

  late PlantProvider plantProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    plantProvider = Provider.of<PlantProvider>(context, listen: false);
  }

  addButtonHandler() {
    if (plantProvider.orderedPlantsId.contains(widget.id)) {
      plantProvider.numberOfOrdered[widget.id] =
          plantProvider.numberOfOrdered[widget.id]! + 1;
    } else {
      plantProvider.orderedPlantsId.add(widget.id);
      plantProvider.numberOfOrdered[widget.id] = 1;
    }
    setState(() {
      isAddButtonClicked = true;
    });
    Timer(const Duration(milliseconds: 150), () {
      setState(() {
        isAddButtonClicked = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            _buildCarousel(),
            _buildTilte(),
            Expanded(child: Container()),
            _buildBottom(),
          ],
        ));
  }

  _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          GestureDetector(
            onTap: () {
              plantProvider.calculateTotal();
              showDialog(
                context: context,
                builder: (context) => _buildOrderedPlantDialog(),
              );
            },
            child: Stack(children: [
              const Padding(
                padding:
                    EdgeInsets.only(right: 30.0, left: 10, bottom: 10, top: 10),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: ColorPallet.textColor,
                  size: 28,
                ),
              ),
              Visibility(
                visible: plantProvider.orderedPlantsId.isNotEmpty,
                child: Positioned(
                  bottom: 5,
                  right: 15,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: ColorPallet.foregroundColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                        child: Text(
                      plantProvider.orderedPlantsId.length.toString(),
                      style: const TextStyle(
                        color: ColorPallet.white,
                      ),
                    )),
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  _buildCarousel() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.45,
          child: PageView(
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            controller: pageController,
            children: [
              _buildSlide(plantProvider.plants[widget.id].images![0]),
              _buildSlide(plantProvider.plants[widget.id].images![0]),
              _buildSlide(plantProvider.plants[widget.id].images![0]),
            ],
          ),
        ),
        _buildCarouselBuillets(),
      ],
    );
  }

  _buildCarouselBuillets() {
    return Positioned(
      bottom: 50,
      right: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildBullet(0),
          _buildBullet(1),
          _buildBullet(2),
        ],
      ),
    );
  }

  _buildBullet(int bulletId) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 10),
      width: 8,
      height: currentIndex == bulletId ? 20 : 8,
      decoration: BoxDecoration(
        color: currentIndex == bulletId
            ? ColorPallet.foregroundColor
            : ColorPallet.textColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  _buildSlide(String path) {
    return Hero(
      tag: 'plant-${widget.id}',
      child: Image.asset(
        path,
        fit: BoxFit.contain,
        alignment: Alignment.bottomCenter,
      ),
    );
  }

  _buildTilte() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, top: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          plantProvider.plants[widget.id].name!,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 25,
              ),
        ),
        const SizedBox(height: 25),
        Text(
          plantProvider.plants[widget.id].description!,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 15,
              ),
        )
      ]),
    );
  }

  _buildBottom() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.27,
      decoration: const BoxDecoration(
        color: ColorPallet.foregroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPlantProperty(Icons.height, 'height',
                  plantProvider.plants[widget.id].heightRange!),
              _buildPlantProperty(Bootstrap.thermometer, 'Temprature',
                  plantProvider.plants[widget.id].temperatureRange!),
              _buildPlantProperty(
                  Icons.crib, 'Pot', plantProvider.plants[widget.id].pot!),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "Total Price",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: ColorPallet.white,
                        ),
                  ),
                  Text(
                    '\$${plantProvider.plants[widget.id].price}',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: ColorPallet.white,
                        ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: addButtonHandler,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: isAddButtonClicked == false ? 190 : 200,
                  height: isAddButtonClicked == false ? 75 : 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF67864A),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: Text(
                    'Add to Cart',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: ColorPallet.white,
                        ),
                  )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildPlantProperty(IconData icon, String titile, String desc) {
    return Column(
      children: [
        Icon(
          icon,
          size: 40,
          color: ColorPallet.white,
        ),
        const SizedBox(height: 5),
        Text(
          titile,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: ColorPallet.white,
                fontSize: 16,
              ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          desc,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: ColorPallet.white,
                fontSize: 12,
              ),
        ),
      ],
    );
  }

  Widget _buildOrderedPlantDialog() {
    return Consumer<PlantProvider>(
      builder: (context, provider, child) {
        //provider.calculateTotal();
        return AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            GestureDetector(
              onTap: provider.orderButtonHandler,
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                width: 100,
                decoration: BoxDecoration(
                  color: ColorPallet.foregroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Order',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: ColorPallet.white,
                      ),
                ),
              ),
            ),
          ],
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < provider.numberOfOrdered.length; i++)
                Visibility(
                  visible:
                      provider.numberOfOrdered[provider.orderedPlantsId[i]] !=
                          0,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(provider
                                .plants[provider.orderedPlantsId[i]].name!),
                            Text(
                                '\$${provider.plants[provider.orderedPlantsId[i]].price}'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                provider.numberOfOrdered[
                                        provider.orderedPlantsId[i]] =
                                    provider.numberOfOrdered[
                                            provider.orderedPlantsId[i]]! +
                                        1;
                                provider.calculateTotal();
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: ColorPallet.foregroundColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    '+',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: ColorPallet.white,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            GestureDetector(
                              onTap: () {
                                provider.numberOfOrdered[
                                        provider.orderedPlantsId[i]] =
                                    provider.numberOfOrdered[
                                            provider.orderedPlantsId[i]]! -
                                        1;
                                provider.calculateTotal();
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    '-',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                                'X${provider.numberOfOrdered[provider.orderedPlantsId[i]]}'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              const Divider(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '\$${provider.totalPrice}',
                    style: Theme.of(context).textTheme.displayMedium,
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}
