import 'package:flutter/material.dart';
import '../main.dart';

class VehicleStickerRegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Vehicle Sticker Registration", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)), backgroundColor: customPrimaryColor, 
        leading: const BackButton( // Using const for BackButton
          color: Color(0xffffffff),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600), // ✅ Responsive width
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                const Text(
                  "How to apply for a vehicle sticker?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. Download and fill out the Vehicle Registration Form"),
                      Text("2. Upload the filled out form"),
                      Text("3. Upload a valid ID (e.g. Driver’s License, National ID, School ID)"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Application Documents", style: TextStyle(fontWeight: FontWeight.bold)),
                const Text("Download the form, fill it out, and upload it."),
                ListTile(
                  title: const Text("Vehicle Sticker Registration Form"),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Download"),
                  ),
                ),
                ListTile(
                  title: const Text("Registration Form"),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Choose File"),
                  ),
                ),
                ListTile(
                  title: const Text("Valid ID"),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Choose File"),
                  ),
                ),
                const SizedBox(height: 20),
                
                ElevatedButton(
                  onPressed: () {
                    // Handle submission logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customPrimaryColor,
                    foregroundColor: Colors.white, // Blue background
                    minimumSize: const Size(double.infinity, 50), // Full-width button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "SUBMIT",
                    style: TextStyle(
                      color: Colors.white, // White text
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                const Text("Registration Status:", style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.orange),
                      ),
                      child: const Text(
                        "Pending",
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text("View Schedule"),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Text(
                  "* Your application is currently under review...",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}