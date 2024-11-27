import 'package:find_pros/social/social_VM.dart';
import 'package:find_pros/social/social_model.dart';
import 'package:flutter/material.dart';

class SocialView extends StatefulWidget {
  const SocialView({super.key});

  @override
  State<SocialView> createState() => _SocialViewState();
}

class _SocialViewState extends State<SocialView> {
  final personalizedFeed = PersonalizedFeed();
  List<Post> posts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFeed();
  }

  Future<void> _loadFeed() async {
    setState(() {
      isLoading = true;
    });

    try {
      final fetchedPosts = await personalizedFeed.getFeed();
      setState(() {
        posts = fetchedPosts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading feed: $e')),
      );
    }
  }

  Widget _buildPostCard(Post post) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User ${post.userId}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        post.timestamp.toString(),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) async {
                    if (value == 'block') {
                      await personalizedFeed.blockUser(post.userId);
                      _loadFeed(); // Reload feed after blocking
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'block',
                      child: Text('Block User'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(post.content),
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              children: post.tags
                  .map((tag) => Chip(
                        label: Text('#$tag'),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadFeed,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadFeed,
              child: posts.isEmpty
                  ? const Center(child: Text('No posts available'))
                  : ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) =>
                          _buildPostCard(posts[index]),
                    ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement post creation
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Post creation not implemented yet')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
