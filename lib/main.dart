import 'package:flutter/material.dart';
import 'package:folder_structure_sample_april/controller/home_screen_controller.dart';
import 'package:folder_structure_sample_april/view/get_started_screen/get_started_screen.dart';
import 'package:provider/provider.dart';

void main() {
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
        )
      ],
      child: MaterialApp(
        home: GetStartedScreen(),
      ),
    );
  }
}
