import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class AnnouncementPage extends StatelessWidget {
  AnnouncementPage({super.key});

  final List<Map<String, dynamic>> announcements = List.generate(12, (index) {
    final now = DateTime.now().subtract(Duration(days: index));
    final isMembership = index % 2 == 0;

    final membershipIds = [
      'HO-0912', 'HO-0920', 'HO-0933', 'HO-0941',
      'HO-0949', 'HO-0955', 'HO-0960'
    ];
    final duesIds = [
      'HO-0967', 'HO-0974', 'HO-0981',
      'HO-0992', 'HO-1019'
    ];

    final hoId = isMembership
        ? membershipIds[index ~/ 2 % membershipIds.length]
        : duesIds[index ~/ 2 % duesIds.length];

    return {
      "hoId": hoId,
      "status": "Pending",
      "timestamp": now,
      "type": isMembership ? "Membership" : "MonthlyDues",
    };
  });

  void _goToDetails(BuildContext context, Map<String, dynamic> item) {
    final route = item['type'] == "Membership"
        ? '/pendingMembership'
        : '/pendingMonthlyDues';

    Navigator.pushNamed(context, route, arguments: item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Billing Announcements",
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
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: announcements.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final ann = announcements[index];
          final formattedDate =
              DateFormat.yMMMMd().add_jm().format(ann['timestamp']);
          final Color statusColor = Colors.orange;

          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.attach_money, color: Colors.blue),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment from ${ann['hoId']} (${ann['type']})",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: statusColor),
                            ),
                            child: Text(ann['status'], style: TextStyle(color: statusColor)),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            formattedDate,
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () => _goToDetails(context, ann),
                            child: const Text("View"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
