import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:plant_shop_ui_design/utils/color_pallet.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  PageController pageController = PageController();
  int currentSlideIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(10),
              child: TextButton(
                onPressed: (){},
                child: Text(
                  'Skip',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            _buildCarousel(),
            _buildCarouselBullets(),
            _buildMotto(),
            _buildArrowButton(),
          ],
        ));
  }

  _buildCarousel() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 420,
        child: PageView(
          onPageChanged: (index) {
            setState(() {
              currentSlideIndex = index;
            });
          },
          controller: pageController,
          physics: const BouncingScrollPhysics(),
          children: [
            _buildSlide('assets/plants/plant_1.png'),
            _buildSlide('assets/plants/plant_6.png'),
            _buildSlide('assets/plants/plant_7.png'),
          ],
        ),
      ),
    );
  }

  _buildSlide(String path) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(path),
        ),
      ),
    );
  }

  _buildCarouselBullets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildBullet(0),
        _buildBullet(1),
        _buildBullet(2),
      ],
    );
  }

  _buildBullet(int bulletId) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 10),
      width: currentSlideIndex == bulletId ? 20 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: currentSlideIndex == bulletId
            ? ColorPallet.foregroundColor
            : ColorPallet.textColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  _buildMotto() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 30),
      child: RichText(
        text: TextSpan(
            text: 'Enjoy your\nLife with',
            children: const [
              TextSpan(
                text: ' Plants',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
            style: Theme.of(context).textTheme.displayLarge),
      ),
    );
  }

  _buildArrowButton() {
    return GestureDetector(
      onTap: (){},
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: ColorPallet.foregroundColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(
          Bootstrap.arrow_right,
          color: ColorPallet.backgroundColor,
          size: 45,
        ),
      ),
    );
  }
}
