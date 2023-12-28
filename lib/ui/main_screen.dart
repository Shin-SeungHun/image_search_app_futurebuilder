import 'package:flutter/material.dart';
import 'package:image_search_app_futurebuilder/data/model/image_item.dart';
import 'package:image_search_app_futurebuilder/data/repository/pixabay_image_item_repository.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController searchTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              TextField(
                onChanged: (query) {
                  setState(() {});
                },
                controller: searchTextEditingController,
                decoration: InputDecoration(
                  labelText: '검색',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.cyan,
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FutureBuilder<List<ImageItem>>(
                  future: PixabayImageItemRepository()
                      .getImageItems(searchTextEditingController.text),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    final List<ImageItem> imageItems = snapshot.data!;
                    return Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 32,
                            mainAxisSpacing: 32,
                          ),
                          itemCount: imageItems.length,
                          itemBuilder: (context, index) {
                            final ImageItem imageItem = imageItems[index];
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(
                                imageItem.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            );
                          }),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
