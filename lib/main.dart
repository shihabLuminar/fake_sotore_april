import 'package:flutter/material.dart';
import 'package:folder_structure_sample_april/controller/home_screen_controller.dart';
import 'package:folder_structure_sample_april/controller/product_details_screen_controller.dart';
import 'package:folder_structure_sample_april/model/cart_screen_model/cart_model.dart';
import 'package:folder_structure_sample_april/view/get_started_screen/get_started_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CartModelAdapter());
  var box = await Hive.openBox<CartModel>("cartBox");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductDetailsScreenController(),
        )
      ],
      child: MaterialApp(
        home: GetStartedScreen(),
      ),
    );
  }
}
