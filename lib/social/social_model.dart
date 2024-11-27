import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String userId;
  final String content;
  final List<String> tags;
  final GeoPoint location;
  final DateTime timestamp;

  Post({
    required this.id,
    required this.userId,
    required this.content,
    required this.tags,
    required this.location,
    required this.timestamp,
  });

  factory Post.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Safely convert the tags to List<String>
    List<String> convertedTags = [];
    if (data['tags'] != null) {
      convertedTags =
          (data['tags'] as List).map((tag) => tag.toString()).toList();
    }

    // Ensure location is a GeoPoint, or provide a default
    GeoPoint postLocation = data['location'] is GeoPoint
        ? data['location'] as GeoPoint
        : const GeoPoint(0, 0);

    return Post(
      id: doc.id,
      userId: data['userId']?.toString() ?? '',
      content: data['content']?.toString() ?? '',
      tags: convertedTags,
      location: postLocation,
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
