import 'package:flutter/material.dart';

class MonthlyDuesDetailsPage extends StatelessWidget {
  final String homeownerId;
  final String homeownerName;

  const MonthlyDuesDetailsPage({
    super.key,
    required this.homeownerId,
    required this.homeownerName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Monthly Dues Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Name: $homeownerName"),
            Text("SR-Code: $homeownerId"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/monthlyDuesReceipt');
              },
              child: Text("View Receipt"),
            ),
          ],
        ),
      ),
    );
  }
}
