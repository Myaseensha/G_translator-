import 'package:flutter/material.dart';
import 'package:translator_clone/page/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.white;
                }
                return Colors.orange.shade900;
              },
            ),
          )),
          primaryColor: Colors.orange.shade900,
          iconTheme: IconThemeData(color: Colors.orange.shade900),
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(color: Colors.orange.shade900)),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
