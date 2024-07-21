import 'package:flutter/material.dart';
import 'package:project_new/navbar/discount.dart';
import 'package:project_new/navbar/home.dart';
import 'package:project_new/navbar/message.dart';
import 'package:project_new/navbar/product.dart';
import 'package:project_new/navbar/profile.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int myCurrentIndex = 2; // ตั้งค่าเริ่มต้นเป็นตำแหน่งของหน้า Home
  List pages = const [
    Message(),
    Product(),
    Home(),
    Discount(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logo.png', // ใส่เส้นทางไปยังไฟล์รูปภาพของคุณ
              height: 100,
            ),
            const SizedBox(width: 10),
          ],
        ),
        backgroundColor: Colors.white, // เปลี่ยนสีของ AppBar
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 7,
        ),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 25,
            offset: const Offset(10, 10),
          ),
        ]),
        child: ClipRRect( //กรอบโค้งมน
          borderRadius: BorderRadius.circular(30), //ความโค้งมน
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: const Color.fromARGB(255, 184, 20, 212),
            unselectedItemColor: Colors.black,
            currentIndex: myCurrentIndex,
            onTap: (index) {
              setState(() {
                myCurrentIndex = index;
              });
            },
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold, // ความหนาของข้อความเมื่อถูกเลือก
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal, // ความหนาของข้อความเมื่อไม่ได้เลือก
            ),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.auto_stories), label: "ข่าวสาร"),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: "สินค้า"),
              BottomNavigationBarItem(icon: Icon(Icons.home_work, size: 30, ),label: "หน้าหลัก",),
              BottomNavigationBarItem(icon: Icon(Icons.discount_outlined), label: "ส่วนลด"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "โปรไฟล์"),
            ],
          ),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}
