import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GCashReceiptPage extends StatelessWidget {
  const GCashReceiptPage({super.key});

  final List<String> phonePrefixes = const [
    "+63 917", "+63 905", "+63 969", "+63 926", "+63 945"
  ];

  final List<Map<String, String>> homeowners = const [
    {"name": "Hannah Mendoza"},
    {"name": "Sabina Hernandez"},
    {"name": "Joshua Braza"},
    {"name": "Julianne Buenafe"},
    {"name": "Jay Renz Ilagan"},
    {"name": "Robi Gonzales"},
    {"name": "Vincent Acupan"},
    {"name": "Vince Dimaandal"},
    {"name": "Chloie Festejo"},
    {"name": "Eduardo Lincallo"},
    {"name": "Zyrus Alog"},
    {"name": "Sarah Ignacio"},
    {"name": "Michaella Asinas"},
    {"name": "Mark Sandoval"},
    {"name": "Paul Arguelles"},
    {"name": "Aethelbelle Cabatay"},
  ];

  String _generateReferenceNumber(Random random) {
    final part1 = random.nextInt(9000) + 1000;
    final part2 = random.nextInt(900) + 100;
    final part3 = random.nextInt(900000) + 100000;
    return "$part1 $part2 $part3";
  }

  String _maskName(String name) {
    List<String> parts = name.split(" ");
    String first = parts[0];
    String last = parts.length > 1 ? parts.last : "";

    String maskedFirst = first.length > 2
        ? first[0] + "•" * (first.length - 2) + first[first.length - 1]
        : first;
    String maskedLast = last.length > 2
        ? last[0] + "•" * (last.length - 2) + last[last.length - 1]
        : last;

    return "$maskedFirst $maskedLast";
  }

  String _generatePhone(Random random) {
    String prefix = phonePrefixes[random.nextInt(phonePrefixes.length)];
    String line = "${random.nextInt(900) + 100} ${random.nextInt(9000) + 1000}";
    return "$prefix $line";
  }

  @override
  Widget build(BuildContext context) {
    final random = Random(DateTime.now().millisecondsSinceEpoch);
    final user = homeowners[random.nextInt(homeowners.length)];
    final maskedName = _maskName(user['name']!);
    final phoneNumber = _generatePhone(random);
    final refNo = _generateReferenceNumber(random);
    final double amount = (random.nextDouble() * 4000) + 500;
    final dateTime = DateFormat('MMM dd, yyyy h:mm a').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "GCash Receipt",
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
      backgroundColor: const Color.fromARGB(255, 28, 105, 165),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ClipPath(
            clipper: ZigZagClipper(),
            child: Container(
              width: 340,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const SizedBox(height: 60),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Container(
                          height: 44,
                          width: 44,
                          decoration: const BoxDecoration(
                            color: Color(0xFF0075FF),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    maskedName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0075FF),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF3F6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      phoneNumber,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Sent via GCash",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  const Divider(thickness: 1.2),
                  _buildAmountRow("Amount", "₱${amount.toStringAsFixed(2)}"),
                  const Divider(thickness: 1.2),
                  _buildAmountRow(
                    "Total Amount Sent",
                    "₱${amount.toStringAsFixed(2)}",
                    isBold: true,
                  ),
                  const Divider(thickness: 1.2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Ref No. $refNo",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14)),
                        const SizedBox(height: 4),
                        Text(
                          dateTime,
                          style:
                              const TextStyle(color: Colors.black54, fontSize: 13),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAmountRow(String label, String amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class ZigZagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const zigzagHeight = 8.0;
    const zigzagWidth = 12.0;
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height - zigzagHeight);

    for (double x = 0; x < size.width; x += zigzagWidth) {
      path.lineTo(x + zigzagWidth / 2, size.height);
      path.lineTo(x + zigzagWidth, size.height - zigzagHeight);
    }

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(ZigZagClipper oldClipper) => false;
}
