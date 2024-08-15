import 'package:flutter/material.dart';
import 'package:project_new/HomeNavbar/Home_Sport.dart';
import 'package:project_new/HomeNavbar/home_concert.dart';
import 'package:project_new/HomeNavbar/home_recommend.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _controller = PageController(); // ตัวควบคุม PageView

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 30),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "THE CONCERT",
                style: TextStyle(
                  color: Colors.purpleAccent,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "MUSIC FESTIVAL",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildImageWithLabel(
                    imagePath: 'assets/con2.png',
                    label: '𝐂𝐎𝐍𝐂𝐄𝐑𝐓',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeConcert(),
                        ), // หน้า Concert
                      );
                    },
                  ),
                  SizedBox(width: 70), // ระยะห่างระหว่างรูปภาพ
                  _buildImageWithLabel(
                    imagePath: 'assets/bell.jpg',
                    label: '𝐒𝐏𝐎𝐑𝐓',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeSport(),
                        ), // หน้า Sport
                      );
                    },
                  ),
                ],
              ),
              
              SizedBox(height: 30),
              Container(
                height: 200,
                child: PageView(
                  controller: _controller,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/nunew.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/chang.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/war.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/cat.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/piano.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/kini.png', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/wan.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/threemandown.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/cocktail.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/scrub.jpg', fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SmoothPageIndicator(
                controller: _controller,
                count: 10,
                effect: WormEffect(
                  dotHeight: 8.0,
                  dotWidth: 8.0,
                  activeDotColor: Colors.purpleAccent,
                  dotColor: Colors.white,
                ),
                onDotClicked: (index) {
                  _controller.animateToPage(
                    index,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              RecommendedHome(),
            ],
          ),
        ),
      ),
    );
  }

  // รูปวงกลม
  Widget _buildImageWithLabel({
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 40, // ขนาดรูปภาพ
            backgroundImage: AssetImage(imagePath),
          ),
        ),
        SizedBox(height: 4), // Space between image and text
        Text(
          label,
          style: TextStyle(
            color: Colors.purple, // เปลี่ยนสีของข้อความ
            fontSize: 18, // ปรับขนาดของข้อความ
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
