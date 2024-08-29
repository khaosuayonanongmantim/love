import 'package:flutter/material.dart';
import 'package:project_new/HomeNavbar/detail_AllCon.dart';
import 'package:project_new/HomeNavbar/recommant_sport.dart';

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
        // ส่วนของการแนะนำสำหรับคุณ
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "🔥 ʀᴇᴄᴏᴍᴍᴇɴᴅᴇᴅ ꜰᴏʀ ʏᴏᴜ 🔥",
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
            children: [
              buildVerticalImageWithText(
                'assets/chang.jpg',
                '"Concert 2"',
                'December 5, 2024',
                '15.00 น.-22.00 น.',
                'Impact Arena เมืองทอง',
              ),
              buildVerticalImageWithText(
                'assets/piano.jpg',
                '"Concert 1"',
                'November 20, 2024',
                '15.00 น.-22.00 น.',
                'สนามราชมังคลา',
              ),
               buildVerticalImageWithText(
                'assets/cat.jpg',
                '"Concert 1"',
                'November 20, 2024',
                '15.00 น.-22.00 น.',
                'สนามราชมังคลา',
              ),
               buildVerticalImageWithText(
                'assets/cocktail.jpg',
                '"Concert 1"',
                'November 20, 2024',
                '15.00 น.-22.00 น.',
                'สนามราชมังคลา',
              ),
               buildVerticalImageWithText(
                'assets/kini.png',
                '"Concert 1"',
                'November 20, 2024',
                '15.00 น.-22.00 น.',
                'สนามราชมังคลา',
              ),
               buildVerticalImageWithText(
                'assets/scrub.jpg',
                '"Concert 1"',
                'November 20, 2024',
                '15.00 น.-22.00 น.',
                'สนามราชมังคลา',
              ),
            ],
          ),
        ),

        // การแสดงยอดนิยม
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "🏟 ᴘᴏᴘᴜʟᴀʀ ꜱʜᴏᴡꜱ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailCon()),);
                },
                child: Text(
                  "ᴀʟʟ",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              buildImageWithText('assets/bar4.jpg', '"bar 1"'),
              buildImageWithText('assets/bar2.jpg', '"bar 2"'),
              buildImageWithText('assets/bar1.jpg', '"bar 3"'),
              buildImageWithText('assets/bar3.jpg', '"bar 4"'),
              buildImageWithText('assets/party.jpg', '"bar 5"'),
              buildImageWithText('assets/bar.jpg', '"bar 6"'),
              buildImageWithText('assets/heap.jpg', '"bar 7"'),
            ],
          ),
        ),

        // การกีฬายอดเยี่ยม
      HomeConcertAndSport(),

      
        
      ],
    );
  }

  Widget buildVerticalImageWithText(
    String imagePath,
    String title,
    String date,
    String time,
    String location,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 250,
            height: 300,
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
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 241, 239, 239),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: Color.fromARGB(255, 5, 255, 13),
                    ),
                    SizedBox(width: 8),
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
                    Icon(
                      Icons.timer_sharp,
                      color: Color.fromARGB(255, 5, 255, 13),
                    ),
                    SizedBox(width: 8),
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
                    Icon(
                      Icons.location_on_rounded,
                      color: Color.fromARGB(255, 8, 214, 241),
                    ),
                    SizedBox(width: 8),
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


  // เกี่ยวกับส่วนของสถานที่บันเทิง
  Widget buildImageWithText(
    String imagePath,
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 170,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: Color.fromARGB(255, 0, 99, 180),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
