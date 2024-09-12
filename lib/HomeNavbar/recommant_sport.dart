import 'package:flutter/material.dart';
import 'package:project_new/HomeNavbar/detail_AllSportt.dart';

class HomeConcertAndSport extends StatefulWidget {
  const HomeConcertAndSport({Key? key}) : super(key: key);

  @override
  State<HomeConcertAndSport> createState() => _RecommendedHomeState();
}

class _RecommendedHomeState extends State<HomeConcertAndSport> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 30),
       Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "🏟⚽ᴇxᴄᴇʟʟᴇɴᴛ ꜱᴘᴏʀᴛꜱ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailSport()),);
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(
                              'assets/sport5.jpg',
                              height: 170,
                              width: 360,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
  height: 350,  // ปรับความสูงเพื่อรองรับ 2 แถว
  child: Wrap(
    spacing: 8.0, // ระยะห่างระหว่างแต่ละคอนเทนเนอร์
    runSpacing: 10.0, // ระยะห่างระหว่างแถว
    children: [
      _buildKeyProduct('assets/sport1.jpg', 'sport1'),
      _buildKeyProduct('assets/sport2.jpg', 'sport2'),
      _buildKeyProduct('assets/sport3.jpg', 'sport3'),
      _buildKeyProduct('assets/sport6.jpg', 'sport4'),
    ],
  ),
),

      ],
    );
    
  }
   Widget _buildKeyProduct(String imagePath, String name,) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 170,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: 130,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name, 
                    style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                    )
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
