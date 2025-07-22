import 'package:flutter/material.dart';
import '../main.dart'; // Assuming customPrimaryColor is defined here

class FacilityBooking extends StatefulWidget {
  @override
  _FacilityBookingState createState() => _FacilityBookingState();
}

class _FacilityBookingState extends State<FacilityBooking> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;
  String? _selectedFacility; // Now stores the name of the selected facility

  // Define your facilities with images and names
  final List<Map<String, String>> facilities = [
    {'name': 'Basketball Court', 'image': 'assets/basketball.png'},
    {'name': 'Chapel', 'image': 'assets/chapel.png'},
    {'name': 'Swimming Pool', 'image': 'assets/swimming_pool.png'},
    {'name': 'Clubhouse', 'image': 'assets/clubhouse.png'},
    // Add more facilities as needed
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, {required bool isStartTime}) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime ? (_selectedStartTime ?? TimeOfDay.now()) : (_selectedEndTime ?? TimeOfDay.now()),
    );
    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          _selectedStartTime = pickedTime;
        } else {
          _selectedEndTime = pickedTime;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        title: const Text("Facility Booking", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
        backgroundColor: customPrimaryColor,
        leading: const BackButton(
          color: Color(0xffffffff),
        ),
      ),
      body: SingleChildScrollView(
        // Added Padding here to give more space from the top
        padding: const EdgeInsets.only(top: 16.0), // You can adjust this value as needed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Date & Time Title ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Date & Time:",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xff000000),
                  ),
                ),
              ),
            ),
            // --- End Date & Time Title ---

            // Date Picker
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Select Date',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    _selectedDate == null
                        ? 'No date chosen'
                        : '${_selectedDate!.toLocal().day}/${_selectedDate!.toLocal().month}/${_selectedDate!.toLocal().year}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            // Start Time Picker
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: InkWell(
                onTap: () => _selectTime(context, isStartTime: true),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Select Start Time',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.access_time),
                  ),
                  child: Text(
                    _selectedStartTime == null
                        ? 'No start time chosen'
                        : _selectedStartTime!.format(context),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            // End Time Picker
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: InkWell(
                onTap: () => _selectTime(context, isStartTime: false),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Select End Time',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.access_time),
                  ),
                  child: Text(
                    _selectedEndTime == null
                        ? 'No end time chosen'
                        : _selectedEndTime!.format(context),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            // --- Facility Selection Collage ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select a Facility:",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xff000000),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 180, // Height for the horizontal scrollable list of facility cards
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: facilities.length,
                itemBuilder: (context, index) {
                  final facility = facilities[index];
                  final isSelected = _selectedFacility == facility['name'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFacility = facility['name'];
                      });
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      elevation: isSelected ? 8 : 2, // Highlight selected card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: isSelected
                            ? BorderSide(color: customPrimaryColor, width: 3.0)
                            : BorderSide.none,
                      ),
                      child: Container(
                        width: 150, // Fixed width for each facility card
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              facility['image']!,
                              height: 100,
                              width: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image, size: 80); // Fallback icon
                              },
                            ),
                            const SizedBox(height: 8),
                            Text(
                              facility['name']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? customPrimaryColor : Colors.black87,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10), // Spacing after the collage
            // --- End Facility Selection Collage ---

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: MaterialButton(
                onPressed: () {
                  // Handle submission logic here
                  if (_selectedDate != null &&
                      _selectedStartTime != null &&
                      _selectedEndTime != null &&
                      _selectedFacility != null) {
                    print('Booking details:');
                    print('Date: $_selectedDate');
                    print('Start Time: $_selectedStartTime');
                    print('End Time: $_selectedEndTime');
                    print('Facility: $_selectedFacility');
                    // Add your actual booking submission logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Booking for $_selectedFacility submitted!'),
                        backgroundColor: Colors.green,
                      )
                      ,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select a date, time range, and facility.')),
                    );
                  }
                },
                color: const Color(0xff2c50cb),
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
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            // --- Booking Status Section (Enclosed in Container) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Adjust padding around the container
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0), // Optional: add a slight corner radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), // Shadow color
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0), // Padding inside the container
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
                  children: [
                    const Text(
                      "Booking Status:",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 16, // Increased font size for better visibility
                        color: Color(0xff000000),
                      ),
                    ),
                    const SizedBox(height: 10), // Spacing between title and content
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          _selectedFacility ?? "No Facility Booked", // Display selected facility or default text
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14, // Adjusted font size
                            color: Color(0xff000000),
                          ),
                        ),
                        Chip(
                          labelPadding:
                              const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                          label: const Text("Pending"), // This would also be dynamic
                          labelStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: Color(0xffff9800),
                          ),
                          backgroundColor: const Color(0x33ff9800),
                          elevation: 0,
                          shadowColor: const Color(0xff808080),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            side: const BorderSide(color: Color(0xffff9800), width: 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // --- End Booking Status Section ---
          ],
        ),
      ),
    );
  }
}