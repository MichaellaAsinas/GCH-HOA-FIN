import 'package:flutter/material.dart';
import 'chatbot_dialog.dart';
import '../main.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int notificationCount = 3;

  final List<IconData> icons = [
    Icons.attach_money,
    Icons.home,
    Icons.directions_car,
    Icons.feedback,
    Icons.report_problem,
    Icons.block,
    Icons.settings,
    Icons.apartment,
  ];

  final List<String> labels = [
    'Billing',
    'Facility Booking',
    'Vehicle Sticker',
    'Feedback',
    'Complaint',
    'Incident Report',
    'Service Request',
    'Landlord Application',
  ];

  final List<Map<String, String>> announcements = [
    {
      'image': 'assets/curfew.jpg',
      'title': 'Curfew Notice',
      'desc': 'Curfew hours start at 10 PM to 4 AM.',
    },
    {
      'image': 'assets/car.jpg',
      'title': 'Car Advisory',
      'desc': 'Loud pipes are not allowed starting August 01, 2025.',
    },
    {
      'image': 'assets/meeting.jpg',
      'title': 'HOA Meeting',
      'desc': 'Quarterly meeting will be held at 3 PM, July 25, 2025.',
    },
  ];

  final List<String> communityReminders = [
    "Keep noise levels low after 9 PM.",
    "Garbage collection is every Monday and Thursday.",
    "Please maintain cleanliness in your surroundings.",
  ];

  void _navigateToFunction(String label) {
    final routes = {
      'Billing': '/billing',
      'Facility Booking': '/facilityBooking',
      'Vehicle Sticker': '/vehicleSticker',
      'Feedback': '/feedback',
      'Complaint': '/complaint',
      'Incident Report': '/incidentReport',
      'Service Request': '/serviceRequest',
      'Landlord Application': '/landlordApplication',
    };
    Navigator.pushNamed(context, routes[label]!);
  }

  void _showNotificationDialog(BuildContext context) {
    setState(() => notificationCount = 0);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Notifications"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: customPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.attach_money, color: customPrimaryColor),
              ),
              title: const Text("Your bill for July is ready."),
              subtitle: const Text("2 hours ago"),
            ),
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: customPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.directions_car, color: customPrimaryColor),
              ),
              title: const Text("Vehicle Sticker approved."),
              subtitle: const Text("Yesterday"),
            ),
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: customPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.home, color: customPrimaryColor),
              ),
              title: const Text("Facility booking confirmed."),
              subtitle: const Text("3 days ago"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  void _logout() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 12),
              Text("Logging out..."),
            ],
          ),
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      Navigator.of(context).pop();
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    const crossAxisCount = 4;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: customPrimaryColor,
        automaticallyImplyLeading: false,
        toolbarHeight: 85,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/profile'),
              child: const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/user.jpg'),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Michaella Asinas",
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                  Text("Homeowner",
                      style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            Stack(
              children: [
                Tooltip(
                  message: 'View Notifications',
                  child: IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white, size: 30),
                    onPressed: () => _showNotificationDialog(context),
                  ),
                ),
                if (notificationCount > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$notificationCount',
                        style: const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
              ],
            ),
            Tooltip(
              message: 'Logout',
              child: IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
                onPressed: _logout,
              ),
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Your Community Dashboard",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Services",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: icons.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: constraints.maxWidth > 600 ? 1.1 : 0.9,
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                              constraints: const BoxConstraints(
                                minHeight: 80,
                                maxHeight: 120,
                              ),
                              child: ElevatedButton(
                                onPressed: () => _navigateToFunction(labels[index]),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: customPrimaryColor,
                                  padding: const EdgeInsets.all(8),
                                  elevation: 4,
                                  shadowColor: Colors.blue.withOpacity(0.3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(color: customPrimaryColor.withOpacity(0.3), width: 1.5),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      icons[index], 
                                      size: constraints.maxWidth > 600 ? 28 : 24, 
                                      color: customPrimaryColor,
                                    ),
                                    const SizedBox(height: 4),
                                    Flexible(
                                      child: Text(
                                        labels[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: constraints.maxWidth > 600 ? 10 : 8,
                                          color: customPrimaryColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Announcements",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 240,
                      child: PageView.builder(
                        itemCount: announcements.length,
                        controller: PageController(viewportFraction: 0.95),
                        itemBuilder: (context, index) {
                          return _HoverZoomCard(
                            image: announcements[index]['image']!,
                            title: announcements[index]['title']!,
                            desc: announcements[index]['desc']!,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Community Reminders",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: communityReminders.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: const Icon(Icons.check_circle_outline, color: Colors.blue),
                            title: Text(
                              communityReminders[index],
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: Tooltip(
        message: 'Chat with Assistant',
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => ChatbotDialog(),
            );
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.chat, color: Colors.white),
        ),
      ),
    );
  }
}

class _HoverZoomCard extends StatefulWidget {
  final String image;
  final String title;
  final String desc;

  const _HoverZoomCard({
    required this.image,
    required this.title,
    required this.desc,
  });

  @override
  State<_HoverZoomCard> createState() => _HoverZoomCardState();
}

class _HoverZoomCardState extends State<_HoverZoomCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Container(
                  width: double.infinity,
                  height: 140,
                  color: Colors.grey.shade50,
                  child: Center(
                    child: Image.asset(
                      widget.image,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: 140,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Flexible(
                        child: Text(
                          widget.desc,
                          style: const TextStyle(fontSize: 14, color: Colors.black87),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
