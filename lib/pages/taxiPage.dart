import 'package:dream_scape/pages/receiptPage.dart';
import 'package:flutter/material.dart';
import '../widgets/appDrawer.dart';
import '../widgets/logo.dart';

class TaxiPage extends StatefulWidget {
  final String toPlace;
  final String fromPlace;
  final int seniorCount;
  final int adultCount;
  final int childCount;
  final String selectedHotel;
  final double totalPrice;

  const TaxiPage({
    super.key,
    required this.toPlace,
    required this.fromPlace,
    required this.seniorCount,
    required this.adultCount,
    required this.childCount,
    required this.selectedHotel, required this.totalPrice});

  @override
  State<TaxiPage> createState() => _TaxiPageState();
}

class _TaxiPageState extends State<TaxiPage> {
  bool showTaxiImage = false;
  bool taxi = false;

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
            const Center(
              child: Text(
                "Do you need a taxi?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showTaxiImage = true;
                      taxi = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 221, 240, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Yes"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showTaxiImage = false;
                      taxi = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReceiptPage(
                          fromPlace: widget.fromPlace,
                          toPlace: widget.toPlace,
                          seniorTickets: widget.seniorCount,
                          adultTickets: widget.adultCount,
                          childTickets: widget.childCount,
                          hotel: widget.selectedHotel,
                          taxiChosen: taxi,
                          totalPrice: widget.totalPrice,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 221, 240, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("No"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Taxi Image
            if (showTaxiImage)
              Center(
                child: Image.asset(
                  'lib/assets/images/taxi_image.png',
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReceiptPage(
                        fromPlace: widget.fromPlace,
                        toPlace: widget.toPlace,
                        seniorTickets: widget.seniorCount,
                        adultTickets: widget.adultCount,
                        childTickets: widget.childCount,
                        hotel: widget.selectedHotel,
                        taxiChosen: taxi,
                        totalPrice: widget.totalPrice,
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
}
