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
  List<dynamic> _Flashsale = [];
  List<dynamic> _Shirt = [];
  List<dynamic> _Lightstick = [];
  List<dynamic> _Albumcon = [];
  List<dynamic> _FlashsaleSport = [];
  List<dynamic> _Shirtsport = [];
  List<dynamic> _Scarfsport = [];
  List<dynamic> _Shoesport = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProductImages();
    fetchFlashsale();
    fetchShirt();
    fetchLightstick();
    fetchAlbumcon();
    fetchFlashsaleSport();
    fetchShirtsport();
    fetchScarfsport();
    fetchShoesport();
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
      _buildCircularImageWithText('assets/sport1.jpg', 'FlashSp'),
      _buildCircularImageWithText('assets/sport2.jpg', 'ShirtSp'),
      _buildCircularImageWithText('assets/sport3.jpg', 'Scarf'),
      _buildCircularImageWithText('assets/sports4.jpg', 'Shoes'),
    ];
  }

  Future<void> fetchProductImages() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.55.228:5000/getAllProduct'));
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
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/getAllflashsale'));
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

  Future<void> fetchShirt() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/getAllshirtcon'));
      if (response.statusCode == 200) {
        setState(() {
          _Shirt = jsonDecode(response.body); // บันทึกข้อมูลเสื้อ
          _isLoading = false;
        });
      } else {
        print('Failed to load shirts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching shirts: $e');
    }
  }

  Future<void> fetchLightstick() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/getAllligthstickcon'));
      if (response.statusCode == 200) {
        setState(() {
          _Lightstick = jsonDecode(response.body); // แปลง JSON เป็น List
          _isLoading = false;
        });
      } else {
        print('Failed to load events: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching events: $e');
    }
  }

  Future<void> fetchAlbumcon() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/getAllalbumcon'));
      if (response.statusCode == 200) {
        setState(() {
          _Albumcon = jsonDecode(response.body); // บันทึกข้อมูลเสื้อ
          _isLoading = false;
        });
      } else {
        print('Failed to load shirts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching shirts: $e');
    }
  }

  Future<void> fetchFlashsaleSport() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/getAllflashsaleSport'));
      if (response.statusCode == 200) {
        setState(() {
          _FlashsaleSport = jsonDecode(response.body); // บันทึกข้อมูลเสื้อ
          _isLoading = false;
        });
      } else {
        print('Failed to load shirts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching shirts: $e');
    }
  }

  Future<void> fetchShirtsport() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/getAllshirtsport'));
      if (response.statusCode == 200) {
        setState(() {
          _Shirtsport = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        print('Failed to load shirts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching shirts: $e');
    }
  }

  Future<void> fetchScarfsport() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/getAllscarfsport'));
      if (response.statusCode == 200) {
        setState(() {
          _Scarfsport = jsonDecode(response.body); // บันทึกข้อมูลเสื้อ
          _isLoading = false;
        });
      } else {
        print('Failed to load shirts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching shirts: $e');
    }
  }
  Future<void> fetchShoesport() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/getAllshoesport'));
      if (response.statusCode == 200) {
        setState(() {
          _Shoesport = jsonDecode(response.body); // บันทึกข้อมูลเสื้อ
          _isLoading = false;
        });
      } else {
        print('Failed to load shirts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching shirts: $e');
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
                              Icon(Icons.favorite,
                                  color: Colors.pink[50], size: 28),
                              if (favoriteCount >
                                  0) // แสดงเฉพาะเมื่อ favoriteCount > 0
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
                    children: _ProductImages.map((ProductImages) {
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
                    _buildTypeButton(
                        'CONCERT', const Color.fromARGB(255, 243, 33, 163)),
                    SizedBox(width: 40),
                    _buildTypeButton(
                        'SPORT', const Color.fromARGB(255, 76, 127, 175)),
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
    String imageUrl = "http://192.168.55.228/product/$imagePath";
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
              'image': Flashsale['image'] ?? '',
              'title': Flashsale['name'] ?? 'No Title',
              'oldPrice': Flashsale['oldPrice'] != null
                  ? '\$${Flashsale['oldPrice']}'
                  : '\$0',
              'newPrice': Flashsale['price'] != null
                  ? '\$${Flashsale['price']}'
                  : '\$0',
            }).toList();
      } else if (selectedCategory == 'Shirt') {
        items = _Shirt.map<Map<String, String>>((Shirt) => {
              'image': Shirt['image'] ?? '',
              'title': Shirt['name'] ?? 'No Title',
              'oldPrice':
                  Shirt['oldPrice'] != null ? '\$${Shirt['oldPrice']}' : '\$0',
              'newPrice':
                  Shirt['price'] != null ? '\$${Shirt['price']}' : '\$0',
            }).toList();
      } else if (selectedCategory == 'Light Stick') {
        items = _Lightstick.map<Map<String, String>>((Lightstick) => {
              'image': Lightstick['image'] ?? '',
              'title': Lightstick['name'] ?? 'No Title',
              'oldPrice': Lightstick['oldPrice'] != null
                  ? '\$${Lightstick['oldPrice']}'
                  : '\$0',
              'newPrice': Lightstick['price'] != null
                  ? '\$${Lightstick['price']}'
                  : '\$0',
            }).toList();
      } else if (selectedCategory == 'Album') {
        items = _Albumcon.map<Map<String, String>>((Album) => {
              'image': Album['image'] ?? '',
              'title': Album['name'] ?? 'No Title',
              'oldPrice':
                  Album['oldPrice'] != null ? '\$${Album['oldPrice']}' : '\$0',
              'newPrice':
                  Album['price'] != null ? '\$${Album['price']}' : '\$0',
            }).toList();
      }
      // Add other categories for CONCERT if needed
    } else if (selectedType == 'SPORT') {
      if (selectedCategory == 'FlashSp') {
        items = _FlashsaleSport.map<Map<String, String>>((FlashsaleSport) => {
              'image': FlashsaleSport['image'] ?? '',
              'title': FlashsaleSport['name'] ?? 'No Title',
              'oldPrice': FlashsaleSport['oldPrice'] != null
                  ? '\$${FlashsaleSport['oldPrice']}'
                  : '\$0',
              'newPrice': FlashsaleSport['price'] != null
                  ? '\$${FlashsaleSport['price']}'
                  : '\$0',
            }).toList();
      } else if (selectedCategory == 'Shirtsp') {
        items = _Shirtsport.map<Map<String, String>>((Shirtsp) => {
              'image': Shirtsp['image'] ?? '',
              'title': Shirtsp['name'] ?? 'No Title',
              'oldPrice': Shirtsp['oldPrice'] != null
                  ? '\$${Shirtsp['oldPrice']}'
                  : '\$0',
              'newPrice':
                  Shirtsp['price'] != null ? '\$${Shirtsp['price']}' : '\$0',
            }).toList();
      } else if (selectedCategory == 'Scarf') {
        items = _Scarfsport.map<Map<String, String>>((Scarf) => {
              'image': Scarf['image'] ?? '',
              'title': Scarf['name'] ?? 'No Title',
              'oldPrice':
                  Scarf['oldPrice'] != null ? '\$${Scarf['oldPrice']}' : '\$0',
              'newPrice':
                  Scarf['price'] != null ? '\$${Scarf['price']}' : '\$0',
            }).toList();
      } else if (selectedCategory == 'Shoes') {
         items = _Shoesport.map<Map<String, String>>((Shoes) => {
              'image': Shoes['image'] ?? '',
              'title': Shoes['name'] ?? 'No Title',
              'oldPrice':
                  Shoes['oldPrice'] != null ? '\$${Shoes['oldPrice']}' : '\$0',
              'newPrice':
                  Shoes['price'] != null ? '\$${Shoes['price']}' : '\$0',
            }).toList();
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
              final itemCount =
                  _itemCounts[index] ?? 0; // ค่าเริ่มต้นจำนวนสินค้าเป็น 0

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
                          child: Image.network(
                            selectedType == 'CONCERT'
                                ? selectedCategory == 'Shirt'
                                    ? 'http://192.168.55.228/product/shirtconpro/' + (items[index]['image'] ?? 'default_image.jpg')
                                    : selectedCategory == 'Light Stick'
                                        ? 'http://192.168.55.228/product/lightstick/' + (items[index]['image'] ?? 'default_image.jpg')
                                        : selectedCategory == 'Album'
                                            ? 'http://192.168.55.228/product/album/' + (items[index]['image'] ?? 'default_image.jpg')
                                            : 'http://192.168.55.228/product/flash/'+ (items[index]['image'] ?? 'default_image.jpg')
                                : selectedType == 'SPORT'
                                    ? selectedCategory == 'FlashSp'
                                        ? 'http://192.168.55.228/product/fs/'+ (items[index]['image'] ?? 'default_image.jpg')
                                        : selectedCategory == 'Shirtsp'
                                            ? 'http://192.168.55.228/product/shirtsport/'+ (items[index]['image'] ?? 'default_image.jpg')
                                            : selectedCategory == 'Scarf'
                                                ? 'http://192.168.55.228/product/scarf/'+ (items[index]['image'] ?? 'default_image.jpg')
                                                : selectedCategory == 'Shoes'
                                                 ? 'http://192.168.55.228/product/shoe/'+ (items[index]['image'] ?? 'default_image.jpg')
                                                : 'http://via.placeholder.com/150'
                                    : 'http://via.placeholder.com/150', // รูปสำรอง// ค่าเริ่มต้นกรณีไม่ตรงกับหมวดหมู่ที่กำหนด

                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                  'http://via.placeholder.com/150'); // ใช้รูปแทนถ้าโหลดไม่ได้
                            },
                          )),
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
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
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
