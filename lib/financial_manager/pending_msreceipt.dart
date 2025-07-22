import 'dart:math';
import 'package:flutter/material.dart';

class PendingMSReceiptPage extends StatefulWidget {
  const PendingMSReceiptPage({super.key});

  @override
  State<PendingMSReceiptPage> createState() => _MembershipReceiptPageState();
}

class _MembershipReceiptPageState extends State<PendingMSReceiptPage> {
  String _selectedStatus = 'Approved';
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
    final String date = args['date'] ?? 'Unknown Date';

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
          "Membership",
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
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
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
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/gcashReceipt', arguments: {
                      'name': 'Maria Santos',
                    });
                  },
                  icon: const Icon(Icons.receipt_long_outlined, color: Colors.indigo),
                  label: const Text(
                    "GCash Receipt",
                    style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.w500),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedStatus,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                          items: ['Approved', 'Declined', 'Pending'].map((status) {
                            IconData icon;
                            Color color;
                            switch (status) {
                              case 'Approved':
                                icon = Icons.check_circle_outline;
                                color = Colors.green;
                                break;
                              case 'Declined':
                                icon = Icons.cancel_outlined;
                                color = Colors.red;
                                break;
                              default:
                                icon = Icons.hourglass_bottom_outlined;
                                color = Colors.orange;
                            }
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Row(
                                children: [
                                  Icon(icon, color: color, size: 16),
                                  const SizedBox(width: 8),
                                  Text(status),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedStatus = value;
                              });
                              if (value == 'Approved') {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/membershipReceipt',
                                  arguments: {'date': date},
                                );
                              }
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(height: 30, width: 1, color: Colors.grey.shade300),
                    const SizedBox(width: 12),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) => setState(() => _isHovering = true),
                      onExit: (_) => setState(() => _isHovering = false),
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Status updated to $_selectedStatus')),
                          );
                          Navigator.pop(context);
                        },
                        child: Text(
                          "OK",
                          style: TextStyle(
                            fontSize: 14,
                            color: _isHovering ? Colors.blue.shade900 : Colors.blue.shade700,
                            fontWeight: FontWeight.w600,
                            decoration: _isHovering ? TextDecoration.underline : TextDecoration.none,
                          ),
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
    );
  }
}
