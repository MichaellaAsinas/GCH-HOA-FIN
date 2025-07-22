import 'package:flutter/material.dart';
import '../main.dart'; // Assuming customPrimaryColor is defined here

class ServiceRequestPage extends StatefulWidget {
  @override
  _ServiceRequestState createState() => _ServiceRequestState();
}

class _ServiceRequestState extends State<ServiceRequestPage> {
  String? _selectedCategory; // Holds the currently selected service category
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<Map<String, String>> serviceCategories = [
    {'name': 'Plumbing Repair', 'image': 'assets/plumbing_repair.png'},
    {'name': 'Electrical Repair', 'image': 'assets/electrical_repair.png'},
    {'name': 'Carpentry Work', 'image': 'assets/carpentry_work.png'},
    {'name': 'Landscaping', 'image': 'assets/landscaping.png'},
    {'name': 'Pest Control', 'image': 'assets/pest_control.png'},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Service Request",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
        backgroundColor: customPrimaryColor,
        leading: const BackButton(color: Color(0xffffffff)),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Service Request Categories:",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: serviceCategories.length,
                  itemBuilder: (context, index) {
                    final category = serviceCategories[index];
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
                    hintText: "Describe the service needed...",
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
                    final title = _titleController.text.trim();
                    final description = _descriptionController.text.trim();

                    if (_selectedCategory == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select a service request category.'),
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

                    // ✅ All valid
                    print('Service Request Category: $_selectedCategory');
                    print('Title: $title');
                    print('Description: $description');

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Service request for $_selectedCategory submitted successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );

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
                  textColor: Colors.white,
                  height: 40,
                  minWidth: 140,
                  child: const Text(
                    "Submit Request",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const Text(
                "*Service requests will be sent and reviewed by the GCH HOA Connect team*",
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
