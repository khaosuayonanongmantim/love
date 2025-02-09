import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  // Add the missing additionalInformation list
  final List<Map<String, String>> additionalInformation = [
    {
      'title': 'เชลซี" คืนฟอร์ม เปิดบ้านกำราบ "วูล์ฟแฮมป์ตัน',
      'description': '3-1 ขึ้นที่ 4 ตาม "ลิเวอร์พูล" 10 แต้ม พรีเมียร์ลีก',
      'image': 'assets/news1.jpg',
    },
    {
      'title': 'เฮดโค้ชลิเวอร์พูล” คอนเฟิร์มข่าวร้าย! “โชตา-โจ โกเมซ” ',
      'description': 'ต้องพักอีกหลายสัปดาห์  อดบู๊ “ลีลล์” ในศึก ยูฟ่า แชมเปียนส์ลีก',
      'image': 'assets/news2.jpg',
    },
    {
      'title': 'เด็กข้างบ้านทักทายครับ! BOYNEXTDOOR ',
      'description': 'เจอแฟนไทย 29 มี.ค.นี้ ณ ธันเดอร์โดม เมืองทองธานี',
      'image': 'assets/news3.png',
    },
    {
      'title': 'สัมภาษณ์เอ็กซ์คลูซีฟ wave to earth ',
      'description': 'จัดคอนเสิร์ตที่ไทยครั้งที่ 4 กับคอนเสิร์ตรับอัลบั้มใหม่ ',
      'image': 'assets/news4.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Create an AnimationController with an infinite loop
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(); // Repeat indefinitely

    // Define the animation from right to left
    _animation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Start from the right side
      end: const Offset(-1.0, 0.0), // End on the left side
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear, // Smooth constant scrolling
    ));
  }

  

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'Latest Information & Updates',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF483D8B),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Stay informed with the latest news and updates. Discover innovations, trends,',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Fixed height for PageView to prevent overflow
              SizedBox(
                height: 450, // Adjust height as needed
                child: PageView(
                  children: [
                    _buildPage(
                      imagePath: 'assets/in1.jpg',
                      title: 'GMM MUSIC เปิดตัวค่าย 19 และศิลปินเลือดใหม่มากความสามารถทั้ง 5 คน มาพร้อมอัลบั้มแรก!',
                      content: 'นับเป็นหนึ่งความน่าสนใจในปีนี้กับการเปิดค่าย 19 (ไนน์-ทีน) ค่ายน้องใหม่ล่าสุดในเครือ GMM Music ซึ่งหลังจากเฟ้นหาศิลปินในสังกัดกันอย่างเข้มข้นในรายการ 19Lab จากผู้สมัครทั่วประเทศคัดจนเหลือเพียง 91 คน ', 
                      onReadMore: () {  },
                    ),
                    _buildPage(
                      imagePath: 'assets/in2.jpg',
                      title: '“j.rabbit” ชวนมาเก็บโมเมนต์ความสุขไปกับซิงเกิลใหม่ “Capture” เพลงป๊อบฟังสบายติดหู!',
                      content: '“j.rabbit” หรือ “เจสัน โสตางกูร” ศิลปินมากฝีมือจากค่ายเพลง MILK! BKK หลังจากเดบิวต์เป็นศิลปินเดี่ยวพร้อมเพลงจังหวะสนุกอย่าง “Loop” และตามด้วยเพลงเอาใจคนดีที่เธอไม่รัก “แค่ดี (it’s not me)” ',
                      onReadMore: () {  },
                    ),
                    _buildPage(
                      imagePath: 'assets/in3.jpg',
                      title: 'GET TO KNOW LITTLE JOHN วงร็อกฟอร์มดีผู้สร้างปรากฏการณ์เพลงเปิดตัวสุดฮิต “ฉันไม่ต้องการตัวเธอในตอนนี้”',
                      content: '“LITTLE JOHN” น้องใหม่ไฟแรงที่พร้อมปลุกเนื้อแท้ของความร็อกให้กลับมาอีกครั้ง ย้อนไปเมื่อปี 2020 มีวัยรุ่นกลุ่มหนึ่งที่อยากถ่ายทอดมุมมองที่มีต่อความรักและสังคมรอบข้าง ',
                      onReadMore: () {  },
                    ),
                     _buildPage(
                      imagePath: 'assets/in4.jpg',
                      title: 'รวมไอดอลไทป์ลูกแมวน้อย   น่ารักกระปุ๊กกระปิ๊กที่สุดเลยเหมี๊ยววว ~',
                      content: 'ในเมื่อมีไอดอลไทป์ลูกหมาบ๊อกแบ๊กไปแล้ว.. เพื่อฉลอง “วันแมวสากล (International Cat Day)” ก็ต้องมีเหล่าไอดอลไทป์แมวน้อยน่ารักกระปุ๊กกระปิ๊ก ',
                      onReadMore: () {  },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), // Space between the PageView and the Additional Info
              
              // Container for Additional Information Section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'ADDITIONAL INFORMATION',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[800],
                      ),
                    ),
                    SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.85, // ปรับอัตราส่วนให้พอดีกับภาพ
                        
                      ),
                      itemCount: additionalInformation.length,
                      itemBuilder: (context, index) {
                        final info = additionalInformation[index];
                        return _buildInfoCard(info);
                      },
                    ),
                  ],
                ),
              ),
              
              // Scrolling Text Section with Animation in one line
              Container(
                width: double.infinity,
                height: 90,
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFB3E5FC), // Light pastel blue
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRect(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal, // Horizontal scrolling
                    child: Row(
                      children: [
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: _animation.value * MediaQuery.of(context).size.width,
                              child: child,
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.warning,
                                    color: Color.fromARGB(255, 206, 195, 32), // ไอคอนเป็นสีแดง
                                    size: 40,
                                  ),
                                ),
                                TextSpan(
                                  text: ' Attention: Don\'t Miss Our Latest Updates! ',
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Quicksand',
                                    color: Color(0xFFE0FFFF), // Light cyan color
                                    letterSpacing: 2,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.5),
                                        blurRadius: 8,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                ),
                              ],


                        
                            ),
                          ),
                        ),
                        
                      ],
                      
                      
                    ),
                    
                  ),
                ),
              ),
                     SizedBox(height: 20),

              // Event Announcement Section
              _buildEventAnnouncement(
                title: 'Event Announcement',
                imagePath: 'assets/pos1.jpg',
                description: 'สิ้นสุดการรอคอย BODYSLAM!! การรวมตัวของชาวร็อคที่ยิ่งใหญ่ The wait is over. The Great Rock Fan assembly is coming',

                onPressed: () {
                  // Add your navigation or functionality here
                },
              ),

              SizedBox(height: 20),

              // Special Event Announcement Section
              _buildEventAnnouncement(
                title: 'Event Announcement',
                imagePath: 'assets/pos2.jpg',
                description: 'บีอัสเตรียมกรี๊ดดด!!!! BUS BECAUSE OF YOU I SHINE ประกาศคอนเสิร์ตใหญ่ 15 มี.ค. 68',
                
                onPressed: () {
                  // Add your navigation or functionality here
                },
              ),

               _buildEventAnnouncement(
                title: 'Important Announcement',
                imagePath: 'assets/pos3.jpg',
                description: 'ประกาศ!!! คอนเสิร์ตใหญ่ครั้งสำคัญเต็มรูปเเบบครั้งเเรก วง Bamm ห้ามพลาด เเล้วมาพบกับความสนุกสนานได้ในวันที่ 22 กุมภาพันธ์ 2568',
                
                onPressed: () {
                  // Add your navigation or functionality here
                },
              ),

               _buildEventAnnouncement(
                title: 'Important Announcement',
                imagePath: 'assets/pos4.jpg',
                description: 'เตรียมตัวให้พร้อม "COCKTAIL" ประกาศคอนเสิร์ตครั้งยิ่งใหญ่เต็มรูปเเบบครั้งสุดท้าย',
                
                onPressed: () {
                  // Add your navigation or functionality here
                },
              ),
                    

       
              
            ],
          ),
        ),
      ),
    );
  }


   Widget _buildEventAnnouncement({
    required String title,
    required String imagePath,
    required String description,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 247, 237, 213),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF738FFE),
            ),
          ),
          SizedBox(height: 25),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 350,
              height: 400,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(fontSize: 16, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        
        ],
      ),
    );
  }
  
  

  Widget _buildPage({required String imagePath, required String title, required String content,  required VoidCallback onReadMore,}) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 200, 189, 189),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: 
              Image.asset(
               imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 25),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple[800],
            ),
          ),
          SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[800],
              height: 1.5,
              ),
        ),
        SizedBox(height: 5),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: onReadMore,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "ดูเพิ่มเติม",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildInfoCard(Map<String, String> info) {
    return Container(
      width: double.infinity, // ตั้งให้เต็มความกว้างของช่องใน GridView
      height: 200, // ตั้งค่าความสูงตามที่ต้องการ
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: info['image']!.startsWith('http')
              ? Image.network(
                  info['image']!,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  info['image']!,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
        ),
          SizedBox(height: 8),
          Text(
            info['title']!,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Text(
            info['description']!,
            style: TextStyle(
              fontSize: 8,
              color: Colors.grey[600],
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
