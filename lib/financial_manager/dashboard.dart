import 'package:flutter/material.dart';
import 'components/custom_app_bar.dart';

class FMDashboardPage extends StatefulWidget {
  const FMDashboardPage({super.key});

  @override
  _FMDashboardPageState createState() => _FMDashboardPageState();
}

class _FMDashboardPageState extends State<FMDashboardPage> {
  void _goTo(String route) {
    Navigator.pushNamed(context, route);
  }

  final List<String> _pendingSRs = [
    "HO-0912", "HO-0920", "HO-0933", "HO-0941", "HO-0949",
    "HO-0955", "HO-0960", "HO-0967", "HO-0974", "HO-0981",
    "HO-0992", "HO-1019", "HO-1028"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: " Financial Manager Dashboard",
        backgroundColor: Colors.blue,
        toolbarHeight: 85,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w900,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _summaryCard(
                      title: "Homeowners",
                      subtitle: "View All",
                      icon: Icons.people,
                      onTap: () => _goTo('/homeowners'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _summaryCard(
                      title: "Membership",
                      subtitle: "Billings",
                      icon: Icons.card_membership,
                      onTap: () => _goTo('/pendingMembership'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _summaryCard(
                      title: "Monthly Dues",
                      subtitle: "Billings",
                      icon: Icons.receipt_long,
                      onTap: () => _goTo('/pendingMonthlyDues'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 48),

              // Billing Announcements Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Billing Announcements",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () => _goTo('/announcement'),
                          child: const Text("View All"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _pendingSRs.length > 5 ? 5 : _pendingSRs.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        return _announcementRow(_pendingSRs[index], "Pending");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.grey.withOpacity(0.1),

        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade100, width: 1),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              Icon(icon, size: 40, color: Colors.blue),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _announcementRow(String srCode, String status) {
    final Color statusColor = Colors.orange;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.notifications, color: Colors.blue),
        title: Text("Payment from $srCode"),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            border: Border.all(color: statusColor),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(status, style: TextStyle(color: statusColor)),
        ),
      ),
    );
  }
}
