import 'package:ayurseva/controller/login_provider.dart';
import 'package:ayurseva/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (ctx)=>LoginProvider())],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AyurSeva',
      routes: routes,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white
      )
    );
  }
}
