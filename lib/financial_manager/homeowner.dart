import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class HomeownersPage extends StatefulWidget {
  @override
  _HomeownersPageState createState() => _HomeownersPageState();
}

class _HomeownersPageState extends State<HomeownersPage> {
  List<Map<String, String>> _allHomeowners = [
    {"name": "Hannah Mendoza", "id": "HO-001", "email": "h.mendoza@gch.com", "joined": "2023-03-10"},
    {"name": "Sabina Hernandez", "id": "HO-01991", "email": "sab_hernandez@gch.com", "joined": "2022-01-15"},
    {"name": "Joshua Braza", "id": "HO-003", "email": "braza@gch.com", "joined": "2024-07-01"},
    {"name": "Julianne Buenafe", "id": "HO-0912", "email": "juls_b@gch.com", "joined": "2023-08-02"},
    {"name": "Jay Renz Ilagan", "id": "HO-0920", "email": "jayrenz@gch.com", "joined": "2023-06-20"},
    {"name": "Robi Gonzales", "id": "HO-0933", "email": "robi_g@gch.com", "joined": "2022-11-10"},
    {"name": "Vincent Acupan", "id": "HO-0941", "email": "vincent@gch.com", "joined": "2023-01-09"},
    {"name": "Vince Dimaandal", "id": "HO-0949", "email": "vince@gch.com", "joined": "2024-03-15"},
    {"name": "Chloie Festejo", "id": "HO-0955", "email": "chloie@gch.com", "joined": "2023-05-18"},
    {"name": "Eduardo Lincallo", "id": "HO-0960", "email": "eduardo@gch.com", "joined": "2023-09-30"},
    {"name": "Zyrus Alog", "id": "HO-0967", "email": "zy_alog@gch.com", "joined": "2024-01-05"},
    {"name": "Sarah Ignacio", "id": "HO-0974", "email": "sarah@gch.com", "joined": "2022-06-25"},
    {"name": "Michaella Asinas", "id": "HO-0981", "email": "michaella@gch.com", "joined": "2023-12-22"},
    {"name": "Mark Sandoval", "id": "HO-0992", "email": "mark_s@gch.com", "joined": "2024-04-10"},
    {"name": "Paul Arguelles", "id": "HO-1019", "email": "paul_a@gch.com", "joined": "2023-02-28"},
    {"name": "Aethelbelle Cabatay", "id": "HO-1028", "email": "ae_cabatay@gch.com", "joined": "2024-05-01"},
  ];

  List<Map<String, String>> _filteredHomeowners = [];
  String _searchQuery = "";
  String _sortOption = "Recent";
  DateTime? _selectedYear;

  @override
  void initState() {
    super.initState();
    _filteredHomeowners = [..._allHomeowners];
    _applyFilters();
  }

