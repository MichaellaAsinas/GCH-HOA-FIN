import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Information"),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // ✅ Better GCH Watermark (Centered & Responsive)
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: Opacity(
                  opacity: 0.08, // stronger visibility
                  child: FittedBox(
                    child: Text(
                      "GCH",
                      style: TextStyle(
                        fontSize: 250, // base size; auto-scales with FittedBox
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow[700],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Foreground content
          Center(
            child: Container(
              width: isMobile ? size.width * 0.9 : 500,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage('assets/user.jpg'),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Michaella Asinas",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Homeowner",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Display Fields
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start, // Changed to MainAxisAlignment.start
                      children: [
                        _buildDisplayField(label: "Homeowner ID", value: "HO-12345"),
                        const SizedBox(height: 5), // Add small space between fields
                        _buildDisplayField(label: "Age", value: "21"),
                        const SizedBox(height: 5), // Add small space between fields
                        _buildDisplayField(
                          label: "Address",
                          value: "Earth Street, Golden Country Homes, Batangas City",
                        ),
                        const SizedBox(height: 5), // Add small space between fields
                        _buildDisplayField(label: "Contact", value: "09693119162"),
                        const SizedBox(height: 5), // Add small space between fields
                        _buildDisplayField(label: "Birthday", value: "02/12/2004"),
                        const SizedBox(height: 5), // Add small space between fields
                        _buildDisplayField(label: "Email", value: "michaellaasinas12@gmail.com"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildDisplayField({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2), // Reduced vertical padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
          ),
          const SizedBox(height: 2), // Reduced height here
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade100,
            ),
            child: Text(
              value,
              style: const TextStyle(fontSize: 14.5),
            ),
          ),
        ],
      ),
    );
  }
}