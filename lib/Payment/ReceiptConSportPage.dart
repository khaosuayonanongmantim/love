import 'package:flutter/material.dart';
import 'dart:io';
import 'package:project_new/navbar/home.dart';

class ReceiptConSportPage extends StatelessWidget {
  final String concertName;
  final String date;
  final String time;
  final String location;
  final String zoneName;
  final String imagePath;
  final List<String> selectedSeats;
  final double totalPrice;
  final double vatAmount;
  final double serviceFee;

  const ReceiptConSportPage({
    Key? key,
    required this.concertName,
    required this.date,
    required this.time,
    required this.location,
    required this.zoneName,
    required this.imagePath,
    required this.selectedSeats,
    required this.totalPrice,
    required this.vatAmount,
    required this.serviceFee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ใบเสร็จ',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '🎉 ชำระเงินสำเร็จแล้ว 🎉',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: imagePath.startsWith('http')
                        ? Image.network(imagePath,
                            width: 130, height: 150, fit: BoxFit.cover)
                        : File(imagePath).existsSync()
                            ? Image.file(File(imagePath),
                                width: 120, height: 120, fit: BoxFit.cover)
                            : Image.asset('assets/default_receipt.png',
                                width: 120, height: 120, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.grey, thickness: 1),
                  Text(
                    'คอนเสิร์ต : ${concertName}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  buildReceiptRow('วันที่:', date),
                  buildReceiptRow('เวลา:', time),
                  buildReceiptRow('สถานที่:', location),
                  buildReceiptRow('โซนที่เลือก:', zoneName),
                  buildReceiptRow('ที่นั่งที่เลือก:', selectedSeats.join(', '),
                      color: Colors.pink),
                  const Divider(color: Colors.grey, thickness: 1),
                  buildReceiptRow('VAT:', '฿${vatAmount.toStringAsFixed(2)}',
                      color: Colors.green),
                  buildReceiptRow(
                      'ค่าธรรมเนียม:', '฿${serviceFee.toStringAsFixed(2)}',
                      color: Colors.green),
                  const Divider(color: Colors.grey, thickness: 1),
                  buildReceiptRow(
                      'ราคารวม:', '฿${totalPrice.toStringAsFixed(2)}',
                      color: Colors.red, boldValue: true),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: const Text(
                'กลับไปหน้าหลัก',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReceiptRow(String label, String value,
      {Color? color, bool boldValue = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: boldValue ? FontWeight.bold : FontWeight.normal,
              color: color ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