  void _filterHomeowners(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void _applyFilters() {
    List<Map<String, String>> filtered = [..._allHomeowners];

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((ho) {
        return ho['name']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            ho['id']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            ho['email']!.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    if (_selectedYear != null) {
      filtered = filtered.where((ho) {
        final joined = DateTime.parse(ho['joined']!);
        return joined.year == _selectedYear!.year;
      }).toList();
    }

    if (_sortOption == "A-Z") {
      filtered.sort((a, b) => a['name']!.compareTo(b['name']!));
    } else if (_sortOption == "Z-A") {
      filtered.sort((a, b) => b['name']!.compareTo(a['name']!));
    } else if (_sortOption == "SR-Code") {
      filtered.sort((a, b) => a['id']!.compareTo(b['id']!));
    } else if (_sortOption == "Ascending") {
      filtered.sort((a, b) => a['joined']!.compareTo(b['joined']!));
    } else if (_sortOption == "Descending" || _sortOption == "Recent") {
      filtered.sort((a, b) => b['joined']!.compareTo(a['joined']!));
    } else if (_sortOption == "Oldest") {
      filtered.sort((a, b) => a['joined']!.compareTo(b['joined']!));
    }

    setState(() {
      _filteredHomeowners = filtered;
    });
  }

  void _pickYear() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
      helpText: "Select Join Date (Year)",
    );
    if (picked != null) {
      setState(() {
        _selectedYear = picked;
        _applyFilters();
      });
    }
  }

  void _goToBilling(BuildContext context, Map<String, String> homeowner) {
    Navigator.pushNamed(context, '/fm_billing', arguments: homeowner);
  }

  void _goToHomeownerDetails(BuildContext context, Map<String, String> homeowner) {
    Navigator.pushNamed(context, '/homeownerDetails', arguments: homeowner);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedYear != null || _searchQuery.isNotEmpty || _sortOption != "Recent") {
          setState(() {
            _selectedYear = null;
            _searchQuery = "";
            _sortOption = "Recent";
            _applyFilters();
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue, // AppBar color
          title: const Text(
            "Homeowners",
            style: TextStyle(
              color: Colors.white,             // White title text
              fontWeight: FontWeight.bold,     // Optional: bold text
              fontSize: 18,                    // Optional: adjust size
            ),
          ),
          leading: Tooltip(
            message: 'Back',
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white), // White icon
              onPressed: () => Navigator.pop(context),
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white), // Ensures other icons are white
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Search by Name, ID, or Email",
                        prefixIcon: Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: _filterHomeowners,
                    ),
                  ),
                  SizedBox(width: 12),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.filter_alt_outlined),
                    tooltip: "Filter & Sort",
                    onSelected: (value) {
                      if (value == 'Year') {
                        _pickYear();
                      } else {
                        setState(() {
                          _sortOption = value;
                          _applyFilters();
                        });
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(value: "Year", child: Text("Filter by Year")),
                      PopupMenuItem(value: "Recent", child: Text("Recent")),
                      PopupMenuItem(value: "Oldest", child: Text("Oldest")),
                      PopupMenuItem(value: "A-Z", child: Text("Name A-Z")),
                      PopupMenuItem(value: "Z-A", child: Text("Name Z-A")),
                      PopupMenuItem(value: "SR-Code", child: Text("By SR-Code")),
                      PopupMenuItem(value: "Ascending", child: Text("Joined Ascending")),
                      PopupMenuItem(value: "Descending", child: Text("Joined Descending")),
                    ],
                  ),
                ],
              ),
              if (_selectedYear != null || _searchQuery.isNotEmpty || _sortOption != "Recent")
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _selectedYear = null;
                          _searchQuery = "";
                          _sortOption = "Recent";
                          _applyFilters();
                        });
                      },
                      icon: Icon(Icons.cancel, color: Colors.redAccent),
                      label: Text("Clear Filter", style: TextStyle(color: Colors.redAccent)),
                    ),
                  ),
                ),
              if (_selectedYear != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Filtered by Year: ${_selectedYear!.year}",
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                ),
              SizedBox(height: 16),
              Expanded(
              child: _filteredHomeowners.isEmpty
                  ? Center(child: Text("No homeowners match the filter."))
                  : ListView.separated(
                      itemCount: _filteredHomeowners.length,
                      separatorBuilder: (_, __) => Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                        indent: 16,
                        endIndent: 16,
                      ),
                      itemBuilder: (context, index) {
                        final ho = _filteredHomeowners[index];
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          leading: GestureDetector(
                            onTap: () => _goToHomeownerDetails(context, ho),
                            child: CircleAvatar(
                              backgroundColor: Colors.indigo.shade100,
                              child: Icon(Icons.person, color: Colors.indigo.shade700),
                            ),
                          ),
                          title: Text(
                            ho['name']!,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            '${ho['id']} • Joined: ${DateFormat.yMMMd().format(DateTime.parse(ho['joined']!))}',
                          ),
                          // ... (your imports and class declarations stay unchanged)

                          trailing: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: ElevatedButton(
                              onPressed: () => _goToBilling(context, ho),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                                    if (states.contains(MaterialState.hovered)) {
                                      return Colors.indigo.shade700;
                                    }
                                    return Colors.indigo;
                                  },
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              child: const Text(
                                "View Details",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
