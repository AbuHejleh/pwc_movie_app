import 'package:flutter/material.dart';
import 'package:pwc_movie/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      onGenerateRoute: AppRouter().generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
