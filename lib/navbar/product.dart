import 'dart:async'; // สำหรับการใช้งาน Future และ Timer
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

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // ตั้ง Timer ให้เลื่อนไปยังภาพถัดไปทุกๆ 2 วินาที
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_currentIndex < 2) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _scrollController.animateTo(
        _currentIndex *
            378.0, // เลื่อนไปที่ภาพถัดไป (378 คือความกว้างของภาพ + padding)
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // ยกเลิก Timer เมื่อหน้าจอถูกปิด
    _scrollController.dispose(); // ยกเลิกการใช้งาน ScrollController
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(
                              'assets/sale6.png',
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 9),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(
                              'assets/sale5.png',
                              height: 40,
                              fit: BoxFit.cover,
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
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'ꜰᴇᴀᴛᴜʀᴇᴅ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ᴅᴏʟʟ  ᴋᴇʏᴄʜᴀɪɴ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        /* onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailCon()),);
                }, */
                        child: Text(
                          "ᴀʟʟ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(
                              'assets/key1.jpg',
                              height: 170,
                              width: 360,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildKeyProduct(
                          'assets/key2.jpg', 'Bear Plush', '\$500', '\$125'),
                      _buildKeyProduct(
                          'assets/key3.jpg', 'Bunny Plush', '\$500', '\$130'),
                      _buildKeyProduct(
                          'assets/key4.jpg', 'Cat Plush', '\$500', '\$122'),
                    ],
                  ),
                ),
               const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ᴛ-ꜱʜɪʀᴛ ʙᴛꜱ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        /* onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailCon()),);
                }, */
                        child: Text(
                          "ᴀʟʟ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(
                              'assets/bts5.jpg',
                              height: 180,
                              width: 360,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildKeyProduct(
                          'assets/bts1.jpg', 'Bear Plush', '\$800', '\$525'),
                      _buildKeyProduct(
                          'assets/bts4.jpg', 'Bunny Plush', '\$800', '\$530'),
                      _buildKeyProduct(
                          'assets/bts2.jpg', 'Cat Plush', '\$800', '\$522'),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ᴍᴜꜱɪᴄ ᴀʟʙᴜᴍ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        /* onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailCon()),);
                }, */
                        child: Text(
                          "ᴀʟʟ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(
                              'assets/order.jpg',
                              height: 180,
                              width: 360,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildKeyProduct(
                          'assets/order7.jpg', 'Bear Plush', '\$1800', '\$1525'),
                      _buildKeyProduct(
                          'assets/order6.jpg', 'Bunny Plush', '\$1800', '\$1530'),
                      _buildKeyProduct(
                          'assets/order8.jpg', 'Cat Plush', '\$1800', '\$1522'),
                    ],
                  ),
                ),
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
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
        ),
      ),
    );
  }

  Widget _buildKeyProduct(String imagePath, String name, String originalPrice,
      String discountedPrice) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 150,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: 120,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        originalPrice,
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        discountedPrice,
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
