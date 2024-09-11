import 'package:flutter/material.dart';

class FullScreenView extends StatelessWidget {
  final String imageUrl;

  FullScreenView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: imageUrl,
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: 40.0,
            right: 20.0,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}

/*
slid in animation

import 'package:flutter/material.dart';

class FullScreenView extends StatelessWidget {
  final String imageUrl;

  FullScreenView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: imageUrl,
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: 40.0,
            right: 20.0,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
*/
