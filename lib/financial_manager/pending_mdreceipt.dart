import 'dart:math';
import 'package:flutter/material.dart';

class PendingMDReceiptPage extends StatefulWidget {
  const PendingMDReceiptPage({super.key});

  @override
  State<PendingMDReceiptPage> createState() => _MonthlyDuesReceiptPageState();
}

class _MonthlyDuesReceiptPageState extends State<PendingMDReceiptPage> {
  String _selectedStatus = 'Approved';
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
    final String date = args['date'] ?? 'Unknown Date';

    final random = Random(date.hashCode);
    final double baseFee = (200 + random.nextInt(101)).toDouble();
    final double maintenanceFee = (30 + random.nextInt(51)).toDouble();
    final double subtotal = baseFee + maintenanceFee;
    final double taxRate = 0.05;
    final double taxAmount = subtotal * taxRate;
    final double total = subtotal + taxAmount;
    final String receiptNumber = "MDR-${(random.nextInt(9000) + 1000).toString()}";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Monthly Dues Receipt",
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "MONTHLY DUES RECEIPT",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text("Receipt No.: $receiptNumber"),
                  Text("Date: $date"),
                  const SizedBox(height: 16),
                  Container(
                    color: Colors.grey.shade200,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: Row(
                      children: const [
                        Expanded(flex: 1, child: Text("NO.", style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(flex: 3, child: Text("DESCRIPTION", style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(flex: 2, child: Text("AMOUNT", style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                  const Divider(height: 0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: Row(
                      children: [
                        const Expanded(flex: 1, child: Text("01")),
                        const Expanded(flex: 3, child: Text("Base Monthly Fee")),
                        Expanded(flex: 2, child: Text("₱ ${baseFee.toStringAsFixed(2)}")),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: Row(
                      children: [
                        const Expanded(flex: 1, child: Text("02")),
                        const Expanded(flex: 3, child: Text("Maintenance Fee")),
                        Expanded(flex: 2, child: Text("₱ ${maintenanceFee.toStringAsFixed(2)}")),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      children: [
                        const Expanded(flex: 4, child: Align(alignment: Alignment.centerRight, child: Text("SUB TOTAL:"))),
                        Expanded(flex: 2, child: Align(alignment: Alignment.centerRight, child: Text("₱ ${subtotal.toStringAsFixed(2)}"))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      children: const [
                        Expanded(flex: 4, child: Align(alignment: Alignment.centerRight, child: Text("TAX RATE:"))),
                        Expanded(flex: 2, child: Align(alignment: Alignment.centerRight, child: Text("5%"))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      children: [
                        const Expanded(flex: 4, child: Align(alignment: Alignment.centerRight, child: Text("TAX AMOUNT:"))),
                        Expanded(flex: 2, child: Align(alignment: Alignment.centerRight, child: Text("₱ ${taxAmount.toStringAsFixed(2)}"))),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: Row(
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
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                                  '/monthlyDuesReceipt',
                                  arguments: {'date': date},
                                );
                              }
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 30,
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
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
