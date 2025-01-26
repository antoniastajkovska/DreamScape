import 'package:flutter/material.dart';
import '../widgets/appDrawer.dart';
import '../widgets/logo.dart';
import 'flightPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? fromPlace;
  String? toPlace;
  DateTime? startDate;
  DateTime? endDate;

  final List<String> places = [
    'New York',
    'London',
    'Paris',
    'Tokyo',
    'Sydney',
    'Skopje',
    'Amsterdam'
  ];

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (startDate ?? now)
          : (endDate ?? startDate ?? now),
      firstDate: isStartDate
          ? now
          : (startDate != null ? startDate! : now),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          startDate = pickedDate;
          if (endDate != null && endDate!.isBefore(pickedDate)) {
            endDate = null;
          }
        } else {
          endDate = pickedDate;
        }
      });
    }
  }

  bool get _isFormValid =>
      fromPlace != null &&
          toPlace != null &&
          startDate != null &&
          endDate != null;

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Center(child: LogoWidget()),
            const SizedBox(height: 40),
            Row(
              children: [
                const Text(
                  'From:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: fromPlace,
                    hint: const Text('Select a place'),
                    items: places.map((place) {
                      return DropdownMenuItem(
                        value: place,
                        child: Text(place),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        fromPlace = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const Text(
                  'Destination:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: toPlace,
                    hint: const Text('Select a place'),
                    items: places.map((place) {
                      return DropdownMenuItem(
                        value: place,
                        child: Text(place),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        toPlace = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const Text(
                  'Choose a date from:',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () => _pickDate(context, true),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 10,
                        ),
                      ),
                      child: Text(
                        startDate != null
                            ? '${startDate!.month}/${startDate!.day}/${startDate!.year}'
                            : 'mm/dd/yyyy',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const Text(
                  'Choose a date to:',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () => _pickDate(context, false),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 10,
                        ),
                      ),
                      child: Text(
                        endDate != null
                            ? '${endDate!.month}/${endDate!.day}/${endDate!.year}'
                            : 'mm/dd/yyyy',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Spacer(), // Pushes the button to the bottom
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isFormValid
                    ? () {
                  // Navigate to FlightPage with data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FlightPage(
                        fromPlace: fromPlace ?? 'Unknown',
                        toPlace: toPlace ?? 'Unknown',
                        startDate: startDate,
                        endDate: endDate,
                      ),
                    ),
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Search',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}