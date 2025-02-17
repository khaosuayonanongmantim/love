import 'package:flutter/material.dart';
import 'package:project_new/navbar/product.dart';

class PaymentSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ชำระเงินสำเร็จ'),
        backgroundColor: Color.fromARGB(255, 255, 135, 175), // สีชมพู
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,  
              size: 100,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Text(
              'การชำระเงินของคุณสำเร็จแล้ว!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'ขอบคุณที่ทำการชำระเงินกับเรา!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
           ElevatedButton(
  onPressed: () {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Product()),  
    );
  },
  style: ElevatedButton.styleFrom(
    primary: Color(0xFFFF1A79), // สีชมพู
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
  ),
  child: Text(
    'กลับไปที่หน้าสินค้า',
    style: TextStyle(fontSize: 16, color: Colors.white),
  ),
),

          ],
        ),
      ),
    );
  }
}
