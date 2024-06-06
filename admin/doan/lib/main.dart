
// import 'package:doan/customeThemes.dart';
import 'package:doan/firebase_options.dart';
import 'package:doan/mainpage.dart';
import 'package:doan/model/provider/themeNotifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Khởi tạo Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(), // Tạo một ThemeNotifier provider
      child: const MainApp(),
    ),
  );

  
}


class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeNotifier>(context).currentTheme,
      // theme: CustomThemes.lightTheme,
      // darkTheme: CustomThemes.darkTheme,
      title: 'Flutter Admin',
      home: Mainpage(),
    );
  }
}
