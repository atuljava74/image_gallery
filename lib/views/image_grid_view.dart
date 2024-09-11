import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import the cached network image package
import '../animation/fade_route.dart';
import '../models/image_model.dart';
import '../providers/image_provider.dart';
import 'full_screen_view.dart';

class ImageGridView extends StatefulWidget {
  const ImageGridView({Key? key}) : super(key: key);

  @override
  _ImageGridViewState createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Add listener to the ScrollController
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        final imageProvider = Provider.of<PixabayImageProvider>(context, listen: false);
        if (!imageProvider.isLoading) {
          imageProvider.loadMore();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Determine which URL to use based on platform and screen size
  String getImageUrl(BuildContext context, ImageModel image) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (kIsWeb) {
      // Web logic
      if (screenWidth < 600) {
        return image.previewURL; // For small web screens
      } else {
        return image.largeImageURL; // For larger web screens
      }
    } else if (Platform.isAndroid || Platform.isIOS) {
      // Mobile logic
      if (screenWidth < 600) {
        return image.previewURL; // Small mobile screens
      } else {
        return image.webformatURL; // Larger mobile screens
      }
    }
    return image.previewURL; // Fallback
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<PixabayImageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png', // Your logo from assets
              height: 40,
            ),
            const SizedBox(width: 10),
            const Text(
              'Image Gallery',
              style: TextStyle(
                fontFamily: 'Cursive', // Customize your font here
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                imageProvider.setQuery(value); // Update query and fetch images
              },
              decoration: InputDecoration(
                hintText: 'Search Images...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              controller: _scrollController, // Assign the ScrollController
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: imageProvider.images.length,
              itemBuilder: (context, index) {
                final image = imageProvider.images[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      FadePageRoute(
                        page: FullScreenImageView(image: image),
                      ),
                    );
                  },
                  child: GridTile(
                    footer: GridTileBar(
                      backgroundColor: Colors.black45,
                      title: Text('${image.likes} likes'),
                      subtitle: Text('${image.views} views'),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: getImageUrl(context, image),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
