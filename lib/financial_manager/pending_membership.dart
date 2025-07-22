import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


  final TextEditingController _searchController = TextEditingController();

class PendingMembershipPage extends StatefulWidget {
  const PendingMembershipPage({super.key});

  @override
  State<PendingMembershipPage> createState() => _PendingMembershipPageState();
}

class _PendingMembershipPageState extends State<PendingMembershipPage> {
  bool showNew = true;

  final List<Map<String, String>> membershipPayments = [
    {'name': 'HO-0912', 'date': '2025-07-20 14:30:00', 'status': 'Pending'},
    {'name': 'HO-0920', 'date': '2025-07-17 09:45:00', 'status': 'Pending'},
    {'name': 'HO-0933', 'date': '2025-07-08 11:20:00', 'status': 'Pending'},
    {'name': 'HO-0941', 'date': '2025-06-30 16:10:00', 'status': 'Pending'},
    {'name': 'HO-0949', 'date': '2025-06-15 10:00:00', 'status': 'Pending'},
    {'name': 'HO-0955', 'date': '2025-06-26 13:15:00', 'status': 'Pending'},
    {'name': 'HO-0960', 'date': '2025-05-21 15:50:00', 'status': 'Pending'},
  ];

  final List<Map<String, String>> historyPayments = [
    {'name': 'HO-0012', 'date': '2025-07-15 14:00:00', 'status': 'Approved'},
    {'name': 'HO-0225', 'date': '2025-06-22 10:30:00', 'status': 'Approved'},
    {'name': 'HO-0777', 'date': '2025-06-17 09:00:00', 'status': 'Declined'},
    {'name': 'HO-0116', 'date': '2025-05-16 08:00:00', 'status': 'Approved'},
    {'name': 'HO-0404', 'date': '2025-04-04 12:00:00', 'status': 'Approved'},
  ];

  List<Map<String, String>> _filteredPayments = [];
  String _searchQuery = "";
  String _sortOption = "Recent";
  DateTime? _selectedYear;

  @override
  void initState() {
    super.initState();
    _applyFilters();
  }

  void _filterPayments(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void _applyFilters() {
    final payments = showNew ? membershipPayments : historyPayments;
    List<Map<String, String>> filtered = [...payments];

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((p) {
        return p['name']!.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    if (_selectedYear != null) {
      filtered = filtered.where((p) {
        final date = DateTime.parse(p['date']!);
        return date.year == _selectedYear!.year;
      }).toList();
    }

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
      _filteredPayments = filtered;
    });
  }

  void _pickYear() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      helpText: "Filter by Year",
    );
    if (picked != null) {
      _selectedYear = picked;
      _applyFilters();
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
          "Membership Receipt",
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
            Row(
              children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: "Search by Membership ID",
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
                  onChanged: _filterPayments,
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
                      _sortOption = value;
                      _applyFilters();
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

Expanded(
  child: _filteredPayments.isEmpty
      ? const Center(child: Text("No membership payments match the filter."))
      : ListView.separated(
          itemCount: _filteredPayments.length,
          separatorBuilder: (_, __) => Divider(
            color: Colors.grey.shade300,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
          itemBuilder: (context, index) {
            final payment = _filteredPayments[index];
            final formattedDate = DateFormat.yMMMMd().add_jm().format(DateTime.parse(payment['date']!));

            return ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.indigo.shade100,
                child: Icon(Icons.person, color: Colors.indigo.shade700),
              ),
              title: Text(
                "Membership Payment\n${payment['name']}",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(formattedDate),
              trailing: Column(
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
