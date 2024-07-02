import 'package:flutter/material.dart';
import 'restaurant_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final Set<String> favoriteRestaurants;
  final Function(String) onFavoriteToggle;

  FavoritesScreen({
    required this.favoriteRestaurants,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    // Example data for favorite restaurants; replace with actual data in a real app.
    final favoriteDetails = {
      'Kopilogi': {
        'image': 'assets/restaurant_a.jpg',
        'description': 'A cozy place to enjoy various kinds of coffee.',
        'address': 'Jl. Garut No. 1, Garut',
        'rating': 4.1,
      },
      'Upnormal': {
        'image': 'assets/restaurant_b.jpg',
        'description': 'A modern cafe with a variety of delicious snacks.',
        'address': 'Jl. Garut No. 2, Garut',
        'rating': 4.3,
      },
      'Jemma Coffe': {
        'image': 'assets/restaurant_c.jpg',
        'description':
            'The best place to hang out with friends and enjoy coffee.',
        'address': 'Jl. Garut No. 3, Garut',
        'rating': 4.0,
      },
      'Rumah Makan Cibiuk': {
        'image': 'assets/restaurant_b.jpg',
        'description':
            'The best place to hang out with friends and enjoy coffee.',
        'address': 'Jl. Garut No. 3, Garut',
        'rating': 4.5,
      },
      'Saung Pananjung': {
        'image': 'assets/restaurant_a.jpg',
        'description':
            'The best place to hang out with friends and enjoy coffee.',
        'address': 'Jl. Garut No. 3, Garut',
        'rating': 4.4,
      },
      'Racik Desa': {
        'image': 'assets/restaurant_c.jpg',
        'description':
            'The best place to hang out with friends and enjoy coffee.',
        'address': 'Jl. Garut No. 3, Garut',
        'rating': 4.3,
      },

      // Add more favorite details if needed
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorit'),
        backgroundColor: Colors.teal,
      ),
      body: favoriteRestaurants.isEmpty
          ? Center(
              child: Text('Belum ada restoran favorit'),
            )
          : ListView.builder(
              itemCount: favoriteRestaurants.length,
              itemBuilder: (context, index) {
                final restaurantName = favoriteRestaurants.elementAt(index);
                final details = favoriteDetails[restaurantName];

                if (details == null) {
                  return Container();
                }

                return ListTile(
                  leading: Image.asset(details['image'] as String),
                  title: Text(restaurantName),
                  subtitle: Text('Rating: ${details['rating']}'),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      onFavoriteToggle(restaurantName);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailScreen(
                          name: restaurantName,
                          image: details['image'] as String,
                          description: details['description'] as String,
                          address: details['address'] as String,
                          rating: details['rating'] as double,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
