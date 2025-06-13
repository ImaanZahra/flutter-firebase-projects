import 'package:flutter/material.dart';
import 'addtrippage.dart';
import 'trip_details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Trip {
  final String city;
  final String country;
  final String date;
  final String? id;

  Trip({
    required this.city,
    required this.country,
    required this.date,
    this.id,
  });

  factory Trip.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Trip(
      city: data['city'] ?? '',
      country: data['country'] ?? '',
      date: data['date'] ?? '',
      id: doc.id,
    );
  }
}

class TripHomePage extends StatefulWidget {
  @override
  _TripHomePageState createState() => _TripHomePageState();
}

class _TripHomePageState extends State<TripHomePage> {
  final tripsCollection = FirebaseFirestore.instance.collection('trips');

  Future<void> _navigateAndAddTrip() async {
    final newTrip = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTripPage()),
    );

    if (newTrip != null && newTrip is Trip) {
      await tripsCollection.add({
        'city': newTrip.city,
        'country': newTrip.country,
        'date': newTrip.date,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Trip Destination App"),
        leading: Icon(Icons.menu),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey[800],
              child: Text("P", style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TripDetailsPage(
                      city: "Fairy Meadows",
                      country: "KPK, Pakistan",
                      date: "30 May, 2025",
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image.network(
                      'https://images.pexels.com/photos/417173/pexels-photo-417173.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 160,
                        color: Colors.grey[300],
                        child: Center(child: Icon(Icons.broken_image, size: 50)),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      color: Colors.black.withOpacity(0.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Ongoing Trip", style: TextStyle(color: Colors.white)),
                          Text("Fairy Meadows", style: TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            Text("Trips", style: TextStyle(fontSize: 18)),

            SizedBox(height: 12),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: tripsCollection.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No trips added yet.", style: TextStyle(color: Colors.grey)));
                  }

                  final trips = snapshot.data!.docs.map((doc) => Trip.fromDocument(doc)).toList();

                  return ListView.builder(
                    itemCount: trips.length,
                    itemBuilder: (context, index) {
                      final trip = trips[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TripDetailsPage(
                                city: trip.city,
                                country: trip.country,
                                date: trip.date,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade800),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(trip.city, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                                    Text(trip.country, style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 16),
                                  SizedBox(width: 6),
                                  Text(trip.date, style: TextStyle(color: Colors.white)),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: _navigateAndAddTrip,
        child: Icon(Icons.add, color: Colors.white),
        tooltip: 'Add Trip',
      ),
    );
  }
}