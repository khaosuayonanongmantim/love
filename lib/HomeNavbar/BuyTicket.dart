import 'package:flutter/material.dart';
import 'package:project_new/PageReserveTicket/ZoneALPage.dart';
import 'package:project_new/PageReserveTicket/ZoneARPage.dart';
import 'package:project_new/PageReserveTicket/ZoneVIPPage.dart';
import 'package:project_new/PageReserveTicket/ZoneCLPage.dart';
import 'package:project_new/PageReserveTicket/ZoneCRPage.dart';
import 'package:project_new/PageReserveTicket/ZoneDLPage.dart';
import 'package:project_new/PageReserveTicket/ZoneDRPage.dart';

class ConcertPlan extends StatefulWidget {
  const ConcertPlan({super.key});

  @override
  State<ConcertPlan> createState() => _ConcertPlanState();
}

class _ConcertPlanState extends State<ConcertPlan> {
  void _bookSeat(String zone) {
    final pageMap = {
      'AL': ZoneALPage(),
      'AR': ZoneARPage(),
      'VIP': ZoneVIPPage(),
      'CL': ZoneCLPage(),
      'CR': ZoneCRPage(),
      'DL': ZoneDLPage(),
      'DR': ZoneDRPage(),
    };

    if (pageMap.containsKey(zone)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => pageMap[zone]!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แผนผังโซนที่นั่ง'),
      ),
      body: Center(
        child: Container(
          color: Color.fromARGB(255, 168, 210, 238),
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // Stage
              Positioned(
                top: 20,
                width: MediaQuery.of(context).size.width * 0.7,
                height: 50,
                child: buildZone("STAGE", Colors.grey[800]!, Colors.white),
              ),
              // AL and AR zones
              Positioned(
                top: 80,
                left: MediaQuery.of(context).size.width * 0.1,
                height: 50,
                width: 120,
                child: buildZone("AL", Colors.yellow, Colors.black),
              ),
              Positioned(
                top: 80,
                right: MediaQuery.of(context).size.width * 0.1,
                height: 50,
                width: 120,
                child: buildZone("AR", Colors.yellow, Colors.black),
              ),
              // BL and BR zones
              Positioned(
                top: 140,
                left: MediaQuery.of(context).size.width * 0.1,
                height: 50,
                width: 80,
                child: buildZone("BL", Colors.orange, Colors.black),
              ),
              Positioned(
                top: 140,
                right: MediaQuery.of(context).size.width * 0.1,
                height: 50,
                width: 80,
                child: buildZone("BR", Colors.orange, Colors.black),
              ),
              // VIP zone
              Positioned(
                top: 140,
                width: 100,
                height: 50,
                child: buildZone("VIP", Colors.redAccent, Colors.white),
              ),
              // CL and CR zones
              Positioned(
                top: 200,
                left: MediaQuery.of(context).size.width * 0.1,
                height: 60,
                width: 110,
                child: buildZone("CL", Colors.lightGreen, Colors.black),
              ),
              Positioned(
                top: 200,
                right: MediaQuery.of(context).size.width * 0.1,
                height: 60,
                width: 110,
                child: buildZone("CR", Colors.lightGreen, Colors.black),
              ),
              // DL and DR zones
              Positioned(
                top: 270,
                left: MediaQuery.of(context).size.width * 0.1,
                height: 60,
                width: 90,
                child: buildZone("DL", Colors.purpleAccent, Colors.white),
              ),
              Positioned(
                top: 270,
                right: MediaQuery.of(context).size.width * 0.1,
                height: 60,
                width: 90,
                child: buildZone("DR", Colors.purpleAccent, Colors.white),
              ),
              // Text details below the zones
              Positioned(
                bottom: 3,
                left: 10,
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildZoneDetail("AL", "โซน AL"),
                        buildZoneDetail("AR", "โซน AR"),
                        buildZoneDetail("VIP", "โซน VIP"),
                        buildZoneDetail("CL", "โซน CL"),
                        buildZoneDetail("CR", "โซน CR"),
                        buildZoneDetail("DL", "โซน DL"),
                        buildZoneDetail("DR", "โซน DR"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildZone(String label, Color color, Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(1.5),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Color.fromRGBO(40, 19, 145, 1), width: 2),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildZoneDetail(String zoneLabel, String description) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
              color: Color.fromARGB(246, 10, 8, 8),
              fontSize: 15,
              fontWeight: FontWeight.bold, // Make description text bold
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(90, 30),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: Color.fromARGB(255, 146, 119, 252),
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            _bookSeat(zoneLabel);
          },
          child: const Text("จองที่นั่ง"),
        ),
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(home: ConcertPlan()));
}
