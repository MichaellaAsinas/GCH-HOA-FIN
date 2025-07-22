import 'dart:math';
import 'package:flutter/material.dart';

class MembershipReceiptPage extends StatelessWidget {
  const MembershipReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String date = args['date'];

    final random = Random(date.hashCode);
    final double membershipFee = (80 + random.nextInt(41)).toDouble();
    final double additionalFees = (10 + random.nextInt(31)).toDouble();
    final double subtotal = membershipFee + additionalFees;
    final double taxRate = 0.05;
    final double taxAmount = subtotal * taxRate;
    final double total = subtotal + taxAmount;

    final String receiptNumber = "MSR-${(random.nextInt(9000) + 1000).toString()}";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Billing — Membership Receipt",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: Tooltip(
          message: 'Back',
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Text(
                      "MEMBERSHIP FEE RECEIPT",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Divider(height: 0),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Receipt No.: $receiptNumber"),
                      Text("Date: $date"),
                      const SizedBox(height: 16),
                      Container(
                        color: Colors.grey.shade200,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                        child: Row(
                          children: const [
                            Expanded(flex: 1, child: Text("NO.", style: TextStyle(fontWeight: FontWeight.bold))),
                            Expanded(flex: 3, child: Text("DESCRIPTION", style: TextStyle(fontWeight: FontWeight.bold))),
                            Expanded(flex: 2, child: Text("AMOUNT", style: TextStyle(fontWeight: FontWeight.bold))),
                          ],
                        ),
                      ),
                      const Divider(height: 0),
                      Row(
                        children: [
                          const Expanded(flex: 1, child: Padding(padding: EdgeInsets.all(8), child: Text("01"))),
                          const Expanded(flex: 3, child: Padding(padding: EdgeInsets.all(8), child: Text("Membership Fee"))),
                          Expanded(flex: 2, child: Padding(padding: const EdgeInsets.all(8), child: Text("₱ ${membershipFee.toStringAsFixed(2)}"))),
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(flex: 1, child: Padding(padding: EdgeInsets.all(8), child: Text("02"))),
                          const Expanded(flex: 3, child: Padding(padding: EdgeInsets.all(8), child: Text("Additional Fees"))),
                          Expanded(flex: 2, child: Padding(padding: const EdgeInsets.all(8), child: Text("₱ ${additionalFees.toStringAsFixed(2)}"))),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          const Expanded(flex: 4, child: Align(alignment: Alignment.centerRight, child: Text("SUB TOTAL:"))),
                          Expanded(flex: 2, child: Align(alignment: Alignment.centerRight, child: Text("₱ ${subtotal.toStringAsFixed(2)}"))),
                        ],
                      ),
                      Row(
                        children: const [
                          Expanded(flex: 4, child: Align(alignment: Alignment.centerRight, child: Text("TAX RATE:"))),
                          Expanded(flex: 2, child: Align(alignment: Alignment.centerRight, child: Text("5%"))),
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(flex: 4, child: Align(alignment: Alignment.centerRight, child: Text("TAX AMOUNT:"))),
                          Expanded(flex: 2, child: Align(alignment: Alignment.centerRight, child: Text("₱ ${taxAmount.toStringAsFixed(2)}"))),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          const Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "TOTAL AMOUNT:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "₱ ${total.toStringAsFixed(2)}",
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )

    );
  }
}
