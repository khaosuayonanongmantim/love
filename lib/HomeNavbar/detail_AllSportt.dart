import 'package:flutter/material.dart';
import 'package:project_new/HomeNavbar/DetailImage_sport.dart';

class  DetailSport extends StatelessWidget {
  const  DetailSport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          SizedBox(height: 15.0),
          Container(
            padding: EdgeInsets.only(right: 15.0),
            width: MediaQuery.of(context).size.width - 30.0,
            height: MediaQuery.of(context).size.height - 50.0,
            child: GridView.count(
            crossAxisCount: 2,
            primary: false,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 15.0,
            childAspectRatio: 0.8,
            children: <Widget>[
              _buildCard('bar', '\$ 199', 'assets/bar1.jpg', false, false, context),
              _buildCard('bar', '\$ 156', 'assets/bar3.jpg', false, true, context),
              _buildCard('bar', '\$ 187', 'assets/bar4.jpg', true, false, context),
             _buildCard('Tokpokki1', '\$ 199', 'assets/bar.jpg', false, false, context),
              _buildCard('Peach Tea', '\$149', 'assets/bar2.jpg', false, false, context),
            ],
            ),
          ),
          SizedBox(height: 15.0),
        ],
      ),
    );
  }
  Widget _buildCard(String name, String price, String imgPath, bool added, 
    bool isFavorite, context){
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CookDetail(
              assetPath: imgPath,
              cookieprice: price,
              cookiename: name,
            ),
            ));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3.0,
                blurRadius: 5.0,
              ),
            ],
            color: Color.fromARGB(255, 255, 218, 230),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.favorite, color: Colors.pinkAccent)
                    ]
                  ),
                  ),
                  Hero(
                    tag: imgPath,
                    child: Container(
                      height: 95.0,
                      width: 95.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imgPath),
                           fit: BoxFit.contain
                          ),
                      ),
                    ),
                  ),
                  SizedBox(height: 7.0),
                  Text(price,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 132, 173),
                    fontSize: 14.0,
                    fontFamily: 'Varela'
                  ),
                  ),
                  Text(name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontFamily: 'Varela'
                  ),
                  ),
                  Padding(
                  padding: EdgeInsets.all(8.0),

                  child: Container(
                    color: Colors.grey,
                    height: 1.0,
                  ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (!added) ...[
                        Icon(Icons.shopping_basket,
                        color: Color(0xFFD17E50),
                        size: 12.0,
                        ),
                        Text('Add to cart',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          color: Colors.pinkAccent,
                          fontSize: 12.0,
                        ),
                        ),
                      ],
                      if (added) ...[
                          Icon(Icons.remove_circle_outline,
                          color: Colors.redAccent,
                          size: 12.0,
                          ),
                          Text('5',
                          style: TextStyle(
                            fontFamily: 'Varela',
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                          ),
                          Icon(Icons.add_circle_outline,
                          color: Colors.redAccent,
                          size: 12.0,
                          ),
                        ]
                    ],
                  ),
                  ),
              ]
              ),
        ),
      ),
    );
   }
}