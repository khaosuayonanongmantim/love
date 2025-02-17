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
        final price =
            double.tryParse(items[i]['newPrice']!.replaceAll('\$', '')) ?? 0.0;
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
        backgroundColor: const Color.fromARGB(255, 255, 135, 175),
      ),
      backgroundColor:
          Color(0xFFFFE4E1), // Set background color to fill the screen
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // รายการสินค้า
              ListView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final itemCount = itemCounts[index] ?? 0;

                  if (itemCount > 0) {
                    final imageUrl = items[index]['image'] ??
                        'http://via.placeholder.com/150';

                    return Card(
                      margin: EdgeInsets.only(bottom: 16),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        // leading: SizedBox(
                        //   width: 60,
                        //   height: 60,
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(10),
                        //     child: Image.network(
                        //       imageUrl,
                        //       fit: BoxFit.cover,
                        //       loadingBuilder:
                        //           (context, child, loadingProgress) {
                        //         if (loadingProgress == null) return child;
                        //         return Center(
                        //           child: CircularProgressIndicator(
                        //             value: loadingProgress.expectedTotalBytes !=
                        //                     null
                        //                 ? loadingProgress
                        //                         .cumulativeBytesLoaded /
                        //                     (loadingProgress
                        //                             .expectedTotalBytes ??
                        //                         1)
                        //                 : null,
                        //           ),
                        //         );
                        //       },
                        //       errorBuilder: (context, error, stackTrace) {
                        //         return Image.asset(
                        //             'assets/images/default_image.jpg');
                        //       },
                        //     ),
                        //   ),
                        // ),
                        title: Text(
                          items[index]['title']!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(
                              top: 18.0), // เพิ่มระยะห่างจากด้านบน
                          child: Text(
                            'Quantity: $itemCount',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(
                              top: 38.0), // เพิ่มระยะห่างจากด้านบน

                          child: Text(
                            items[index]['newPrice']!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16,color: Colors.red),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Ensures column doesn't take extra space
          children: [
            // Row for the total price
            Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // เปลี่ยนเป็น .center
                children: [
                  Text(
                    'Total: \$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16), // Add space between total price and button
            // Elevated Button to go to payment page
            ElevatedButton(
              onPressed: () {
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
              child: Text('ไปที่หน้าชำระเงิน',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 255, 26, 121), // สีชมพูเข้ม
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
