import 'dart:math';
import 'package:flutter/material.dart';
import 'components/custom_app_bar.dart';

class HomeownerDetailsPage extends StatelessWidget {
  const HomeownerDetailsPage({super.key});

  String generateRandomPhoneNumber() {
    final random = Random();
    String nextDigit() => random.nextInt(10).toString();
    return '09${nextDigit()}${nextDigit()} '
        '${nextDigit()}${nextDigit()}${nextDigit()} '
        '${nextDigit()}${nextDigit()}${nextDigit()}${nextDigit()}';
  }

  String generateRandomAddress() {
    final streetNames = [
      'Neptune', 'Mercury', 'Saturn', 'Jupiter', 'Venus', 'Earth',
      'Mars', 'Galaxy', 'Comet', 'Pluto', 'Uranus', 'Star', 'Universe',
    ];
    final random = Random();
    final houseNumber = random.nextInt(999) + 1;
    final street = streetNames[random.nextInt(streetNames.length)];
    return '$houseNumber, $street Street, Golden Country Homes, Alangilan, Batangas City, 4200 Batangas, Philippines';
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? homeowner =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (homeowner == null) {
      return Scaffold(
        appBar: CustomAppBar(
        title: 'Homeowner Details',
        showBackButton: true,
        titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
        body: const Center(child: Text("No homeowner data found.")),
      );
    }

    final phone = homeowner['phone'] ?? generateRandomPhoneNumber();
    final address = homeowner['address'] ?? generateRandomAddress();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Homeowner Details',
        showBackButton: true,
        titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blueGrey,
                  child: Icon(Icons.person, size: 30, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Text(
                  homeowner['name'] ?? "Name not found",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  homeowner['id'] ?? "HO Code not found",
                  style: const TextStyle(color: Colors.grey),
                ),
                const Divider(height: 24),
                ListTile(
                  leading: const Icon(Icons.email_outlined),
                  title: const Text("Email"),
                  subtitle: Text(homeowner['email'] ?? "No email"),
                ),
                ListTile(
                  leading: const Icon(Icons.phone_outlined),
                  title: const Text("Phone Number"),
                  subtitle: Text(phone),
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_today_outlined),
                  title: const Text("Date Joined"),
                  subtitle: Text(homeowner['joined'] ?? "Unknown"),
                ),
                ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: const Text("Address"),
                  subtitle: Text(address),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
      padding: const EdgeInsets.only(right: 20.0, bottom: 20.0),
      child: FloatingActionButton.extended(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Reminder sent to ${homeowner['name']} to pay liabilities."),
              backgroundColor: Colors.orange,
              duration: const Duration(seconds: 3),
            ),
          );
        },
        icon: const Icon(Icons.notifications_active_outlined),
        label: const Text("Alert"),
      ),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
