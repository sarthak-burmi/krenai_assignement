import 'package:flutter/material.dart';
import 'package:krenai_assignement/const/app_text_style.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Static Page Indicator Section
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPageButton('1', isSelected: true),
              _buildPageButton('2'),
              _buildPageButton('3'),
              _buildPageButton('4'),
              _buildPageButton('5'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Social Media Icons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.tab, size: 24),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt, size: 24),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.video_library, size: 24),
            ),
          ],
        ),
        const Divider(thickness: 1, indent: 40, endIndent: 40),
        // Contact Details
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Text(
                'support@classystore',
                style: AppTextStyles.body
                    .copyWith(fontSize: 12), // Use AppTextStyles
              ),
              const SizedBox(height: 4),
              Text('+12 123 456 7896',
                  style: AppTextStyles.body
                      .copyWith(fontSize: 12)), // Use AppTextStyles
              const SizedBox(height: 4),
              Text('08:00 - 22:00 - Everyday',
                  style: AppTextStyles.body
                      .copyWith(fontSize: 12)), // Use AppTextStyles
            ],
          ),
        ),
        const Divider(thickness: 1, indent: 40, endIndent: 40),
        // Footer Navigation Links
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('About',
                  style: AppTextStyles.body
                      .copyWith(fontSize: 12)), // Use AppTextStyles
              Text('Contact',
                  style: AppTextStyles.body
                      .copyWith(fontSize: 12)), // Use AppTextStyles
              Text('Blog',
                  style: AppTextStyles.body
                      .copyWith(fontSize: 12)), // Use AppTextStyles
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Designed By Section
      ],
    );
  }

  // Helper method to build a static page button
  Widget _buildPageButton(String text, {bool isSelected = false}) {
    return Container(
      height: 50,
      width: 50,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
