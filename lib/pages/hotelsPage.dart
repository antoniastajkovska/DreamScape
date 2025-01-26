import 'package:dream_scape/pages/taxiPage.dart';
import 'package:flutter/material.dart';
import '../hotels.dart';
import '../widgets/appDrawer.dart';
import '../widgets/logo.dart';

class HotelsPage extends StatelessWidget {
  final String toPlace;
  final String fromPlace;
  final int seniorCount;
  final int adultCount;
  final int childCount;
  final double flightPrice;

  const HotelsPage({
    required this.toPlace,
    required this.seniorCount,
    required this.adultCount,
    required this.childCount,
    required this.fromPlace,
    super.key,
    required this.flightPrice,
  });

  List<Map<String, dynamic>> get filteredHotels {
    return hotelData.where((hotel) {
      return hotel['city'].toLowerCase() == toPlace.toLowerCase();
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
            const SizedBox(height: 30),
            const Center(child: LogoWidget()),
            const SizedBox(height: 40),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.6, // Adjusted to make the cards taller
                ),
                itemCount: filteredHotels.length,
                itemBuilder: (context, index) {
                  final hotel = filteredHotels[index];
                  return HotelCard(
                    hotel: hotel,
                    fromPlace: fromPlace,
                    toPlace: toPlace,
                    seniorCount: seniorCount,
                    adultCount: adultCount,
                    childCount: childCount,
                    flightPrice: flightPrice,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            NextButton(
              fromPlace: fromPlace,
              toPlace: toPlace,
              seniorCount: seniorCount,
              adultCount: adultCount,
              childCount: childCount,
              flightPrice: flightPrice,
            ),
          ],
        ),
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
  final Map<String, dynamic> hotel;
  final String fromPlace;
  final String toPlace;
  final int seniorCount;
  final int adultCount;
  final int childCount;
  final double flightPrice;

  const HotelCard({
    super.key,
    required this.hotel,
    required this.fromPlace,
    required this.toPlace,
    required this.seniorCount,
    required this.adultCount,
    required this.childCount,
    required this.flightPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              hotel['image'],
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Price per night: \$${hotel['pricePerNight']}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    final totalPrice = hotel['pricePerNight'] + flightPrice;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaxiPage(
                          fromPlace: fromPlace,
                          toPlace: toPlace,
                          seniorCount: seniorCount,
                          adultCount: adultCount,
                          childCount: childCount,
                          selectedHotel: hotel['name'],
                          totalPrice: totalPrice,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(192, 217, 247, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Book Now'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  final String fromPlace;
  final String toPlace;
  final int seniorCount;
  final int adultCount;
  final int childCount;
  final double flightPrice;

  const NextButton({
    required this.fromPlace,
    required this.toPlace,
    required this.seniorCount,
    required this.adultCount,
    required this.childCount,
    required this.flightPrice,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaxiPage(
                fromPlace: fromPlace,
                toPlace: toPlace,
                seniorCount: seniorCount,
                adultCount: adultCount,
                childCount: childCount,
                selectedHotel: '',
                totalPrice: flightPrice,
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
    );
  }
}
