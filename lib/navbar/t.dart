import 'dart:async';
import 'package:flutter/material.dart';

class Discount extends StatefulWidget {
  const Discount({super.key});

  @override
  _DiscountState createState() => _DiscountState();
}

class _DiscountState extends State<Discount> {
  double _scale = 1.0; // ขนาดเริ่มต้นของข้อความ
  late ScrollController _scrollController;
  late Timer _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Auto-scroll logic
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _currentIndex = (_currentIndex < 2) ? _currentIndex + 1 : 0;
      });
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

  void _onTap() {
    setState(() {
      // ขยายขนาดข้อความเมื่อแตะ
      _scale = (_scale == 1.0) ? 1.5 : 1.0; // ขยายใหญ่ขึ้นหรือลดขนาดลง
    });

    // คืนค่าขนาดกลับไปที่ขนาดเริ่มต้นหลังจาก 200 มิลลิวินาที
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _scale = 1.0; // คืนค่าขนาด
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFEECDA3),
              Color(0xFFEF629F),
            ], // Gradient background
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              // กรอบข้อความ
              Container(
                margin: const EdgeInsets.only(top: 250.0, left: 50.0, right: 10.0),
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
                  borderRadius: BorderRadius.circular(32.0), // ปรับขนาดรัศมีมุม
                ),
                child: GestureDetector(
                  onTap: _onTap, // เรียกใช้งานฟังก์ชันเมื่อแตะ
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedScale(
                        scale: _scale,
                        duration: const Duration(milliseconds: 200),
                        child: const Text(
                          'ลูกค้าใหม่',
                          style: TextStyle(
                            fontSize: 21.0, // ปรับขนาดข้อความ
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 238, 12, 87),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'เมื่อชอปครบ 90฿ ลด 20%', // ข้อความใหม่
                        style: TextStyle(
                          fontSize: 18.0, // ขนาดข้อความเท่ากัน
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // รูปภาพแมว
              Positioned(
                left: -10,
                top: 240,
                child: Image.asset(
                  'assets/cat.png',
                  width: 100.0,
                  height: 70.0,
                ),
              ),
              // เพิ่ม Padding ด้านบนของ ListView
              Positioned(
                left: 0,
                right: 0,
                top: 20, // ปรับระยะห่างจากกรอบข้อความ
                child: SizedBox(
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
              ),
            ],
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
            ],
          ),
        ),
      ),
    );
  }
}
