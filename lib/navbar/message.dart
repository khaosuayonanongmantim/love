import 'package:flutter/material.dart';
import 'package:project_new/NextPage.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

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
                      title: 'World Trends 2024',
                      content: 'Catch up on the latest global trends for 2024, from economic shifts to social movements. This section highlights key areas to watch and offers insights into how these trends could affect individuals and businesses worldwide.',
                    ),
                    _buildPage(
                      title: 'Insights and Analysis',
                      content: 'Dive deeper into the details behind these trends and understand how they may impact various industries. Gain insights that can help shape your perspective and decisions for the coming year.',
                    ),
                    _buildPage(
                      title: 'Future Predictions',
                      content: 'Explore predictions for the future and understand potential changes in technology, economy, and society. These insights will help you stay prepared and informed about what lies ahead.',
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
                    GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(), // Disable scrolling for GridView inside Column
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      children: [
                        _buildInfoCard(
                          icon: Icons.campaign,
                          title: 'EXCITING NEWS',
                          content: 'Stay tuned for the latest updates and exciting news!',
                        ),
                        _buildInfoCard(
                          icon: Icons.rocket_launch,
                          title: 'NEW LAUNCHES',
                          content: 'We’re launching new products! Don’t miss out on the latest releases.',
                        ),
                        _buildInfoCard(
                          icon: Icons.public,
                          title: 'NEW LAUNCHES',
                          content: 'Stay tuned for the latest updates and exciting news!',
                        ),
                        _buildInfoCard(
                          icon: Icons.lightbulb,
                          title: 'EXCITING NEWS',
                          content: 'We’re launching new products! Don’t miss out on the latest releases.',
                        ),
                      ],
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
                imagePath: 'assets/pop3.jpg',
                description: 'Join us for an unforgettable event filled with amazing experiences, new opportunities, and thrilling moments. Save the date!',
                buttonText: 'Learn More',
                onPressed: () {
                  // Add your navigation or functionality here
                },
              ),

              SizedBox(height: 20),

              // Special Event Announcement Section
              _buildEventAnnouncement(
                title: 'Special Event Announcement',
                imagePath: 'assets/pop3.jpg',
                description: 'Don\'t miss our special event featuring exclusive content and unique experiences. Mark your calendar!',
                buttonText: 'Find Out More',
                onPressed: () {
                  // Add your navigation or functionality here
                },
              ),
                      SizedBox(height: 20),

          Center(
  child: ElevatedButton(
    onPressed: () {
      // Navigate to the Next Page when button is pressed
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NextPage()), // NextPage is the new page we created
      );
    },
    style: ElevatedButton.styleFrom(
      primary: const Color.fromARGB(255, 38, 44, 48), // Customize button color
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
    ),
    child: Text(
      'Next Page',
      style: TextStyle(
        color: Colors.white, // เปลี่ยนสีข้อความที่นี่
        fontSize: 18,         // ปรับขนาดข้อความถ้าต้องการ
        fontWeight: FontWeight.bold, // ปรับน้ำหนักของฟอนต์
      ),
    ),
  ),
)
              
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
    required String buttonText,
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
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 214, 217, 221),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
  
  

  Widget _buildPage({required String title, required String content}) {
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
              Image.network(
                'https://via.placeholder.com/400x400',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 25),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple[800],
            ),
          ),
          SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required IconData icon, required String title, required String content}) {
    return Container(
      width: double.infinity, // ตั้งให้เต็มความกว้างของช่องใน GridView
      height: 150, // ตั้งค่าความสูงตามที่ต้องการ
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
          Icon(icon, size: 25, color: Colors.blueGrey[700]),
          SizedBox(height: 25),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 12,
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
