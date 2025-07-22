import 'package:flutter/material.dart';
import '../main.dart'; // Assuming customPrimaryColor is defined here

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  // State variable to hold the selected rating (1 to 5)
  int _selectedRating = 0;

  // State variable for the selected feedback type (General or Bug Report)
  String? _feedbackType;

  // Controllers for the text fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
        title: const Text("Feedback", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
        backgroundColor: customPrimaryColor,
        leading: BackButton(
          color: Color(0xffffffff),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // "Tell us all about it!" text
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 20), // Increased top padding from 0 to 40
                  child: Text(
                    "Tell us all about it!",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                // Radio buttons for General and Bug Report, side-by-side
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the radio buttons
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Radio button for General feedback
                      Row( // Wrap in a Row to keep text next to radio
                        mainAxisSize: MainAxisSize.min, // Keep this row compact
                        children: [
                          Radio<String>(
                            value: "General",
                            groupValue: _feedbackType,
                            onChanged: (String? value) {
                              setState(() {
                                _feedbackType = value;
                                _selectedRating = 0; // Reset stars when radio button changes
                              });
                            },
                            activeColor: Color(0xff3a57e8), // Blue color for the inner dot when selected
                            autofocus: false,
                            splashRadius: 20,
                            hoverColor: Color(0x42000000),
                            // Modified fillColor to make the entire radio button black when unselected
                            fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states){
                              if(states.contains(WidgetState.selected)){
                                return Color(0xff3a57e8); // Filled color (blue) when selected
                              }
                              return Colors.black; // Entire radio button is black when unselected
                            }),
                          ),
                          Text(
                            "General",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 12,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20), // Add some space between the radio options
                      // Radio button for Bug Report
                      Row( // Wrap in a Row to keep text next to radio
                        mainAxisSize: MainAxisSize.min, // Keep this row compact
                        children: [
                          Radio<String>(
                            value: "Bug Report",
                            groupValue: _feedbackType,
                            onChanged: (String? value) {
                              setState(() {
                                _feedbackType = value;
                                _selectedRating = 0; // Reset stars when radio button changes
                              });
                            },
                            activeColor: Color(0xff3a57e8), // Blue color for the inner dot when selected
                            autofocus: false,
                            splashRadius: 20,
                            hoverColor: Color(0x42000000),
                            // Modified fillColor to make the entire radio button black when unselected
                            fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states){
                              if(states.contains(WidgetState.selected)){
                                return Color(0xff3a57e8); // Filled color (blue) when selected
                              }
                              return Colors.black; // Entire radio button is black when unselected
                            }),
                          ),
                          Text(
                            "Bug Report",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 12,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Clickable rating stars
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < _selectedRating ? Icons.star : Icons.star_border,
                          color: Color(0xffffe200),
                          size: 24,
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedRating = index + 1; // Set rating from 1 to 5
                          });
                        },
                      );
                    }),
                  ),
                ),
                // Title TextField
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: TextField(
                    controller: _titleController,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                      ),
                      hintText: "Title",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                      filled: true,
                      fillColor: Color(0xfff2f2f3),
                      isDense: false,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    ),
                  ),
                ),
                // Description TextField
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: TextField(
                    controller: _descriptionController,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    maxLines: 8,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                      ),
                      hintText: "Comment on the comment box down below!",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                      filled: true,
                      fillColor: Color(0xfff2f2f3),
                      isDense: false,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    ),
                  ),
                ),
                // Submit Button
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: MaterialButton(
                    onPressed: () {
                    final String title = _titleController.text.trim();
                    final String description = _descriptionController.text.trim();

                    if (_feedbackType == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select a feedback type.')),
                      );
                      return;
                    }

                    if (_selectedRating == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select a star rating.')),
                      );
                      return;
                    }

                    if (title.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter a title.')),
                      );
                      return;
                    }

                    if (description.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter a comment.')),
                      );
                      return;
                    }

                    // If all fields are valid, proceed
                    print("Feedback Type: $_feedbackType");
                    print("Rating: $_selectedRating stars");
                    print("Title: $title");
                    print("Description: $description");

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Feedback Submitted!')),
                    );

                    // Clear form after submission (optional)
                    setState(() {
                      _feedbackType = null;
                      _selectedRating = 0;
                      _titleController.clear();
                      _descriptionController.clear();
                    });
                  },

                    color: Color(0xff2c50cb),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Color(0xff808080), width: 1),
                    ),
                    padding: EdgeInsets.all(16),
                    textColor: Color(0xffffffff),
                    height: 40,
                    minWidth: 140,
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
                // Disclaimer text
                Text(
                  "*Feedback will be sent and reviewed by the GCH HOA Connect team*",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 8,
                    color: Color(0x80000000),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}