import 'package:flutter/material.dart';

class RecommendedHome extends StatefulWidget {
  const RecommendedHome({Key? key}) : super(key: key);

  @override
  State<RecommendedHome> createState() => _RecommendedHomeState();
}

class _RecommendedHomeState extends State<RecommendedHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "🔥 แนะนำสำหรับคุณ 🔥",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [//อยู่หลังบ้าน (รอ)
              buildVerticalImageWithText('assets/nunew.jpg', '"Concert 1"', 'November 20, 2024','15.00 น.-22.00 น.','สนามราชมังคลา'),
              buildVerticalImageWithText('assets/chang.jpg', '"Concert 2"', 'December 5, 2024','15.00 น.-22.00 น.','Impact Arena เมืองทอง'),
              buildVerticalImageWithText('assets/war.jpg', '"Concert 3"', 'January 15, 2025','15.00 น.-22.00 น.','Indoor stadiam หัวหมาก'),
              buildVerticalImageWithText('assets/cat.jpg', '"Concert 4"', 'February 28, 2025','15.00 น.-22.00 น.','Bitec บางนา'),
              buildVerticalImageWithText('assets/piano.jpg', '"Concert 5"', 'March 10, 2025','15.00 น.-22.00 น.','Thuder Dome เมืองทอง'),
              buildVerticalImageWithText('assets/kini.png', '"Concert 6"', 'April 25, 2025','15.00 น.-22.00 น.','Impact เมืองทอง'),
              buildVerticalImageWithText('assets/wan.jpg', '"Concert 7"', 'May 7, 2025','15.00 น.-22.00 น.','Bitec live,bitec bangna'),
              buildVerticalImageWithText('assets/threemandown.jpg', '"Concert 8"', 'June 20, 2025','15.00 น.-22.00 น.','Paragon Ciniplex'),
              buildVerticalImageWithText('assets/cocktail.jpg', '"Concert 9"', 'July 4, 2025','15.00 น.-22.00 น.','เมืองไทยรัชดาลัย'),
              buildVerticalImageWithText('assets/scrub.jpg', '"Concert 10"', 'August 15, 2025','15.00 น.-22.00 น.','เอ็มซีซี ฮอลล์'),
            ],
          ),
        ),
          SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "ดูเพิ่มเติม ",
            style: TextStyle(
              color: Colors.pinkAccent,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildVerticalImageWithText(String imagePath, String title, String date,String time,String location) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 250,
            height: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: 250,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12), // Adjust padding as needed
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 143, 141, 141).withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                      Icon(Icons.calendar_month_outlined,  
                      color: Color.fromARGB(255, 5, 255, 13),),
                      SizedBox(width: 8),//ความห่าง
                    Text(
                      date,
                      style: TextStyle(
                        color: Color.fromARGB(255, 5, 255, 13),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.timer_sharp,  
                      color: Color.fromARGB(255, 5, 255, 13),),
                      SizedBox(width: 8),//ความห่าง
                    Text(
                      time,
                      style: TextStyle(
                        color: Color.fromARGB(255, 5, 255, 13),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on_rounded,  
                      color: Color.fromARGB(255, 8, 214, 241),),
                      SizedBox(width: 8),//ความห่าง
                    Text(
                      location,
                      style: TextStyle(
                        color: Color.fromARGB(255, 8, 214, 241),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
        ],
        
      ),
      
    );
  }
}
