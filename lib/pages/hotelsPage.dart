// ignore_for_file: prefer_const_constructors

import 'package:dream_scape/main.dart';
import 'package:dream_scape/providers/travelFormProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../hotels.dart';
import '../widgets/appDrawer.dart';
import '../widgets/logo.dart';

class HotelsPage extends StatelessWidget {
  const HotelsPage({super.key});

  List<Map<String, dynamic>> filterHotels(String? toPlace) {
    if (toPlace == null || toPlace.isEmpty) return [];
    return hotelData
        .where((hotel) => hotel['city'].toLowerCase() == toPlace.toLowerCase())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TravelFormProvider>(context);
    final filteredHotels = filterHotels(provider.toPlace);

    return Scaffold(
      backgroundColor: Colors.blue[200],
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () {
            Provider.of<TabProvider>(context, listen: false).setIndex(1);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: LogoWidget()),
            const SizedBox(height: 28),
            const Center(
              child: Text(
                "Available Hotels",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: filteredHotels.isNotEmpty
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: filteredHotels.length,
                      itemBuilder: (context, index) {
                        final hotel = filteredHotels[index];
                        return HotelCard(
                          hotel: hotel,
                          flightPrice: provider.flightPrice,
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "No hotels available for your destination.",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
            ),
            const SizedBox(height: 18),
            DontBookHotelButton(
              flightPrice: provider.flightPrice,
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
  final Map<String, dynamic> hotel;
  final double flightPrice;

  const HotelCard({
    required this.hotel,
    required this.flightPrice,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TravelFormProvider>(context, listen: false);
    return Card(
      elevation: 8,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
            child: Image.asset(
              hotel['image'],
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel['name'],
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text('Price/night: \$${hotel['pricePerNight']}',
                    style: const TextStyle(fontSize: 13, color: Colors.grey)),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      provider.setSelectedHotel(hotel['name']);
                      Provider.of<TabProvider>(context, listen: false)
                          .setIndex(3); // Go to TaxiPage
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Book Now',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DontBookHotelButton extends StatelessWidget {
  final double flightPrice;

  const DontBookHotelButton({
    required this.flightPrice,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TravelFormProvider>(context, listen: false);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          provider.setSelectedHotel('');
          Provider.of<TabProvider>(context, listen: false).setIndex(3);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pinkAccent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        child: const Text(
          "Don't book hotel",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
