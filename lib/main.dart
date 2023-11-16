import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_shop_ui_design/pages/intro.dart';
import 'package:plant_shop_ui_design/provider/plant_provider.dart';
import 'package:plant_shop_ui_design/router.dart';
import 'package:plant_shop_ui_design/utils/color_pallet.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlantProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant Shop UI Design',
      theme: _buildThemeData(),
      initialRoute: Intro.routeName,
      onGenerateRoute: (settings) {
        return AppRouter.generateRoute(settings);
      },
      //home: const Intro(),
    );
  }

  _buildThemeData() {
    return ThemeData(
      scaffoldBackgroundColor: ColorPallet.backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorPallet.backgroundColor,
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorPallet.backgroundColor,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.montserrat(
          color: ColorPallet.textColor,
          fontSize: 40,
        ),
        displayMedium: GoogleFonts.montserrat(
          color: ColorPallet.textColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        titleMedium: GoogleFonts.montserrat(
          color: ColorPallet.textColor,
          fontSize: 19,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: GoogleFonts.montserrat(
          color: ColorPallet.textColor.withOpacity(0.8),
        ),
      ),
      iconTheme: const IconThemeData(
        color: ColorPallet.textColor,
      ),
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(ColorPallet.textColor),
        ),
      ),
    );
  }
}
