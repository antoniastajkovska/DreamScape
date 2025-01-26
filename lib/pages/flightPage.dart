import 'package:dream_scape/pages/hotelsPage.dart';
import 'package:flutter/material.dart';
import '../flights.dart';
import '../widgets/appDrawer.dart';
import '../widgets/logo.dart';

class FlightPage extends StatefulWidget {
  final String? fromPlace;
  final String? toPlace;
  final DateTime? startDate;
  final DateTime? endDate;

  const FlightPage(
      {this.fromPlace, this.toPlace, this.startDate, this.endDate, super.key});

  @override
  State<FlightPage> createState() => _FlightPageState();
}

class _FlightPageState extends State<FlightPage> {
  int seniorCount = 0;
  int adultCount = 0;
  int childCount = 0;
  double price = 0;

  List<Map<String, dynamic>> get filteredFlights {
    return flightRawData.where((flight) {
      if (widget.fromPlace != null && flight['From'] != widget.fromPlace) {
        return false;
      }
      if (widget.toPlace != null && flight['To'] != widget.toPlace) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade100,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const AppDrawer(),
      backgroundColor: Colors.lightBlue.shade100,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Center(child: LogoWidget()),
            const SizedBox(height: 40),
            SizedBox(
              height: 261,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filteredFlights.length,
                itemBuilder: (context, index) {
                  final flight = filteredFlights[index];
                  return Card(
                    margin: const EdgeInsets.only(right: 16),
                    child: SizedBox(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            flight['ImageURL'],
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '\$${flight['Price']}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'From: ${flight['From']}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  'To: ${flight['To']}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  'Departure: ${flight['DepartureDate']}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: ElevatedButton(
                              onPressed:
                                  (seniorCount + adultCount + childCount) > 0
                                      ? () {
                                          final price = flight["Price"] * (seniorCount + adultCount + childCount);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => HotelsPage(
                                                fromPlace: widget.fromPlace ??
                                                    'Unknown',
                                                toPlace:
                                                    widget.toPlace ?? 'Unknown',
                                                seniorCount: seniorCount,
                                                adultCount: adultCount,
                                                childCount: childCount,
                                                flightPrice: price,
                                              ),
                                            ),
                                          );
                                        }
                                      : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(192, 217, 247, 1.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Book Now'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCounter('Senior', seniorCount, (value) {
                  setState(() {
                    seniorCount = value;
                  });
                }),
                _buildCounter('Adult', adultCount, (value) {
                  setState(() {
                    adultCount = value;
                  });
                }),
                _buildCounter('Child', childCount, (value) {
                  setState(() {
                    childCount = value;
                  });
                }),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HotelsPage(
                        fromPlace: widget.fromPlace ?? 'Unknown',
                        toPlace: widget.toPlace ?? 'Unknown',
                        seniorCount: seniorCount,
                        adultCount: adultCount,
                        childCount: childCount,
                        flightPrice: price,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounter(String label, int value, Function(int) onChanged) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            IconButton(
              onPressed: value > 0 ? () => onChanged(value - 1) : null,
              icon: const Icon(Icons.remove_circle),
              color: Colors.red,
            ),
            Text('$value', style: const TextStyle(fontSize: 16)),
            IconButton(
              onPressed: () => onChanged(value + 1),
              icon: const Icon(Icons.add_circle),
              color: Colors.green,
            ),
          ],
        ),
      ],
    );
  }
}
