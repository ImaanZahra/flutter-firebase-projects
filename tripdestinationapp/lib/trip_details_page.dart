import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TripDetailsPage extends StatefulWidget {
  final String city;
  final String country;
  final String date;

  TripDetailsPage({
    required this.city,
    required this.country,
    required this.date,
  });

  @override
  _TripDetailsPageState createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
  LatLng? coordinates;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchCoordinates();
  }

  Future<void> fetchCoordinates() async {
    final query = '${widget.city}, ${widget.country}';
    final url = Uri.parse('https://nominatim.openstreetmap.org/search?q=$query&format=json');

    try {
      final response = await http.get(url, headers: {
        'User-Agent': 'FlutterTripApp/1.0',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data.length > 0) {
          final lat = double.parse(data[0]['lat']);
          final lon = double.parse(data[0]['lon']);

          setState(() {
            coordinates = LatLng(lat, lon);
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = 'No location found.';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Failed to load map data.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Trip Details', style: textTheme.titleLarge),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: colorScheme.secondary))
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.red)))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                widget.city,
                style: textTheme.headlineSmall?.copyWith(color: Colors.white),
              ),
              subtitle: Text(widget.country, style: textTheme.bodyMedium),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today, size: 16, color: colorScheme.secondary),
                  Text(widget.date, style: textTheme.bodySmall),
                ],
              ),
            ),
            SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: screenHeight * 0.3,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: FlutterMap(
                  options: MapOptions(
                    center: coordinates,
                    zoom: 13.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                      userAgentPackageName: 'com.example.tripdestinationapp',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: coordinates!,
                          width: 60,
                          height: 60,
                          builder: (ctx) => Icon(Icons.location_pin,
                              size: 40, color: colorScheme.secondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Famous Spots in ${widget.city}',
              style: textTheme.titleMedium?.copyWith(fontSize: 18),
            ),
            SizedBox(height: 12),
            Column(
              children: _getLandmarks(widget.city)
                  .map((landmark) => _buildPlaceTile(
                  landmark['title']!,
                  landmark['subtitle']!,
                  colorScheme,
                  textTheme))
                  .toList(),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceTile(String title, String subtitle, ColorScheme colorScheme, TextTheme textTheme) {
    return ListTile(
      leading: Icon(Icons.place, color: colorScheme.secondary),
      title: Text(title, style: textTheme.bodyMedium?.copyWith(color: Colors.white)),
      subtitle: Text(subtitle, style: textTheme.bodySmall?.copyWith(color: Colors.grey)),
    );
  }

  List<Map<String, String>> _getLandmarks(String city) {
    switch (city.toLowerCase()) {
      case 'paris':
        return [
          {'title': 'Eiffel Tower', 'subtitle': 'Champ de Mars, 5 Avenue Anatole France'},
          {'title': 'Louvre Museum', 'subtitle': 'Rue de Rivoli'},
          {'title': 'Notre-Dame Cathedral', 'subtitle': '6 Parvis Notre-Dame'},
        ];
      case 'tokyo':
        return [
          {'title': 'Tokyo Tower', 'subtitle': 'Shibakoen, Minato'},
          {'title': 'Senso-ji Temple', 'subtitle': 'Asakusa, Taito'},
          {'title': 'Shibuya Crossing', 'subtitle': 'Shibuya City'},
        ];
      case 'new york':
        return [
          {'title': 'Statue of Liberty', 'subtitle': 'Liberty Island'},
          {'title': 'Central Park', 'subtitle': 'Manhattan'},
          {'title': 'Times Square', 'subtitle': 'Midtown Manhattan'},
        ];
      case 'london':
        return [
          {'title': 'Big Ben', 'subtitle': 'Westminster'},
          {'title': 'London Eye', 'subtitle': 'South Bank'},
          {'title': 'Tower Bridge', 'subtitle': 'Tower Bridge Road'},
        ];
      case 'sydney':
        return [
          {'title': 'Sydney Opera House', 'subtitle': 'Bennelong Point'},
          {'title': 'Harbour Bridge', 'subtitle': 'Sydney Harbour'},
          {'title': 'Bondi Beach', 'subtitle': 'Bondi, NSW'},
        ];
      case 'rome':
        return [
          {'title': 'Colosseum', 'subtitle': 'Piazza del Colosseo'},
          {'title': 'Trevi Fountain', 'subtitle': 'Piazza di Trevi'},
          {'title': 'Pantheon', 'subtitle': 'Piazza della Rotonda'},
        ];
      case 'istanbul':
        return [
          {'title': 'Hagia Sophia', 'subtitle': 'Sultanahmet'},
          {'title': 'Blue Mosque', 'subtitle': 'Sultan Ahmet Mahallesi'},
          {'title': 'Topkapi Palace', 'subtitle': 'Cankurtaran, Fatih'},
        ];
      case 'cairo':
        return [
          {'title': 'Pyramids of Giza', 'subtitle': 'Giza Plateau'},
          {'title': 'Egyptian Museum', 'subtitle': 'Tahrir Square'},
          {'title': 'Khan el-Khalili', 'subtitle': 'Islamic Cairo'},
        ];
      case 'dubai':
        return [
          {'title': 'Burj Khalifa', 'subtitle': 'Downtown Dubai'},
          {'title': 'Palm Jumeirah', 'subtitle': 'Artificial Archipelago'},
          {'title': 'Dubai Mall', 'subtitle': 'Financial Center Rd'},
        ];
      case 'bangkok':
        return [
          {'title': 'Grand Palace', 'subtitle': 'Na Phra Lan Rd'},
          {'title': 'Wat Arun', 'subtitle': 'Temple of Dawn'},
          {'title': 'Chatuchak Market', 'subtitle': 'Kamphaeng Phet 2 Rd'},
        ];
      default:
        return [
          {'title': 'Landmark 1', 'subtitle': 'Unknown'},
          {'title': 'Landmark 2', 'subtitle': 'Unknown'},
          {'title': 'Landmark 3', 'subtitle': 'Unknown'},
        ];
    }
  }
}