import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_pros/social/social_model.dart';
import 'package:geolocator/geolocator.dart';

class PersonalizedFeed {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String currentUserId = 'BdpV9mgXYufuClNMdiHy';

  // Get current user's location
  Future<Position?> _getCurrentUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

  // Calculate distance between two points
  double _calculateDistance(GeoPoint postLocation, Position userLocation) {
    return Geolocator.distanceBetween(
      userLocation.latitude,
      userLocation.longitude,
      postLocation.latitude,
      postLocation.longitude,
    );
  }

  Future<List<Post>> getFeed({int limit = 10}) async {
    try {
      // Get blocked users first to use in query
      final blockedUsers = await _getBlockedUsers();

      // Build query with database-level filters
      Query query = _firestore.collection('posts');

      // Filter out current user's posts at database level
      query = query.where('userId', isNotEqualTo: currentUserId);

      // Filter out blocked users at database level if any exist
      if (blockedUsers.isNotEmpty) {
        query = query.where('userId', whereNotIn: blockedUsers);
      }

      // Order by timestamp and limit results
      query = query.orderBy('timestamp', descending: true).limit(limit);

      // Execute query
      final querySnapshot = await query.get();

      // Convert to Post objects
      List<Post> posts =
          querySnapshot.docs.map((doc) => Post.fromFirestore(doc)).toList();

      // Sort by location if needed (this still happens in memory)
      final userLocation = await _getCurrentUserLocation();
      if (userLocation != null) {
        posts.sort((a, b) {
          double distanceA = _calculateDistance(a.location, userLocation);
          double distanceB = _calculateDistance(b.location, userLocation);
          return distanceA.compareTo(distanceB);
        });
      }

      return posts;
    } catch (e) {
      print('Error fetching personalized feed: $e');
      return [];
    }
  }

  Future<List<String>> _getBlockedUsers() async {
    try {
      final userDoc =
          await _firestore.collection('users').doc(currentUserId).get();
      if (!userDoc.exists) return [];

      final data = userDoc.data();
      if (data == null || !data.containsKey('blockedUsers')) return [];

      return List<String>.from(data['blockedUsers'] ?? []);
    } catch (e) {
      print('Error getting blocked users: $e');
      return [];
    }
  }

  Future<void> blockUser(String userIdToBlock) async {
    try {
      await _firestore.collection('users').doc(currentUserId).update({
        'blockedUsers': FieldValue.arrayUnion([userIdToBlock]),
      });
    } catch (e) {
      print('Error blocking user: $e');
      rethrow;
    }
  }
}
