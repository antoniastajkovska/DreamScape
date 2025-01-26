import 'package:flutter/material.dart';
import '../widgets/appDrawer.dart';
import '../widgets/logo.dart';

class ReceiptPage extends StatelessWidget {
  final String fromPlace;
  final String toPlace;
  final String hotel;
  final int seniorTickets;
  final int adultTickets;
  final int childTickets;
  final bool taxiChosen;
  final double totalPrice;

  const ReceiptPage({
    super.key,
    required this.fromPlace,
    required this.toPlace,
    required this.hotel,
    required this.seniorTickets,
    required this.adultTickets,
    required this.childTickets,
    required this.taxiChosen,
    required this.totalPrice,
  });

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
            const SizedBox(height: 30),
            const Center(child: LogoWidget()),
            const SizedBox(height: 40),
            Center(
              child: Column(
                children: [
                  const Text(
                    "Name: Jon Doe",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Flight: $fromPlace - $toPlace",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Hotel: $hotel",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Tickets: Senior: $seniorTickets, Adult: $adultTickets, Children: $childTickets",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Taxi: ${taxiChosen ? 'chosen' : 'not chosen'}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Total price: \$${totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle payment logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Pay',
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
