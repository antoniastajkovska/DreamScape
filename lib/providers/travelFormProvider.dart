import 'package:flutter/material.dart';

class TravelFormProvider extends ChangeNotifier {
  String? fromPlace;
  String? toPlace;
  DateTime? startDate;
  DateTime? endDate;

  int seniorCount = 0;
  int adultCount = 0;
  int childCount = 0;
  double flightPrice = 0;

  bool taxiChosen = false;
  double taxiPrice = 0;
  String? selectedHotel;

  void setSelectedHotel(String hotel) {
    selectedHotel = hotel;
    notifyListeners();
  }

  void setFromPlace(String value) {
    fromPlace = value;
    notifyListeners();
  }

  void setToPlace(String value) {
    toPlace = value;
    notifyListeners();
  }

  void setStartDate(DateTime date) {
    startDate = date;
    notifyListeners();
  }

  void setEndDate(DateTime? date) {
    endDate = date;
    notifyListeners();
  }

  void setSeniorCount(int value) {
    seniorCount = value;
    notifyListeners();
  }

  void setAdultCount(int value) {
    adultCount = value;
    notifyListeners();
  }

  void setChildCount(int value) {
    childCount = value;
    notifyListeners();
  }

  void setFlightPrice(double price) {
    flightPrice = price;
    notifyListeners();
  }

  void setTaxiChosen(bool chosen) {
    taxiChosen = chosen;
    notifyListeners();
  }

  void setTaxiPrice(double price) {
    taxiPrice = price;
    notifyListeners();
  }

  bool get isFormValid =>
      fromPlace != null &&
      toPlace != null &&
      startDate != null &&
      endDate != null;
}
