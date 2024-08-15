import 'package:flutter/material.dart';

class ConcertDetail extends StatelessWidget {
  final String imagePath;
  final String text1;
  final String text2;
  final String text3;
  final String text4;

  const ConcertDetail({
    Key? key,
    required this.imagePath,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text1),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            const SizedBox(height: 16),
            Text(
              text1,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              text2,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            Text(
              text3,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            Text(
              text4,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
