import 'package:flutter/material.dart';

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
      

        // การแสดงและกีฬายอดนิยม
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "🏟⚽การแสดงและกีฬายอดนิยม",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const Product()),);
                },
                child: Text(
                  "ALL",
                  style: TextStyle(
                    color: Color.fromARGB(255, 28, 142, 235),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        // รูปภาพการแสดงและกีฬา
        SizedBox(height: 15),
        Container(
          height: 150,
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            childAspectRatio: 1,
            physics: NeverScrollableScrollPhysics(),
            children: [
              buildImageGridItem('assets/nunew.jpg', 'Concert 1'),
              buildImageGridItem('assets/chang.jpg', 'Concert 2'),
            ],
          ),
        ),
        Container(
          height: 150,
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            childAspectRatio: 1,
            physics: NeverScrollableScrollPhysics(),
            children: [
              buildImageGridItem('assets/cat.jpg', 'cat'),
              buildImageGridItem('assets/piano.jpg', 'piano'),
            ],
          ),
        ),
        Container(
          height: 150,
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            childAspectRatio: 1,
            physics: NeverScrollableScrollPhysics(),
            children: [
              buildImageGridItem('assets/sport.jpg', 'sport 1'),
              buildImageGridItem('assets/sport1.jpg', 'sport 2'),
            ],
          ),
        ),
        Container(
          height: 150,
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            childAspectRatio: 1,
            physics: NeverScrollableScrollPhysics(),
            children: [
              buildImageGridItem('assets/sport2.jpg', 'sport 3'),
              buildImageGridItem('assets/sport3.jpg', 'sport 4'),
            ],
          ),
        ),
      ],
    );
  }

 

  // เกี่ยวกับส่วนของการแสดงยอดนิยมและกีฬา
  Widget buildImageGridItem(String imagePath, String text) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(8),
            color: Colors.black.withOpacity(0.5),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
