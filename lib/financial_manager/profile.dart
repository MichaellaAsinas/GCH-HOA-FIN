import 'package:flutter/material.dart';

class FMProfilePage extends StatelessWidget {
  const FMProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background logo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/logo2.png'),
                repeat: ImageRepeat.repeat,
                opacity: 0.05,
                scale: 3,
              ),
            ),
          ),

          // Content with scroll
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // Profile Picture
                Material(
                  elevation: 4,
                  shape: const CircleBorder(),
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/pic.jpg'),
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                // Name and Role
                const Text(
                  "Elijah Miguel Esguerra",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Admin / Financial Manager",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 24),

                // Info card
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: Column(
                      children: [
                        _infoTile("Admin ID", "ADM-2401", Icons.perm_identity),
                        _infoTile("Email", "e.esguerra@gch-hoa.com", Icons.email_outlined),
                        _infoTile("Phone", "+63 921 588 8429", Icons.phone_outlined),
                        _infoTile("Location", "Golden Country Homes, Batangas", Icons.location_on_outlined),
                        _infoTile("Date Joined", "March 12, 2023", Icons.calendar_today_outlined),
                        _infoTile("Account Status", "Active", Icons.verified_user_outlined),
                        _infoTile("Assigned Projects", "Billing, Membership, Monthly Dues", Icons.work_outline),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Top-left back icon with tooltip
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Tooltip(
                message: 'Back',
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(String title, String value, IconData icon) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(value),
    );
  }
}
