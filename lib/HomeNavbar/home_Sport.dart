import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeSport extends StatefulWidget {
  const HomeSport({super.key});

  @override
  State<HomeSport> createState() => _HomeSportState();
}

class _HomeSportState extends State<HomeSport> {
  // ignore: unused_field
  final PageController _controller = PageController(); 

 // ประกาศตัวที่จุดเลื่อน
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Sport',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        titleSpacing: 0.0,
        toolbarHeight: 56.0,
      ),
     backgroundColor: const Color.fromARGB(255, 252, 186, 208),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 50.0,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'ค้นหากีฬาที่นี่...',
                  hintStyle: TextStyle(
                    color: Colors.black54,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // เพิ่มระยะห่างระหว่างข้อความกับขอบ
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
              Container(
                height: 200,
                child: PageView(
                  controller: _controller,
                  children: [
                      Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/sport6.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/sport5.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/sport.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/sport1.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/sport2.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/sport3.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/sport5.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/sport4.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/sport2.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/sport1.jpg', fit: BoxFit.cover),
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
                  activeDotColor: Color.fromARGB(255, 245, 48, 156),
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
        ],
        
      ),
      
    );
  }
}
