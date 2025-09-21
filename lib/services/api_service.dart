import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8080');

  // Flight API calls
  static Future<List<Flight>> searchFlights({
    String? fromCity,
    String? toCity,
    String? departureDate,
  }) async {
    final queryParams = <String, String>{};
    if (fromCity != null) queryParams['fromCity'] = fromCity;
    if (toCity != null) queryParams['toCity'] = toCity;
    if (departureDate != null) queryParams['departureDate'] = departureDate;

    final uri = Uri.parse('$_baseUrl/api/travel/flights').replace(queryParameters: queryParams);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Flight.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load flights: ${response.statusCode}');
    }
  }

  static Future<Flight?> getFlightById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/api/travel/flights/$id'));
    
    if (response.statusCode == 200) {
      return Flight.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to load flight: ${response.statusCode}');
    }
  }

  // Hotel API calls
  static Future<List<Hotel>> searchHotels({String? city}) async {
    final queryParams = <String, String>{};
    if (city != null) queryParams['city'] = city;

    final uri = Uri.parse('$_baseUrl/api/travel/hotels').replace(queryParameters: queryParams);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Hotel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load hotels: ${response.statusCode}');
    }
  }

  static Future<Hotel?> getHotelById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/api/travel/hotels/$id'));
    
    if (response.statusCode == 200) {
      return Hotel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to load hotel: ${response.statusCode}');
    }
  }

  // Taxi API calls
  static Future<List<Taxi>> getAllTaxis() async {
    final response = await http.get(Uri.parse('$_baseUrl/api/travel/taxis'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Taxi.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load taxis: ${response.statusCode}');
    }
  }

  static Future<Taxi?> getTaxiById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/api/travel/taxis/$id'));
    
    if (response.statusCode == 200) {
      return Taxi.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to load taxi: ${response.statusCode}');
    }
  }

  // Booking API calls
  static Future<Booking> createBooking(Booking booking) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/travel/bookings'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(booking.toJson()),
    );

    if (response.statusCode == 200) {
      return Booking.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create booking: ${response.statusCode}');
    }
  }

  static Future<List<Booking>> getUserBookings(String userEmail) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/travel/bookings').replace(queryParameters: {'userEmail': userEmail}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Booking.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load bookings: ${response.statusCode}');
    }
  }
}

// Model classes
class Flight {
  final int id;
  final String fromCity;
  final String toCity;
  final double price;
  final String imageUrl;
  final String departureDate;

  Flight({
    required this.id,
    required this.fromCity,
    required this.toCity,
    required this.price,
    required this.imageUrl,
    required this.departureDate,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      id: json['id'],
      fromCity: json['fromCity'],
      toCity: json['toCity'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
      departureDate: json['departureDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fromCity': fromCity,
      'toCity': toCity,
      'price': price,
      'imageUrl': imageUrl,
      'departureDate': departureDate,
    };
  }
}

class Hotel {
  final int id;
  final String name;
  final double pricePerNight;
  final String city;
  final String imageUrl;

  Hotel({
    required this.id,
    required this.name,
    required this.pricePerNight,
    required this.city,
    required this.imageUrl,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'],
      name: json['name'],
      pricePerNight: (json['pricePerNight'] as num).toDouble(),
      city: json['city'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pricePerNight': pricePerNight,
      'city': city,
      'imageUrl': imageUrl,
    };
  }
}

class Taxi {
  final int id;
  final String provider;
  final String type;
  final double price;
  final String imageUrl;
  final String estimatedTime;

  Taxi({
    required this.id,
    required this.provider,
    required this.type,
    required this.price,
    required this.imageUrl,
    required this.estimatedTime,
  });

  factory Taxi.fromJson(Map<String, dynamic> json) {
    return Taxi(
      id: json['id'],
      provider: json['provider'],
      type: json['type'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
      estimatedTime: json['estimatedTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provider': provider,
      'type': type,
      'price': price,
      'imageUrl': imageUrl,
      'estimatedTime': estimatedTime,
    };
  }
}

class Booking {
  final int? id;
  final String userEmail;
  final String fromPlace;
  final String toPlace;
  final String startDate;
  final String endDate;
  final int seniorCount;
  final int adultCount;
  final int childCount;
  final double flightPrice;
  final int? selectedFlightId;
  final String? selectedHotel;
  final int? selectedHotelId;
  final double? hotelPrice;
  final bool taxiChosen;
  final int? selectedTaxiId;
  final double? taxiPrice;
  final double? totalPrice;
  final String? bookingDate;

  Booking({
    this.id,
    required this.userEmail,
    required this.fromPlace,
    required this.toPlace,
    required this.startDate,
    required this.endDate,
    required this.seniorCount,
    required this.adultCount,
    required this.childCount,
    required this.flightPrice,
    this.selectedFlightId,
    this.selectedHotel,
    this.selectedHotelId,
    this.hotelPrice,
    required this.taxiChosen,
    this.selectedTaxiId,
    this.taxiPrice,
    this.totalPrice,
    this.bookingDate,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      userEmail: json['userEmail'],
      fromPlace: json['fromPlace'],
      toPlace: json['toPlace'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      seniorCount: json['seniorCount'],
      adultCount: json['adultCount'],
      childCount: json['childCount'],
      flightPrice: (json['flightPrice'] as num).toDouble(),
      selectedFlightId: json['selectedFlightId'],
      selectedHotel: json['selectedHotel'],
      selectedHotelId: json['selectedHotelId'],
      hotelPrice: json['hotelPrice'] != null ? (json['hotelPrice'] as num).toDouble() : null,
      taxiChosen: json['taxiChosen'],
      selectedTaxiId: json['selectedTaxiId'],
      taxiPrice: json['taxiPrice'] != null ? (json['taxiPrice'] as num).toDouble() : null,
      totalPrice: json['totalPrice'] != null ? (json['totalPrice'] as num).toDouble() : null,
      bookingDate: json['bookingDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userEmail': userEmail,
      'fromPlace': fromPlace,
      'toPlace': toPlace,
      'startDate': startDate,
      'endDate': endDate,
      'seniorCount': seniorCount,
      'adultCount': adultCount,
      'childCount': childCount,
      'flightPrice': flightPrice,
      if (selectedFlightId != null) 'selectedFlightId': selectedFlightId,
      if (selectedHotel != null) 'selectedHotel': selectedHotel,
      if (selectedHotelId != null) 'selectedHotelId': selectedHotelId,
      if (hotelPrice != null) 'hotelPrice': hotelPrice,
      'taxiChosen': taxiChosen,
      if (selectedTaxiId != null) 'selectedTaxiId': selectedTaxiId,
      if (taxiPrice != null) 'taxiPrice': taxiPrice,
      if (totalPrice != null) 'totalPrice': totalPrice,
      if (bookingDate != null) 'bookingDate': bookingDate,
    };
  }
}
