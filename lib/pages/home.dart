import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:plant_shop_ui_design/pages/plant_detail.dart';
import 'package:plant_shop_ui_design/provider/plant_provider.dart';
import 'package:plant_shop_ui_design/utils/color_pallet.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const String routeName = "/home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PlantProvider plantProvider;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    plantProvider = Provider.of<PlantProvider>(context, listen: false);
    if (plantProvider.plants.isEmpty) {
      plantProvider.initPlants();

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        _buildAppBar(),
        _buildSearchBar(),
        _buildPlantDisplay(),
      ]),
    );
  }

  _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          Text(
            'Search Products',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const CircleAvatar(
            radius: 23,
            backgroundImage: AssetImage('assets/avatar_logo.png'),
          ),
        ],
      ),
    );
  }

  _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 50,
            decoration: BoxDecoration(
              color: ColorPallet.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              onChanged: (text) {},
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                fontSize: 16,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Icon(
                      BoxIcons.bx_search,
                      color: ColorPallet.textColor.withOpacity(0.5),
                      size: 23,
                    ),
                  )),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: ColorPallet.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              LineAwesome.sliders_h_solid,
              size: 30,
            ),
          )
        ],
      ),
    );
  }

  _buildPlantDisplay() {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  _buildPlantCard(id: 0),
                  _buildPlantCard(id: 1),
                  _buildPlantCard(id: 2),
                  _buildPlantCard(id: 6),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildPlantCard(id: 3),
                  _buildPlantCard(id: 4),
                  _buildPlantCard(id: 5),
                  _buildPlantCard(id: 7)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildPlantCard({required int id}) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Visibility(
        visible: id == 0,
        child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 10),
          child: Text(
            'Found\n10 Result',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
         Navigator.pushNamed(context, PlantDetail.routeName,arguments: id,);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          width: MediaQuery.of(context).size.width * 0.42,
          height: 300,
          decoration: BoxDecoration(
            color: ColorPallet.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 180,
                width: 200,
                child: Hero(
                  tag: 'plant-$id',
                  child: Image.asset(
                    plantProvider.plants[id].images![0],
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  plantProvider.plants[id].name!,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '\$${plantProvider.plants[id].price}',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    InkWell(
                      onTap: () {},
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: plantProvider.plants[id].isFavorite! ? 41.5 : 40,
                        height: plantProvider.plants[id].isFavorite! ? 41.5 : 40,
                        decoration: BoxDecoration(
                          color: plantProvider.plants[id].isFavorite!
                              ? ColorPallet.foregroundColor
                              : ColorPallet.iconBackground,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          IonIcons.heart,
                          color: ColorPallet.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }
}
