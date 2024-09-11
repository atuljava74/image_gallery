import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/image_provider.dart';
import 'views/image_grid_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PixabayImageProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageGridView(),
    );
  }
}
