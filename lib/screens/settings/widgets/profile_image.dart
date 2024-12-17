import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String? imageUrl;
  final Function(String) onUpload;

  const ProfileImage({
    Key? key,
    this.imageUrl,
    required this.onUpload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: imageUrl != null
                ? DecorationImage(
              image: NetworkImage(imageUrl!),
              fit: BoxFit.cover,
            )
                : null,
          ),
          child: imageUrl == null
              ? Icon(Icons.person, size: 60, color: Colors.grey)
              : null,
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.lightBlueAccent,
          ),
          onPressed: () async {
            // Implement image upload logic
            // For now, we'll just simulate it
            onUpload('https://example.com/dummy-image.jpg');
          },
          child: Text(
            'Upload Image',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}