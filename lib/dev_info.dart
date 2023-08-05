import 'package:flutter/material.dart';

class DeveloperInfo extends StatelessWidget {
  final String name;
  final String profilePictureUrl;
  final Map<String, String> socialMediaHandles;

  DeveloperInfo({
    required this.name,
    required this.profilePictureUrl,
    required this.socialMediaHandles, required String profilePictureAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage('lib/assets/profile.jpg'),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Social Media Handles',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...socialMediaHandles.entries.map((entry) => ListTile(
                  title: Text(entry.key),
                  subtitle: Text(entry.value),
                  leading: Icon(_getSocialMediaIcon(entry.key)),
                )),
          ],
        ),
      ),
    );
  }

  IconData _getSocialMediaIcon(String socialMedia) {
    switch (socialMedia.toLowerCase()) {
      case 'twitter':
        return Icons.snapchat;
      case 'facebook':
        return Icons.facebook;
      case 'linkedin':
        return Icons.link;
      case 'github':
        return Icons.code_outlined;
      // Add more cases for other social media platforms if needed
      default:
        return Icons.link;
    }
  }
}
