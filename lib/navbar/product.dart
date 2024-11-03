import 'dart:async';
import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  late ScrollController _scrollController;
  late Timer _timer;
  int _currentIndex = 0;
  String selectedCategory = 'ALL'; // Default category
  Map<int, bool> _favorites = {}; // New Map to track favorite items

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Auto-scroll logic
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_currentIndex < 2) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _scrollController.animateTo(
        _currentIndex * 378.0, // Scroll to the next image
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the screen is disposed
    _scrollController.dispose(); // Dispose the ScrollController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFEECDA3), Color(0xFFEF629F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "ʙᴇꜱᴛ ᴘʀᴏᴅᴜᴄᴛꜱ",
                            style: TextStyle(
                              color: Color.fromARGB(255, 251, 64, 204),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.favorite,
                              color: Colors.pink[50], size: 28),
                          SizedBox(width: 8),
                          Icon(Icons.shopping_cart,
                              color: Colors.white, size: 28),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    children: [
                      _buildFeaturedProduct('assets/key.jpg'),
                      _buildFeaturedProduct('assets/bts.jpg'),
                      _buildFeaturedProduct('assets/order.jpg'),
                    ],
                  ),
                ),
                // Circular images with text for categories
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildCircularImageWithText('assets/shop.png', 'ALL'),
                      _buildCircularImageWithText('assets/key5.jpg', 'KEY'),
                      _buildCircularImageWithText('assets/bts6.jpg', 'SHIRT'),
                      _buildCircularImageWithText('assets/order9.jpg', 'ALBUM'),
                    ],
                  ),
                ),
                _buildCategoryContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedProduct(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 370,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              // Add a border or overlay here if desired
            ],
          ),
        ),
      ),
    );
  }

  // Circular images with clickable categories
  Widget _buildCircularImageWithText(String imagePath, String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 33,
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(height: 8),
          Text(
            category,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryContent() {
    List<Map<String, String>> items = [];
    if (selectedCategory == 'ALL') {
      items = [
        {
          'image': 'assets/key2.jpg',
          'title': 'Key Item 1',
          'oldPrice': '\$50.00',
          'newPrice': '\$40.00'
        },
        {
          'image': 'assets/key3.jpg',
          'title': 'Key Item 2',
          'oldPrice': '\$45.00',
          'newPrice': '\$35.00'
        },
        {
          'image': 'assets/key4.jpg',
          'title': 'Key Item 3',
          'oldPrice': '\$40.00',
          'newPrice': '\$30.00'
        },
        {
          'image': 'assets/key5.jpg',
          'title': 'Key Item 4',
          'oldPrice': '\$30.00',
          'newPrice': '\$20.00'
        },
        {
          'image': 'assets/bts3.jpg',
          'title': 'BTS Item 1',
          'oldPrice': '\$35.00',
          'newPrice': '\$25.00'
        },
        {
          'image': 'assets/bts4.jpg',
          'title': 'BTS Item 2',
          'oldPrice': '\$45.00',
          'newPrice': '\$35.00'
        },
        {
          'image': 'assets/bts5.jpg',
          'title': 'BTS Item 3',
          'oldPrice': '\$55.00',
          'newPrice': '\$45.00'
        },
        {
          'image': 'assets/bts6.jpg',
          'title': 'BTS Item 4',
          'oldPrice': '\$65.00',
          'newPrice': '\$55.00'
        },
        {
          'image': 'assets/order1.jpg',
          'title': 'Order Item 1',
          'oldPrice': '\$70.00',
          'newPrice': '\$60.00'
        },
        {
          'image': 'assets/order2.jpg',
          'title': 'Order Item 2',
          'oldPrice': '\$80.00',
          'newPrice': '\$70.00'
        },
        {
          'image': 'assets/order3.jpg',
          'title': 'Order Item 3',
          'oldPrice': '\$90.00',
          'newPrice': '\$80.00'
        },
        {
          'image': 'assets/order5.jpg',
          'title': 'Order Item 5',
          'oldPrice': '\$80.00',
          'newPrice': '\$70.00'
        },
        {
          'image': 'assets/order6.jpg',
          'title': 'Order Item 6',
          'oldPrice': '\$70.00',
          'newPrice': '\$60.00'
        },
        {
          'image': 'assets/order7.jpg',
          'title': 'Order Item 7',
          'oldPrice': '\$50.00',
          'newPrice': '\$40.00'
        },
        {
          'image': 'assets/order8.jpg',
          'title': 'Order Item 8',
          'oldPrice': '\$80.00',
          'newPrice': '\$50.00'
        },
        {
          'image': 'assets/order9.jpg',
          'title': 'Order Item 9',
          'oldPrice': '\$80.00',
          'newPrice': '\$60.00'
        },
      ];
    } else if (selectedCategory == 'KEY') {
      items = [
        {
          'image': 'assets/key2.jpg',
          'title': 'Key Item 1',
          'oldPrice': '\$50.00',
          'newPrice': '\$40.00'
        },
        {
          'image': 'assets/key3.jpg',
          'title': 'Key Item 2',
          'oldPrice': '\$45.00',
          'newPrice': '\$35.00'
        },
        {
          'image': 'assets/key4.jpg',
          'title': 'Key Item 3',
          'oldPrice': '\$40.00',
          'newPrice': '\$30.00'
        },
        {
          'image': 'assets/key5.jpg',
          'title': 'Key Item 4',
          'oldPrice': '\$30.00',
          'newPrice': '\$20.00'
        },
      ];
    } else if (selectedCategory == 'SHIRT') {
      items = [
        {
          'image': 'assets/bts3.jpg',
          'title': 'BTS Item 1',
          'oldPrice': '\$35.00',
          'newPrice': '\$25.00'
        },
        {
          'image': 'assets/bts4.jpg',
          'title': 'BTS Item 2',
          'oldPrice': '\$45.00',
          'newPrice': '\$35.00'
        },
        {
          'image': 'assets/bts5.jpg',
          'title': 'BTS Item 3',
          'oldPrice': '\$55.00',
          'newPrice': '\$45.00'
        },
        {
          'image': 'assets/bts6.jpg',
          'title': 'BTS Item 4',
          'oldPrice': '\$65.00',
          'newPrice': '\$55.00'
        },
      ];
    } else if (selectedCategory == 'ALBUM') {
      items = [
        {
          'image': 'assets/order1.jpg',
          'title': 'Order Item 1',
          'oldPrice': '\$70.00',
          'newPrice': '\$60.00'
        },
        {
          'image': 'assets/order2.jpg',
          'title': 'Order Item 2',
          'oldPrice': '\$80.00',
          'newPrice': '\$70.00'
        },
        {
          'image': 'assets/order3.jpg',
          'title': 'Order Item 3',
          'oldPrice': '\$90.00',
          'newPrice': '\$80.00'
        },
        {
          'image': 'assets/order5.jpg',
          'title': 'Order Item 5',
          'oldPrice': '\$80.00',
          'newPrice': '\$70.00'
        },
        {
          'image': 'assets/order6.jpg',
          'title': 'Order Item 6',
          'oldPrice': '\$70.00',
          'newPrice': '\$60.00'
        },
        {
          'image': 'assets/order7.jpg',
          'title': 'Order Item 7',
          'oldPrice': '\$50.00',
          'newPrice': '\$40.00'
        },
        {
          'image': 'assets/order8.jpg',
          'title': 'Order Item 8',
          'oldPrice': '\$80.00',
          'newPrice': '\$50.00'
        },
        {
          'image': 'assets/order9.jpg',
          'title': 'Order Item 9',
          'oldPrice': '\$80.00',
          'newPrice': '\$60.00'
        },
      ];
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (selectedCategory == 'ALL') ...[
            Text(
              'ꜱᴘᴇᴄɪᴀʟ ꜰᴏʀ ʏᴏᴜ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final isFavorite = _favorites[index] ?? false;

              return Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 245, 214, 238),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        items[index]['image']!,
                        height: 85,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            items[index]['title']!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Row(
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: items[index]['oldPrice']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey, // ขีดทิ้งเป็นสีเทา
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' ${items[index]['newPrice']}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.red,
                                        fontWeight: FontWeight
                                            .bold, // ราคาใหม่เป็นสีแดง
                                        decoration:
                                            TextDecoration.none, // ไม่มีขีดทิ้ง
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _favorites[index] =
                                        !isFavorite; // Toggle favorite status
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
