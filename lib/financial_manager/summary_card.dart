import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;

  const SummaryCard({super.key, 
    required this.title,
    required this.count,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).colorScheme.surface,
      child: Container(
        width: 160,
        height: 100,
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 28),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            Text("$count", style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}
