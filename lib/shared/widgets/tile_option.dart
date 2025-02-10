import 'package:flutter/material.dart';

class TileOption extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onTap;

  const TileOption({
    super.key,
    required this.title,
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(message),
      onTap: onTap,
    );
  }
}