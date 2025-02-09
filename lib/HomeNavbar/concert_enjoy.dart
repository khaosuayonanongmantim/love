import 'package:flutter/material.dart';

class ConcertDetailPage extends StatelessWidget {
  final Map<String, dynamic> concert;

  ConcertDetailPage({required this.concert});

  @override
  Widget build(BuildContext context) {
    String imageUrl = 'http://192.168.55.228/concert/${concert['image']}';

    return Scaffold(
      appBar: AppBar(title: Text(concert['name'] ?? 'Concert Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(imageUrl, width: double.infinity, height: 200, fit: BoxFit.cover),
            ),
            SizedBox(height: 16),
            Text(
              concert['name'] ?? 'Concert Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              concert['description'] ?? 'No description available.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
