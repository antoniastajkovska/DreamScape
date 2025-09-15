import 'package:dream_scape/pages/receiptPage.dart';
import 'package:dream_scape/pages/taxiPage.dart';
import 'package:dream_scape/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import 'pages/homePage.dart';
import 'pages/flightPage.dart';
import 'pages/hotelsPage.dart';
import 'providers/travelFormProvider.dart';
import 'providers/guestSelectorProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TravelFormProvider()),
        ChangeNotifierProvider(create: (_) => TabProvider()),
        ChangeNotifierProvider(create: (_) => GuestSelectorProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class TabProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DreamScape',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3765A3),
          primary: const Color(0xFF3765A3),
          secondary: const Color(0xFFD72660),
        ),
        useMaterial3: true,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<Widget> screens = [
    HomePage(),
    FlightPage(),
    HotelsPage(),
    TaxiPage(),
    ReceiptPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final tabProvider = Provider.of<TabProvider>(context);

    return Scaffold(
      body: screens[tabProvider.currentIndex],
      bottomNavigationBar: SafeArea(
        child: GNav(
          selectedIndex: tabProvider.currentIndex,
          onTabChange: (index) {
            tabProvider.setIndex(index);
          },
          backgroundColor: Colors.pinkAccent,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.pink[300]!,
          padding: const EdgeInsets.all(16),
          tabs: const [
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.flight, text: 'Flights'),
            GButton(icon: Icons.hotel, text: 'Hotels'),
            GButton(icon: Icons.local_taxi, text: 'Taxis'),
            GButton(icon: Icons.receipt, text: 'Receipts'),
          ],
        ),
      ),
    );
  }
}
