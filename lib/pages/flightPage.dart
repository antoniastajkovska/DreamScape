// ignore_for_file: file_names, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../flights.dart';
import '../widgets/logo.dart';
import '../providers/travelFormProvider.dart';
import '../providers/guestSelectorProvider.dart';
import '../main.dart';

class FlightPage extends StatelessWidget {
  const FlightPage({super.key});
  @override
  Widget build(BuildContext context) {
    final guestSel = Provider.of<GuestSelectorProvider>(context);
    return Consumer<TravelFormProvider>(
      builder: (context, provider, _) {
        final filteredFlights = flightRawData.where((flight) {
          if (provider.fromPlace == null || provider.toPlace == null)
            return false;
          if (flight['From'] != provider.fromPlace) return false;
          if (flight['To'] != provider.toPlace) return false;
          return true;
        }).toList();
        return Scaffold(
          backgroundColor: Colors.blue[200],
          appBar: AppBar(
            backgroundColor: Colors.blue[200],
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
              onPressed: () {
                Provider.of<TabProvider>(context, listen: false).setIndex(0);
              },
            ),
            title: null,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),
                  const LogoWidget(),
                  const SizedBox(height: 60),
                  const Text(
                    'Available Flights',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 28),
                  if (filteredFlights.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: Text(
                        'No flights found for your search.',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  if (filteredFlights.isNotEmpty)
                    SizedBox(
                      height: 310,
                      child: Stack(
                        children: [
                          ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 3),
                            itemCount: filteredFlights.length,
                            itemBuilder: (context, index) {
                              final flight = filteredFlights[index];
                              final totalTickets = provider.seniorCount +
                                  provider.adultCount +
                                  provider.childCount;
                              return Container(
                                width: 228,
                                margin: const EdgeInsets.only(right: 24),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.asset(
                                            flight['ImageURL'],
                                            height: 100,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          '\$${flight['Price']}',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('From: ${flight['From']}'),
                                        Text('To: ${flight['To']}'),
                                        Text(
                                            'Departure: ${flight['DepartureDate']}'),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: totalTickets > 0
                                                ? () {
                                                    final totalPrice =
                                                        flight['Price'] *
                                                            totalTickets;
                                                    provider.setFlightPrice(
                                                        totalPrice);
                                                    Provider.of<TabProvider>(
                                                            context,
                                                            listen: false)
                                                        .setIndex(2);
                                                  }
                                                : null,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.pinkAccent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            child: const Text('Book Now'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 38),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back_ios,
                              color: Colors.white54, size: 20),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  _pill(
                                    context,
                                    guestSel,
                                    0,
                                    "Senior",
                                    provider.seniorCount,
                                    () => provider.setSeniorCount(
                                        provider.seniorCount + 1),
                                    () => provider.setSeniorCount(
                                        provider.seniorCount - 1),
                                    Colors.deepPurple,
                                    Icons.elderly,
                                  ),
                                  _pill(
                                    context,
                                    guestSel,
                                    1,
                                    "Adult",
                                    provider.adultCount,
                                    () => provider
                                        .setAdultCount(provider.adultCount + 1),
                                    () => provider
                                        .setAdultCount(provider.adultCount - 1),
                                    Colors.blue,
                                    Icons.person,
                                  ),
                                  _pill(
                                    context,
                                    guestSel,
                                    2,
                                    "Child",
                                    provider.childCount,
                                    () => provider
                                        .setChildCount(provider.childCount + 1),
                                    () => provider
                                        .setChildCount(provider.childCount - 1),
                                    Colors.orange,
                                    Icons.child_care,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios,
                              color: Colors.white54, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 38),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _pill(
    BuildContext context,
    GuestSelectorProvider guestSel,
    int idx,
    String label,
    int value,
    VoidCallback add,
    VoidCallback remove,
    Color color,
    IconData icon,
  ) {
    final bool selected = guestSel.selected == idx;
    return GestureDetector(
      onTap: () => guestSel.setSelected(idx),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.22) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? color : color.withOpacity(0.5),
            width: selected ? 2.5 : 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: color.withOpacity(.19),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 6),
            Text(label,
                style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            IconButton(
              onPressed: value > 0 ? remove : null,
              icon: const Icon(Icons.remove_circle, color: Colors.red),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            Text('$value'),
            IconButton(
              onPressed: add,
              icon: const Icon(Icons.add_circle, color: Colors.green),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}
