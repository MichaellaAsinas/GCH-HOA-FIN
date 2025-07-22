import 'package:flutter/material.dart';
import '../main.dart'; // Import main.dart to access customPrimaryColor (assuming it's in main.dart)

class PaymentHistoryPage extends StatelessWidget {
  const PaymentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff), // Added background color for consistency
      appBar: AppBar(
        elevation: 4,
        centerTitle: false,
        automaticallyImplyLeading: false, // Set to false so we can provide our own leading
        backgroundColor: customPrimaryColor, // Using the customPrimaryColor
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Text(
          "Payment History", // Changed title text
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context); // This will pop the current page off the stack
          },
        ),
      ),
      body: const Center(
        child: Text(
          "This is the Payment History Page",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}