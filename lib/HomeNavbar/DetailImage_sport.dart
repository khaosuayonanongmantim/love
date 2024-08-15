import 'package:flutter/material.dart';

class CookDetail extends StatelessWidget {
  
  final assetPath, cookieprice, cookiename;

  CookDetail({this.assetPath, this.cookieprice, this.cookiename});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF545D68),),
        onPressed: (){
          Navigator.of(context).pop();
        }, 
        ),
        actions: <Widget>[
          IconButton(
        icon: Icon(Icons.notifications_none, color: Color(0xFF545D68),),
        onPressed: (){}, 
        ),
        ],
      ),

      body: ListView(
        children: [
          SizedBox(height: 15.0),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'รายละเอียดกีฬา',
              style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 241, 119, 160),             
                 ),
              ),
          ),
              SizedBox(height: 15.0),
              Hero(
                tag: assetPath,
                child: Image.asset(assetPath,
                height: 150.0,
                width: 100.0,
                fit: BoxFit.contain,
              ),
              ),
              SizedBox(height: 20.0),
            Center(
              child: Text(cookieprice,
              style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Text(cookiename,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Varela',
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50.0,
                child: Text('In Korean dining, everything is served on the table together, called "hanjeongsik" (한정식). One table mainly consists of rice, soup, and kimchi. In addition, there are dishes that everyone eats together. and bansan.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                  color: Colors.black54,
                  ),
                ),
                
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color.fromARGB(255, 245, 141, 176),
                ),
                child: Center(
                  child: Text('Add to Love',
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    
                  ),
                  ),
                ),
              ),
            )
            
        ],
      ),
      
    );
  }
}