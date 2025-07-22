import 'package:flutter/material.dart';
import '../main.dart'; // Assuming customPrimaryColor is defined here

class Complaint extends StatefulWidget {
  @override
  _ComplaintState createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  String? _selectedCategory;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<Map<String, String>> complaintCategories = [
    {'name': 'Property Damage', 'image': 'assets/property_damage.png'},
    {'name': 'Parking Violations', 'image': 'assets/parking_violation.png'},
    {'name': 'Pet Issues', 'image': 'assets/pet_issues.png'},
    {'name': 'Noise', 'image': 'assets/noise.png'},
    {'name': 'Maintenance Issues', 'image': 'assets/maintenance_issues.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complaint",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
        backgroundColor: customPrimaryColor,
        leading: const BackButton(
          color: Color(0xffffffff),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "What is your complaint?",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Categories:",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: complaintCategories.length,
                    itemBuilder: (context, index) {
                      final category = complaintCategories[index];
                      final isSelected = _selectedCategory == category['name'];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = category['name'];
                          });
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                          elevation: isSelected ? 8 : 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: isSelected
                                ? BorderSide(color: customPrimaryColor, width: 3.0)
                                : BorderSide.none,
                          ),
                          child: Container(
                            width: 100,
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  category['image']!,
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.broken_image, size: 40);
                                  },
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  category['name']!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: isSelected ? customPrimaryColor : Colors.black87,
                                    fontSize: 10,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextField(
                  controller: _titleController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "Title",
                    filled: true,
                    fillColor: const Color(0xfff2f2f3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: TextField(
                  controller: _descriptionController,
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: "What is the problem?",
                    filled: true,
                    fillColor: const Color(0xfff2f2f3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: MaterialButton(
                  onPressed: () {
                      final String title = _titleController.text.trim();
                      final String description = _descriptionController.text.trim();

                      if (_selectedCategory == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please select a complaint category.'),
                            backgroundColor: Colors.black,
                          ),
                        );
                        return;
                      }

                      if (title.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Title cannot be empty.'),
                            backgroundColor: Colors.black,
                          ),
                        );
                        return;
                      }

                      if (description.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Description cannot be empty.'),
                            backgroundColor: Colors.black,
                          ),
                        );
                        return;
                      }

                      // ✅ If all fields are valid, process the complaint
                      print('Complaint Category: $_selectedCategory');
                      print('Title: $title');
                      print('Description: $description');

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Complaint submitted successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      // Optional: Clear form after submission
                      _titleController.clear();
                      _descriptionController.clear();
                      setState(() {
                        _selectedCategory = null;
                      });
                    },

                  color: const Color(0xff3a57e8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: const BorderSide(color: Color(0xff808080), width: 1),
                  ),
                  padding: const EdgeInsets.all(16),
                  textColor: const Color(0xffffffff),
                  height: 40,
                  minWidth: 140,
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const Text(
                "*Complaints will be sent and reviewed by the GCH HOA Connect team*",
                style: TextStyle(
                  fontSize: 8,
                  color: Color(0x80000000),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
