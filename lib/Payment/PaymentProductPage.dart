import 'package:flutter/material.dart';
import 'package:project_new/Payment/ReceiptProductPage.dart';

class PaymentProductPage extends StatelessWidget {
  final Map<int, int> itemCounts;
  final List<Map<String, String>> items;

  PaymentProductPage({required this.itemCounts, required this.items});

  // ฟังก์ชันคำนวณราคารวม
  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (int i = 0; i < items.length; i++) {
      final itemCount = itemCounts[i] ?? 0;
      if (itemCount > 0) {
        final price = double.tryParse(items[i]['newPrice']!.replaceAll('\$', '')) ?? 0.0;
        totalPrice += price * itemCount;
      }
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = calculateTotalPrice(); // คำนวณราคารวม

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Confirmation'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final itemCount = itemCounts[index] ?? 0;

          if (itemCount > 0) {
            return ListTile(
              leading: Image.asset(items[index]['image']!),
              title: Text(items[index]['title']!),
              subtitle: Text('Quantity: $itemCount'),
              trailing: Text(items[index]['newPrice']!),
            );
          } else {
            return SizedBox.shrink(); // ซ่อนรายการที่ไม่ได้เลือก
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // แสดงราคาทั้งหมด
            Text(
              'Total: \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // นำทางไปหน้าชำระเงินและส่งข้อมูลสินค้าไป
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReceiptProductPage(
                      itemCounts: itemCounts,
                      items: items,
                      totalPrice: totalPrice,
                    ),
                  ),
                );
              },
              child: Text('ไปที่หน้าชำระเงิน'),
            ),
          ],
        ),
      ),
    );
  }
}
