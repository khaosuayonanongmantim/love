import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:project_new/HomeNavbar/ZoneDetailSportPage.dart';

class SportPlan extends StatefulWidget {
  final String imagePath;
  final String concertName;
  final String date;
  final String time;
  final String location;

  const SportPlan({
    Key? key,
    required this.imagePath,
    required this.concertName,
    required this.date,
    required this.time,
    required this.location,
  }) : super(key: key);

  @override
  State<SportPlan> createState() => _SportPlanState();
}

class _SportPlanState extends State<SportPlan> {
  late Timer _timer;
  int _remainingTime = 300; // 300 seconds = 5 minutes

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer.cancel();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('หมดเวลาทำรายการ'),
            content: const Text('กรุณาเริ่มการจองใหม่'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('ตกลง'),
              ),
            ],
          ),
        );
      }
    });
  }

  String formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Widget buildSeatLayout() {
    final double radius = 120; // Radius of the circular layout
    final List<String> zones = [
      'AA1',
      'AA2',
      'AA3',
      'AA4',
      'AA5',
      'AA6',
      'AA7',
      'AA8',
      'AA9',
      'AA10'
    ];

    return SizedBox(
      width: radius * 2 + 50,
      height: radius * 2 + 50,
      child: Stack(
        children: [
          // Stage
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'STAGE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),

          // Seats around the stage
          ...List.generate(zones.length, (index) {
            final double angle = 2 * pi * index / zones.length;
            final double x = radius + radius * cos(angle);
            final double y = radius + radius * sin(angle);

            return Positioned(
              left: x,
              top: y,
              child: GestureDetector(
                onTap: () {
                  debugPrint('Selected Zone: ${zones[index]}');
                },
                child: Container(
                  width: 60,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    zones[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget buildSeatList() {
    final List<Map<String, String>> seats = List.generate(
      10,
      (index) => {
        'seat': 'AA${index + 1}',
        'name': 'Cenzonic Concert',
        'price': '฿2,500',
      },
    );

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: seats.length,
      itemBuilder: (context, index) {
        final seat = seats[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4,
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blueAccent,
                child: Text(
                  seat['seat']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              title: Text(seat['name']!),
              subtitle: Text(seat['price']!),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ZoneDetailSportPage(
                        zoneName: seat['seat']!,
                        selectedPrice: seat['price']!,
                        imagePath: widget.imagePath,
                        concertName: widget.concertName,
                        date: widget.date,
                        time: widget.time,
                        location: widget.location,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('จองโซนที่นั่ง',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แผนผังโซนที่นั่ง'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Timer
            Text(
              'เวลาที่ทำรายการ: ${formatTime(_remainingTime)}',
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Seating plan
            Center(
              child: buildSeatLayout(),
            ),

            const SizedBox(height: 20),

            // List of seats and prices
            buildSeatList(),
          ],
        ),
      ),
    );
  }
}
