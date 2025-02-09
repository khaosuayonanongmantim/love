import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_new/Payment/PaymentProductPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  late ScrollController _scrollController;
  late Timer _timer;
  int _currentIndex = 0;
  String selectedCategory = 'Flash Sales'; // Default category
  String selectedType = 'CONCERT'; // Default type (CONCERT or SPORT)
  Map<int, bool> _favorites = {}; // Map to track favorite items
  Map<int, int> _itemCounts = {}; // Map to track item quantities
  int favoriteCount = 0; // ตัวแปรนับจำนวนสินค้าที่กด Favorite
  List<dynamic> _ProductImages = [];
  List<dynamic>  _Flashsale = [];
  bool _isLoading = true;

  
  
  
  @override
  void initState() {
    super.initState();
  fetchProductImages();
  fetchFlashsale();
 _scrollController = ScrollController();

  


    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_currentIndex < 2) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _scrollController.animateTo(
        _currentIndex * 378.0,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

    Future<void> fetchProductImages() async {
     try {
      final response = await http.get(Uri.parse('http://192.168.144.137:5000/getAllProduct'));
      if (response.statusCode == 200) {
        setState(() {
          _ProductImages = jsonDecode(response.body);
          _isLoading = false;
        });

      } else {
        print('Failed to load concerts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching concerts: $e');
    }
  }

    Future<void> fetchFlashsale() async {
     try {
      final response = await http.get(Uri.parse('http://192.168.144.137:5000/getAllflashsale'));
      if (response.statusCode == 200) {
        setState(() {
          _Flashsale = jsonDecode(response.body);
          _isLoading = false;
        });

      } else {
        print('Failed to load concerts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching concerts: $e');
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
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
          Stack(
            children: [
              Icon(Icons.favorite, color: Colors.pink[50], size: 28),
              if (favoriteCount > 0) // แสดงเฉพาะเมื่อ favoriteCount > 0
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$favoriteCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 8),
          Icon(Icons.shopping_cart, color: Colors.white, size: 28),
                    
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

                    children: _ProductImages.map((ProductImages){
                        return _buildFeaturedProduct(
                          ProductImages['image'] ?? 'assets/default.jpg',
                        );

                    }).toList(),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTypeButton('CONCERT', const Color.fromARGB(255, 243, 33, 163)),
                    SizedBox(width: 40),
                    _buildTypeButton('SPORT', const Color.fromARGB(255, 76, 127, 175)),
                  ],
                ),

                // Circular images with text for categories based on selected type
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: selectedType == 'CONCERT'
                        ? _buildConcertCategories()
                        : _buildSportCategories(),
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
      String imageUrl = "http://192.168.144.137/product/$imagePath";
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
  child: Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: imageUrl.startsWith('http')
            ? NetworkImage(imageUrl) // โหลดจาก URL
            : AssetImage(imageUrl) as ImageProvider, // โหลดจาก assets
        fit: BoxFit.cover,
      ),
    ),
  ),
),

      ),
    );
  }


  Widget _buildTypeButton(String type, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedType = type;
          selectedCategory = 'Flash Sales';
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          type,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildConcertCategories() {
    return [
      _buildCircularImageWithText('assets/shop.png', 'Flash Sales'),
      _buildCircularImageWithText('assets/key5.jpg', 'Shirt'),
      _buildCircularImageWithText('assets/bts6.jpg', 'Light Stick'),
      _buildCircularImageWithText('assets/order9.jpg', 'Album'),
    ];
  }

  List<Widget> _buildSportCategories() {
    return [
      _buildCircularImageWithText('assets/sport1.jpg', 'Flash Sales'),
      _buildCircularImageWithText('assets/sport2.jpg', 'Shirt'),
      _buildCircularImageWithText('assets/sport3.jpg', 'Scarf'),
      _buildCircularImageWithText('assets/sports4.jpg', 'Shoes'),
    ];
  }

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
    
    if (selectedType == 'CONCERT') {
       if (selectedCategory == 'Flash Sales') {
       items = _Flashsale.map<Map<String, String>>((Flashsale) => {
       'image': Flashsale['image'] ?? '', // ตรวจสอบว่ามีค่า
        'title': Flashsale['name'] ?? 'No Title',
        'oldPrice': Flashsale['oldPrice'] != null ? '\$${Flashsale['oldPrice']}' : '\$0',
        'newPrice': Flashsale['price'] != null ? '\$${Flashsale['price']}' : '\$0',
    }).toList();

    } else if (selectedCategory == 'Shirt') {
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
    } else if (selectedCategory == 'Light Stick') {
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
    } else if (selectedCategory == 'Album') {
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
      // Add other categories for CONCERT if needed
    } else if (selectedType == 'SPORT') {
       if (selectedCategory == 'Flash Sales') {
      items = [
        {
          'image': 'assets/key2.jpg',
          'title': 'Key Item 1',
          'oldPrice': '\$50.00',
          'newPrice': '\$40.00'
        },
      ];
    } else if (selectedCategory == 'Shirt') {
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
      ];
    } else if (selectedCategory == 'Scarf') {
      items = [
        {
          'image': 'assets/bts3.jpg',
          'title': 'BTS Item 1',
          'oldPrice': '\$35.00',
          'newPrice': '\$25.00'
        },
      ];
    } else if (selectedCategory == 'Shoes') {
      items = [
        {
          'image': 'assets/order1.jpg',
          'title': 'Order Item 1',
          'oldPrice': '\$70.00',
          'newPrice': '\$60.00'
        },
      ];
    }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          GridView.builder(
  physics: NeverScrollableScrollPhysics(),
  shrinkWrap: true,
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 16.0,
    mainAxisSpacing: 16.0,
    childAspectRatio: 0.7,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) {
    final isFavorite = _favorites[index] ?? false;
    final itemCount = _itemCounts[index] ?? 0; // ค่าเริ่มต้นจำนวนสินค้าเป็น 0

    return Container(
        height: 400, // ปรับความสูงของ Container
        width: double.infinity, // ขยายเต็มความกว้าง
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 245, 214, 238),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white, width: 2),
      ),
      
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            items[index]['image']!,
           
            width: double.infinity, // ขยายให้เต็มความกว้าง
            fit: BoxFit.cover, // ปรับให้รูปภาพครอบคลุมพื้นที่
          ),
        ),
      ),
          const SizedBox(height: 8),

          // ชื่อสินค้า
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Text(
              items[index]['title']!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
               
              ),
            ),
          ),

          // ราคาสินค้า + ปุ่ม Favorite
          
   Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Flexible(
      child: Text.rich(
        TextSpan(
          text: items[index]['oldPrice']!,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ),
          children: [
            TextSpan(
              text: ' ${items[index]['newPrice']}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.red,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    ),
    Row(
      children: [
        IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _favorites[index] = !isFavorite;
              if (_favorites[index] == true) {
                favoriteCount++;
              } else {
                favoriteCount--;
              }
            });
          },
        ),
        SizedBox(width: 8), // ระยะห่างระหว่างไอคอน
        IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.blue,
          ),
          onPressed: () {
            // Action สำหรับ Shopping Cart
          },
        ),
      ],
    ),
  ],
),

          

          // ปุ่มเพิ่ม/ลดจำนวนสินค้า
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove, color: Colors.red),
                onPressed: () {
                  setState(() {
                    if (itemCount > 0) {
                      _itemCounts[index] = itemCount - 1;
                    }
                  });
                },
              ),
              Text(
                '$itemCount',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
                           IconButton(
                icon: Icon(Icons.add, color: Colors.green),
                onPressed: () {
                  setState(() {
                    _itemCounts[index] = itemCount + 1;
                  
                  });

                  

                  
                  
                },
              ),
            ],
          ),
        ],
      ),
      
    );
  },
),
             const SizedBox(height: 20),

        // ปุ่ม Confirm Payment
        ElevatedButton(
          onPressed: () {
            // ตัวอย่าง: แสดงข้อความยืนยัน หรือไปยังหน้าถัดไป
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentProductPage(
                  itemCounts: _itemCounts,
                  items: items,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
            backgroundColor: Colors.pinkAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            'Confirm Payment',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
}