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
                        Color(0xFFFFC1D6), // ชมพูอ่อน
                        Color(0xFFE91E63), // ชมพูเข้ม
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius:
                        BorderRadius.circular(32.0), // ปรับขนาดรัศมีมุม
                  ),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'ลูกค้าใหม่',
                          style: TextStyle(
                            fontSize: 21.0, // ปรับขนาดข้อความ
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 238, 12, 87),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'เมื่อชอปครบ 49฿ ลด 20%', // ข้อความใหม่
                          style: TextStyle(
                            fontSize: 20.0, // ขนาดข้อความเท่ากัน
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // รูปภาพแมวและกรอบใหม่
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // รูปแมว
                    Image.asset(
                      'assets/cat.png',
                      width: 70.0,
                      height: 120.0,
                    ),
                    const SizedBox(width: 10), // ช่องว่างระหว่างแมวกับกรอบ
                    // เพิ่ม SizedBox เพื่อให้กรอบขยับลง
                    const SizedBox(height: 50), // ปรับช่องว่างตามต้องการ

                    // กรอบใหม่
                    Container(
                      width: 310, // ความกว้างของกรอบ
                      height: 100, // ความสูงของกรอบ
                      decoration: BoxDecoration(
                        color: Colors.white, // กำหนดสีพื้นหลังเป็นสีขาว
                        borderRadius:
                            BorderRadius.circular(10), // ปรับรัศมีมุมกรอบ
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment
                                .center, // จัดข้อความ 20% OFF ให้อยู่ตรงกลาง
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // จัดให้อยู่ฝั่งซ้าย
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0,
                                      left: 10.0), // เพิ่ม padding ด้านซ้าย
                                  child: Text(
                                    '20% OFF', // ข้อความด้านบน
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors
                                          .black, // คุณสามารถเปลี่ยนสีของข้อความได้
                                      fontWeight:
                                          FontWeight.bold, // ทำให้ข้อความหนา
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0,
                                      left:
                                          10.0), // เพิ่ม padding ด้านซ้ายให้ข้อความด้านล่าง
                                  child: Text(
                                    'ซื้อครบ 49 บาท', // ข้อความด้านล่าง
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors
                                            .black54, // สีเทาอ่อนเพื่อให้ดูเรียบง่าย
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left:
                                          10.0), // เพิ่ม padding ด้านซ้ายให้ "ลดสูงสุด 150 บาท"
                                  child: Text(
                                    'ลดสูงสุด 150 บาท', // ข้อความด้านล่างสุด
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors
                                          .black54, // สีเทาอ่อนเพื่อให้ดูเรียบง่าย
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0), // ระยะห่างจากด้านซ้าย
                            child: Align(
                              alignment: Alignment
                                  .centerLeft, // จัดข้อความให้อยู่ริมซ้าย
                              child: Text(
                                'ɪɴᴛᴇʀ', // ข้อความทางซ้าย
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 30.0, left: 10.0), // ระยะห่างจากด้านซ้าย
                            child: Align(
                              alignment: Alignment
                                  .centerLeft, // จัดข้อความให้อยู่ริมซ้าย
                              child: Text(
                                'ɢᴇᴛʜᴇʀ', // ข้อความทางซ้าย
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 3.0, // ระยะห่างจากด้านขวา
                            top: 33.0, // ปรับให้ตรงกลางตามแนวตั้ง
                            child: GestureDetector(
                              onTap: _isCouponClaimed
                                  ? null // Disable the tap if claimed
                                  : _claimCoupon, // Claim coupon on tap
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 5.0), // เพิ่ม padding ภายในกรอบ
                                decoration: BoxDecoration(
                                  color: _isCouponClaimed
                                      ? Colors.blue // Change color if claimed
                                      : Colors.pink, // Default color
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
                                  _isCouponClaimed ? 'ใช้ทันที' : 'เก็บคูปอง',
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
                  ],
                ),
                const SizedBox(height: 10), // ช่องว่างระหว่างข้อความกับกรอบใหม่
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildImageWithText(
                          'assets/baby.jpg', 'Product 1', '\$30.00', '\$20.00'),
                      buildImageWithText('assets/baby1.jpg', 'Product 2',
                          '\$35.00', '\$25.00'),
                      buildImageWithText('assets/baby2.jpg', 'Product 3',
                          '\$40.00', '\$30.00'),
                      buildImageWithText('assets/baby3.jpg', 'Product 4',
                          '\$32.00', '\$22.00'),
                      buildImageWithText('assets/baby4.jpg', 'Product 5',
                          '\$38.00', '\$28.00'),
                      buildImageWithText('assets/baby5.jpg', 'Product 6',
                          '\$28.00', '\$18.00'),
                      buildImageWithText('assets/baby6.jpg', 'Product 7',
                          '\$25.00', '\$15.00'),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                        height: 20), // ระยะห่างด้านบนเพื่อขยับข้อความลง
                    Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "โปรดีไม่มีพัก ", // ส่วนแรกของข้อความ
                              style: TextStyle(
                                color: const Color.fromARGB(
                                    255, 248, 7, 87), // สีชมพูอ่อน
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "ลดกันต่อเนื่อง", // ส่วนที่สองของข้อความ
                              style: TextStyle(
                                color: Colors.white, // สีชมพูเข้ม
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
                          'assets/arttoy.jpg', // เส้นทางของรูปภาพของคุณ
                          width: 350, // ขนาดความกว้างของรูปภาพ
                          height: 250, // ขนาดความสูงของรูปภาพ
                          fit: BoxFit.cover, // วิธีการปรับขนาดรูปภาพ
                        ),
                      ),
                    ),
                    const SizedBox(
                        height:
                            10), // ระยะห่างระหว่างรูปภาพหลักกับรูปภาพที่เพิ่ม
                    // รูปภาพ 4 รูป 2 ด้านบน 2 ด้านล่าง
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
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Align text to the left
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
                    CrossAxisAlignment.start, // Align text to the left
                children: [
                  Text(
                    productName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Row(
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
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
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
