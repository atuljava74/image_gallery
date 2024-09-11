import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/image_provider.dart';
import 'full_screen_view.dart';

class ImageGridView extends StatefulWidget {
  @override
  _ImageGridViewState createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
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

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<PixabayImageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Set AppBar background to white
        elevation: 2.0,
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 40, // Adjust the height as needed for your logo
            ),
            SizedBox(width: 10),
            const Text(
              'Image Gallery',
              style: TextStyle(
                color: Colors.black, // Set text color to black
                fontFamily: 'Cursive', // Use a custom font family
                fontSize: 24, // Adjust the font size for a stylish look
              ),
            ),
          ],
        ),
        centerTitle: false, // Align title to the left
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Set background color of search bar
                borderRadius: BorderRadius.circular(30), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: TextField(
                onChanged: (query) {
                  imageProvider.setQuery(query);
                },
                decoration: InputDecoration(
                  hintText: 'Search images...',
                  hintStyle: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[600],
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey[700]),
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: imageProvider.isLoading && imageProvider.images.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            controller: _scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: imageProvider.images.length,
            itemBuilder: (context, index) {
              final image = imageProvider.images[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return FullScreenView(imageUrl: image.imageUrl);
                    },
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                ),
                child: Hero(
                  tag: image.imageUrl,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.network(
                            image.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(child: Icon(Icons.error));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Likes: ${image.likes}, Views: ${image.views}',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
