import 'dart:async';
import 'package:flutter/material.dart';

class Discount extends StatefulWidget {
  const Discount({super.key});

  @override
  _DiscountState createState() => _DiscountState();
}

class _DiscountState extends State<Discount> {
  late ScrollController _scrollController;
  late Timer _timer;
  int _currentIndex = 0;
  bool _isCouponClaimed = false; // New variable to track coupon state

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Auto-scroll logic
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_currentIndex < 3) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _scrollController.animateTo(
        _currentIndex * 378.0, // Scroll to the next image
        duration: Duration(seconds: 2),
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

  void _claimCoupon() {
    setState(() {
      _isCouponClaimed = true; // Mark coupon as claimed
    });
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
                  ),
                ),

                const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    children: [
                      _buildFeaturedProduct('assets/pop2.jpg'),
                      _buildFeaturedProduct('assets/pop1.jpg'),
                      _buildFeaturedProduct('assets/pop3.jpg'),
                    ],
                  ),
                ),
                // Circular images with text for categories
                Container(
                  margin: const EdgeInsets.only(
                    top: 20.0,
                    left: 10.0,
                    right: 10.0,
                    bottom: 15.0,
                  ),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFE91E63), // ชมพูเข้ม
                        Color(0xFFFFC1D6), // ชมพูอ่อน
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0), // โค้งมนเฉพาะมุมบนซ้าย
                      topRight: Radius.circular(20.0), // โค้งมนเฉพาะมุมบนขวา
                      bottomLeft: Radius.circular(0.0), // มุมล่างซ้ายตรง
                      bottomRight: Radius.circular(0.0), // มุมล่างขวาตรง
                    ),
                    border: Border.all(
                      // เพิ่มเส้นกรอบ
                      color: Colors.pink, // สีของเส้นกรอบ
                      width: 2, // ความหนาของเส้นกรอบ
                    ),
                  ),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // เพิ่มรูปภาพทางซ้ายของข้อความ
                        Image.asset(
                          'assets/cat.png',
                          width: 50, // ขนาดของรูปภาพ
                          height: 50,
                        ),
                        const SizedBox(
                            width: 10), // ช่องว่างระหว่างรูปภาพและข้อความ
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // จัดข้อความไปทางซ้าย
                          children: [
                            const Text(
                              'ลูกค้าใหม่',
                              style: TextStyle(
                                fontSize: 25.0, // ปรับขนาดข้อความ
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 233, 3, 80),
                              ),
                              textAlign: TextAlign.left, // จัดให้อยู่ซ้าย
                            ),
                            const SizedBox(height: 5), // ช่องว่างระหว่างข้อความ
                            const Text(
                              'สินค้าราคาพิเศษ + 🔖ส่วนลด 50%', // ข้อความใหม่
                              style: TextStyle(
                                fontSize: 18.0, // ขนาดข้อความเท่ากัน
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left, // จัดให้อยู่ซ้าย
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                //กรอบที่มีคูปองและโปรดักอยู่ข้างใน
                Container(
                  margin: const EdgeInsets.only(
                    top: 0.0,
                    left: 10.0,
                    right: 10.0,
                    bottom: 15.0,
                  ),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.pink[100],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0.0), // มุมบนซ้ายตรง
                      topRight: Radius.circular(0.0), // มุมบนขวาตรง
                      bottomLeft:
                          Radius.circular(20.0), // โค้งมนเฉพาะมุมล่างซ้าย
                      bottomRight:
                          Radius.circular(20.0), // โค้งมนเฉพาะมุมล่างขวา
                    ),
                    border: Border.all(
                      // เพิ่มเส้นกรอบ
                      color: Colors.pink, // สีของเส้นกรอบ
                      width: 2, // ความหนาของเส้นกรอบ
                    ),
                  ),
                  child: GestureDetector(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 5), // ช่องว่างระหว่างข้อความ
                        // กรอบส่วนลด
                        Container(
                          width: 350, // ความกว้างของกรอบ
                          height: 100, // ความสูงของกรอบ
                          decoration: BoxDecoration(
                            color: Colors.white, // กำหนดสีพื้นหลังเป็นสีขาว
                            borderRadius:
                                BorderRadius.circular(10), // ปรับรัศมีมุมกรอบ
                          ),
                          child: Row(
                            children: [
                              // ด้านซ้ายสีชมพู
                              Expanded(
                                flex: 4, // ปรับอัตราส่วนความกว้าง (30%)
                                child: Container(
                                  color: Colors.pink, // สีด้านซ้าย
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'ɪɴᴛᴇʀ', // ข้อความด้านซ้าย
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'ɢᴇᴛʜᴇʀ', // ข้อความด้านซ้าย
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // ด้านขวาสีขาว
                              Expanded(
                                flex: 6, // ปรับอัตราส่วนความกว้าง (70%)
                                child: Container(
                                  color: Colors.white, // สีด้านขวา
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '20% OFF', // ข้อความด้านบน
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'ซื้อครบ 49 บาท', // ข้อความด้านล่าง
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'ลดสูงสุด 150 บาท', // ข้อความด้านล่างสุด
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 3.0, // ระยะห่างจากด้านขวา
                                top: 30.0, // ปรับให้ตรงกลางตามแนวตั้ง
                                child: GestureDetector(
                                  onTap: _isCouponClaimed
                                      ? null
                                      : _claimCoupon, // คลิกเพื่อใช้คูปอง
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 5.0), // Padding ภายในกรอบ
                                    decoration: BoxDecoration(
                                      color: _isCouponClaimed
                                          ? Colors.blue
                                          : Colors.pink, // เปลี่ยนสีหากใช้แล้ว
                                      borderRadius: BorderRadius.circular(
                                          20), // กำหนดความโค้งมนของกรอบ
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey
                                              .withOpacity(0.3), // เงาเบาๆ
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: Offset(0, 3), // เงาไปด้านล่าง
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      _isCouponClaimed
                                          ? 'ใช้ทันที'
                                          : 'เก็บคูปอง', // ข้อความคูปอง
                                      style: TextStyle(
                                        color:
                                            Colors.white, // สีข้อความภายในกรอบ
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                            height: 10), // ช่องว่างระหว่างข้อความกับกรอบใหม่
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              buildImageWithText('assets/baby.jpg', 'Product 1',
                                  '\$30.00', '\$20.00'),
                              buildImageWithText('assets/baby1.jpg',
                                  'Product 2', '\$35.00', '\$25.00'),
                              buildImageWithText('assets/baby2.jpg',
                                  'Product 3', '\$40.00', '\$30.00'),
                              buildImageWithText('assets/baby3.jpg',
                                  'Product 4', '\$32.00', '\$22.00'),
                              buildImageWithText('assets/baby4.jpg',
                                  'Product 5', '\$38.00', '\$28.00'),
                              buildImageWithText('assets/baby5.jpg',
                                  'Product 6', '\$28.00', '\$18.00'),
                              buildImageWithText('assets/baby6.jpg',
                                  'Product 7', '\$25.00', '\$15.00'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Column(
                  children: [
                    const SizedBox(
                        height: 10), // ระยะห่างระหว่างข้อความกับรูปภาพ
                    Center(
                      // ใช้ Center widget เพื่อให้อยู่กลาง
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(20), // กำหนดความโค้งมนที่นี่
                        child: Image.asset(
                          'assets/promotion.jpg', // เส้นทางของรูปภาพของคุณ

                          fit: BoxFit.cover, // วิธีการปรับขนาดรูปภาพ
                        ),
                      ),
                    ),
                    const SizedBox(
                        height:
                            10), // ระยะห่างระหว่างรูปภาพหลักกับรูปภาพที่เพิ่ม
                    // รูปภาพ 4 รูป 2 ด้านบน 2 ด้านล่าง
                    Container(
                      width: 380, // ความกว้างของกรอบ
                      decoration: BoxDecoration(
                        color: Colors.white, // กำหนดสีพื้นหลังเป็นสีขาว
                        borderRadius:
                            BorderRadius.circular(10), // ปรับรัศมีมุมกรอบ
                      ),
                      child: Row(
                        children: [
                          // ด้านขวาสีขาว
                          Expanded(
                            flex: 6, // ปรับอัตราส่วนความกว้าง (70%)
                            child: Container(
                              color: Colors.white, // สีด้านขวา
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'เติมคูปอง ทุกเที่ยงคืน 00.00 น.',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 5.0), // Padding ภายในกรอบ
                                decoration: BoxDecoration(
                                  color: Colors.pink,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.3), // เงาเบาๆ
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 3), // เงาไปด้านล่าง
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'เงื่อนไขคูปอง',
                                  style: TextStyle(
                                    color: Colors.white, // สีข้อความภายในกรอบ
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    GridView.count(
                      crossAxisCount: 2, // 2 คอลัมน์
                      shrinkWrap: true, // ทำให้ไม่ขยายเต็มความสูง
                      physics:
                          const NeverScrollableScrollPhysics(), // ปิดการเลื่อน
                      children: [
                        buildImage('assets/arttoy3.jpg'),
                        buildImage('assets/arttoy1.jpg'),
                      ],
                    ),

                    //flash sale
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20.0,
                        left: 10.0,
                        right: 10.0,
                      ),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFE91E63), // ชมพูเข้ม
                            Color(0xFFFFC1D6), // ชมพูอ่อน
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(20.0), // โค้งมนเฉพาะมุมบนซ้าย
                          topRight:
                              Radius.circular(20.0), // โค้งมนเฉพาะมุมบนขวา
                          bottomLeft: Radius.circular(0.0), // มุมล่างซ้ายตรง
                          bottomRight: Radius.circular(0.0), // มุมล่างขวาตรง
                        ),
                        border: Border.all(
                          // เพิ่มเส้นกรอบ
                          color: Colors.pink, // สีของเส้นกรอบ
                          width: 2, // ความหนาของเส้นกรอบ
                        ),
                      ),
                      child: GestureDetector(
                        child: Center(
                          // เปลี่ยนให้ใช้ Center เพื่อจัดตำแหน่งตรงกลาง
                          child: Text(
                            'FLASH SALE',
                            style: TextStyle(
                              fontSize: 25.0, // ขนาดข้อความ
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.white, // สีของเงา
                                  offset: Offset(2.0, 2.0), // การเลื่อนของเงา
                                  blurRadius: 5.0, // ระยะเบลอของเงา
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 15),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 0.0,
                        left: 10.0,
                        right: 10.0,
                        bottom: 15.0,
                      ),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.pink[100],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0.0), // มุมบนซ้ายตรง
                          topRight: Radius.circular(0.0), // มุมบนขวาตรง
                          bottomLeft:
                              Radius.circular(20.0), // โค้งมนเฉพาะมุมล่างซ้าย
                          bottomRight:
                              Radius.circular(20.0), // โค้งมนเฉพาะมุมล่างขวา
                        ),
                        border: Border.all(
                          // เพิ่มเส้นกรอบ
                          color: Colors.pink, // สีของเส้นกรอบ
                          width: 2, // ความหนาของเส้นกรอบ
                        ),
                      ),
                      child: GestureDetector(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 5), // ช่องว่างระหว่างข้อความ

                            const SizedBox(
                                height:
                                    10), // ช่องว่างระหว่างข้อความกับกรอบใหม่
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  buildImgWithText('assets/baby.jpg',
                                      'Product 1', '\$30.00', '\$20.00'),
                                  buildImgWithText('assets/baby1.jpg',
                                      'Product 2', '\$35.00', '\$25.00'),
                                  buildImgWithText('assets/baby2.jpg',
                                      'Product 3', '\$40.00', '\$30.00'),
                                  buildImgWithText('assets/baby3.jpg',
                                      'Product 4', '\$32.00', '\$22.00'),
                                  buildImgWithText('assets/baby4.jpg',
                                      'Product 5', '\$38.00', '\$28.00'),
                                  buildImgWithText('assets/baby5.jpg',
                                      'Product 6', '\$28.00', '\$18.00'),
                                  buildImgWithText('assets/baby6.jpg',
                                      'Product 7', '\$25.00', '\$15.00'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImage(String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), // ความโค้งมนของกรอบ
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15), // ความโค้งมนของรูปภาพ
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildImageWithText(String imagePath, String productName,
      String originalPrice, String newPrice) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white, // Background color for the card
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Align text to the center
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: 150, // Set width for the image
                height: 120, // Set height for the image
              ),
            ),
            const SizedBox(height: 5), // Space between image and text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Align text to the center
                children: [
                  Text(
                    productName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 250, 15, 93),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Divider(
                    color: Colors.pink,
                    thickness: 2,
                    indent: 5,
                    endIndent: 5,
                  ),
                  const SizedBox(height: 5), // Space after the divider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        originalPrice,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration
                              .lineThrough, // Strikethrough effect
                        ),
                      ),
                      const SizedBox(
                          width: 5), // Space between original and new price
                      Text(
                        newPrice,
                        style: const TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5), // Space before promotion text
                  Center(
                    // Center the promotion text
                    child: Text(
                      '🛒 เริ่มโปรตั้งแต่วันนี้',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center, // Center the promotion text
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget buildImgWithText(String imagePath, String productName,
      String originalPrice, String newPrice) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white, // Background color for the card
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Align text to the center
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: 150, // Set width for the image
                height: 125, // Set height for the image
              ),
            ),
            const SizedBox(height: 5), // Space between image and text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Align text to the center
                children: [
                  Text(
                    productName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 250, 15, 93),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Divider(
                    color: Colors.pink,
                    thickness: 2,
                    indent: 5,
                    endIndent: 5,
                  ),
                  const SizedBox(height: 5), // Space after the divider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        originalPrice,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration
                              .lineThrough, // Strikethrough effect
                        ),
                      ),
                      const SizedBox(
                          width: 5), // Space between original and new price
                      Text(
                        newPrice,
                        style: const TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5), // Space before promotion text
                  Center(
                    // Center the promotion text
                    child: Text(
                      '🚨รีบก่อนหมดโปร🚨',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(235, 238, 3, 3),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center, // Center the promotion text
                    ),
                  ),
                ],
              ),
            ),
          ],
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
            ],
          ),
        ),
      ),
    );
  }
}
