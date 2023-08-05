import 'package:flutter/material.dart';

class DeveloperInfo extends StatelessWidget {
  final String name;
  final String profilePictureAsset;
  final Map<String, String> socialMediaHandles;

  const DeveloperInfo({super.key, 
    required this.name,
    required this.profilePictureAsset,
    required this.socialMediaHandles,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Info'),
        backgroundColor: const Color.fromARGB(255, 230, 107, 107),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.grey[200],
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('lib/assets/profile.jpg'),
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
              ...socialMediaHandles.entries.map((entry) => _buildSocialMediaCard(entry.key, entry.value)),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getSocialMediaIcon(String socialMedia) {
    switch (socialMedia.toLowerCase()) {
      case 'snapchat':
        return Icons.snapchat;
      case 'facebook':
        return Icons.facebook;
      case 'linkedin':
        return Icons.link;
      case 'phone':
        return Icons.phone;
      // Add more cases for other social media platforms if needed
      default:
        return Icons.link;
    }
  }

  Widget _buildSocialMediaCard(String handleType, String handle) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(handleType),
        subtitle: Text(handle),
        leading: Icon(_getSocialMediaIcon(handleType)),
      ),
    );
  }
}
