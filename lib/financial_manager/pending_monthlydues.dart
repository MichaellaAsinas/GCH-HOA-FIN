import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Assuming custom_app_bar.dart exists and is correctly implemented.
// As a placeholder, I'll create a basic one here if it's needed for the example to run.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: showBackButton ? BackButton() : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


class PendingMonthlyDuesPage extends StatefulWidget {
  const PendingMonthlyDuesPage({super.key});

  @override
  State<PendingMonthlyDuesPage> createState() => _PendingMonthlyDuesPageState();
}

class _PendingMonthlyDuesPageState extends State<PendingMonthlyDuesPage> {
  bool showNew = true;

  // --- Data ---
  final List<Map<String, String>> monthlyDuesPayments = [
    {'name': 'HO-0967', 'date': '2025-07-20 14:30:00', 'status': 'Pending'},
    {'name': 'HO-0974', 'date': '2025-07-17 10:00:00', 'status': 'Pending'},
    {'name': 'HO-0981', 'date': '2025-07-08 09:15:00', 'status': 'Pending'},
    {'name': 'HO-0992', 'date': '2025-06-30 16:45:00', 'status': 'Pending'},
    {'name': 'HO-1019', 'date': '2025-06-15 13:20:00', 'status': 'Pending'},
  ];

  final List<Map<String, String>> historyDues = [
    {'name': 'HO-0991', 'date': '2025-07-15 11:45:00', 'status': 'Approved'},
    {'name': 'HO-0992', 'date': '2025-06-22 08:30:00', 'status': 'Approved'},
    {'name': 'HO-0993', 'date': '2025-06-17 17:00:00', 'status': 'Declined'},
    {'name': 'HO-0994', 'date': '2025-05-16 15:15:00', 'status': 'Approved'},
  ];

  // --- State Variables for Filtering and Sorting ---
  List<Map<String, String>> _filteredDues = [];
  String _searchQuery = "";
  String _sortOption = "Recent";
  DateTime? _selectedYear;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _applyFilters();
  }

  // --- Logic for Filtering and Sorting ---
  void _filterDues(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void _applyFilters() {
    final dues = showNew ? monthlyDuesPayments : historyDues;
    List<Map<String, String>> filtered = [...dues];

    // Apply search query filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((p) {
        return p['name']!.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Apply year filter
    if (_selectedYear != null) {
      filtered = filtered.where((p) {
        final date = DateTime.parse(p['date']!);
        return date.year == _selectedYear!.year;
      }).toList();
    }

    // Apply sorting options
    if (_sortOption == "Recent" || _sortOption == "Descending") {
      filtered.sort((a, b) => b['date']!.compareTo(a['date']!));
    } else if (_sortOption == "Oldest" || _sortOption == "Ascending") {
      filtered.sort((a, b) => a['date']!.compareTo(b['date']!));
    } else if (_sortOption == "A-Z") {
      filtered.sort((a, b) => a['name']!.compareTo(b['name']!));
    } else if (_sortOption == "Z-A") {
      filtered.sort((a, b) => b['name']!.compareTo(a['name']!));
    }

    setState(() {
      _filteredDues = filtered;
    });
  }


  void _pickYear() async {
    FocusScope.of(context).unfocus();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedYear ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      helpText: "Filter by Year",
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null) {
      setState(() { // Ensure UI updates after picking a year
        _selectedYear = picked;
        _applyFilters();
      });
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Declined':
        return Colors.red;
      case 'Pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Monthly Dues",
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // --- Search and Filter UI ---
              Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: "Search by Dues ID",
                      prefixIcon: const Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: _filterDues,
                  ),
                ),
                const SizedBox(width: 10),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.filter_alt_outlined),
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
                    const PopupMenuItem(value: "Year", child: Text("Filter by Year")),
                    const PopupMenuItem(value: "Recent", child: Text("Recent")),
                    const PopupMenuItem(value: "Oldest", child: Text("Oldest")),
                    const PopupMenuItem(value: "A-Z", child: Text("ID A-Z")),
                    const PopupMenuItem(value: "Z-A", child: Text("ID Z-A")),
                    const PopupMenuItem(value: "Ascending", child: Text("Date Ascending")),
                    const PopupMenuItem(value: "Descending", child: Text("Date Descending")),
                  ],
                ),
              ],
            ),
            if (_selectedYear != null || _searchQuery.isNotEmpty || _sortOption != "Recent")
              Align(
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
                  icon: const Icon(Icons.cancel, color: Colors.redAccent),
                  label: const Text("Clear Filter", style: TextStyle(color: Colors.redAccent)),
                ),
              ),
            const SizedBox(height: 16),

            // --- Tab Buttons (New / History) ---
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showNew = true;
                        _applyFilters();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: showNew ? Colors.grey.shade300 : Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text("New"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showNew = false;
                        _applyFilters();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !showNew ? Colors.grey.shade300 : Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text("History"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // --- List of Dues ---
Expanded(
  child: _filteredDues.isEmpty
      ? const Center(child: Text("No membership payments match the filter."))
      : ListView.builder(
          itemCount: _filteredDues.length,
          itemBuilder: (context, index) {
            final payment = _filteredDues[index];
            final formattedDate = DateFormat.yMMMMd().add_jm().format(DateTime.parse(payment['date']!));

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFD1C4E9),
                        child: Icon(Icons.person, color: Color(0xFF512DA8)),
                      ),
                      title: Text(
                        "Membership Payment\n${payment['name']}",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(formattedDate),
                      trailing: IntrinsicWidth(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              payment['status']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _getStatusColor(payment['status']!),
                              ),
                            ),
                            if (showNew)
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/pendingMSReceipt',
                                    arguments: {'date': payment['date']},
                                  );
                                },
                                child: const Text("View Details"),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Divider(
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                    color: Colors.grey,
                  ),
                ),
              ],
            );
          },
        ),
),

          ],
        ),
      ),
    );
  }
}
