import 'package:flutter/material.dart';
import 'favorites_screen.dart';
import 'restaurant_detail_screen.dart';
import '../widgets/restaurant_card.dart';
import 'settings_screen.dart'; // Import the settings screen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Set<String> favoriteRestaurants = Set<String>();
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> recommendedRestaurants = [
    {
      'name': 'Kopilogi',
      'image': 'assets/restaurant_a.jpg',
      'location': 'Garut',
      'rating': '4.1',
    },
    {
      'name': 'Upnormal',
      'image': 'assets/restaurant_b.jpg',
      'location': 'Garut',
      'rating': '4.3',
    },
    {
      'name': 'Jemma Coffee',
      'image': 'assets/restaurant_c.jpg',
      'location': 'Garut',
      'rating': '4.1',
    },
    {
      'name': 'Rumah Makan Cibiuk',
      'image': 'assets/restaurant_b.jpg',
      'location': 'Garut',
      'rating': '4.1',
    },
    {
      'name': 'Saung Pananjung',
      'image': 'assets/restaurant_a.jpg',
      'location': 'Garut',
      'rating': '4.2',
    },
    {
      'name': 'Racik Desa',
      'image': 'assets/restaurant_c.jpg',
      'location': 'Garut',
      'rating': '4.2',
    },
    // Add more restaurant data if needed
  ];

  List<Map<String, String>> filteredRestaurants = [];

  @override
  void initState() {
    super.initState();
    filteredRestaurants = recommendedRestaurants;
    _searchController.addListener(_filterRestaurants);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterRestaurants);
    _searchController.dispose();
    super.dispose();
  }

  void _filterRestaurants() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredRestaurants = recommendedRestaurants;
      } else {
        filteredRestaurants = recommendedRestaurants.where((restaurant) {
          final name = restaurant['name']!.toLowerCase();
          return name.contains(query);
        }).toList();
      }
    });
  }

  void _toggleFavorite(String restaurantName) {
    setState(() {
      if (favoriteRestaurants.contains(restaurantName)) {
        favoriteRestaurants.remove(restaurantName);
      } else {
        favoriteRestaurants.add(restaurantName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cari Restoran'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(
                    favoriteRestaurants: favoriteRestaurants,
                    onFavoriteToggle: _toggleFavorite,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cari restoran...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Restoran Rekomendasi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredRestaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = filteredRestaurants[index];
                  final location = restaurant['location'] ?? 'Unknown location';
                  final ratingString = restaurant['rating'] ?? '0.0';
                  final rating = double.tryParse(ratingString) ?? 0.0;

                  return RestaurantCard(
                    name: restaurant['name'] ?? 'Unknown',
                    image: restaurant['image'] ?? 'assets/placeholder.png',
                    location: location,
                    rating: rating,
                    isFavorite:
                        favoriteRestaurants.contains(restaurant['name']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurantDetailScreen(
                            name: restaurant['name'] ?? 'Unknown',
                            image:
                                restaurant['image'] ?? 'assets/placeholder.png',
                            description: 'Detail about ${restaurant['name']}',
                            address: 'Address of ${restaurant['name']}',
                            rating: rating,
                          ),
                        ),
                      );
                    },
                    onFavoriteToggle: () {
                      _toggleFavorite(restaurant['name'] ?? 'Unknown');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
