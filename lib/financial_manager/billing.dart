import 'package:flutter/material.dart';

class FMBillingPage extends StatefulWidget {
  @override
  _FMBillingPageState createState() => _FMBillingPageState();
}

class _FMBillingPageState extends State<FMBillingPage> with TickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Recent';

  List<Map<String, String>> _allMembershipReceipts = [
    {"title": "Membership Receipt", "date": "2025-07-16"},
    {"title": "Membership Receipt", "date": "2024-03-03"},
    {"title": "Membership Receipt", "date": "2023-09-15"},
    {"title": "Membership Receipt", "date": "2023-01-08"},
    {"title": "Membership Receipt", "date": "2022-11-22"},
    {"title": "Membership Receipt", "date": "2023-03-16"},
    {"title": "Membership Receipt", "date": "2024-02-12"},
    {"title": "Membership Receipt", "date": "2022-09-12"},
    {"title": "Membership Receipt", "date": "2022-01-19"},
    {"title": "Membership Receipt", "date": "2024-04-14"},
    {"title": "Membership Receipt", "date": "2023-10-21"},
  ];

  List<Map<String, String>> _allMonthlyDuesReceipts = [
    {"title": "Monthly Dues Receipt", "date": "2025-07-10"},
    {"title": "Monthly Dues Receipt", "date": "2024-06-12"},
    {"title": "Monthly Dues Receipt", "date": "2024-02-01"},
    {"title": "Monthly Dues Receipt", "date": "2023-10-30"},
    {"title": "Monthly Dues Receipt", "date": "2024-06-12"},
    {"title": "Monthly Dues Receipt", "date": "2022-03-29"},
    {"title": "Monthly Dues Receipt", "date": "2022-09-25"},
  ];

  List<Map<String, String>> _filteredMembershipReceipts = [];
  List<Map<String, String>> _filteredMonthlyDuesReceipts = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _filteredMembershipReceipts = [..._allMembershipReceipts];
    _filteredMonthlyDuesReceipts = [..._allMonthlyDuesReceipts];
    _applyFilters();
  }

  void _applyFilters() {
    String query = _searchController.text.toLowerCase();

    List<Map<String, String>> membership = _allMembershipReceipts.where((r) {
      return r["title"]!.toLowerCase().contains(query) || r["date"]!.toLowerCase().contains(query);
    }).toList();

    List<Map<String, String>> dues = _allMonthlyDuesReceipts.where((r) {
      return r["title"]!.toLowerCase().contains(query) || r["date"]!.toLowerCase().contains(query);
    }).toList();

    int sortByDateAsc(a, b) => DateTime.parse(a["date"]!).compareTo(DateTime.parse(b["date"]!));
    int sortByDateDesc(a, b) => DateTime.parse(b["date"]!).compareTo(DateTime.parse(a["date"]!));

    switch (_selectedFilter) {
      case "Recent":
        membership.sort(sortByDateDesc);
        dues.sort(sortByDateDesc);
        break;
      case "Oldest":
        membership.sort(sortByDateAsc);
        dues.sort(sortByDateAsc);
        break;
      case "A-Z":
        membership.sort((a, b) => a["title"]!.compareTo(b["title"]!));
        dues.sort((a, b) => a["title"]!.compareTo(b["title"]!));
        break;
      case "Z-A":
        membership.sort((a, b) => b["title"]!.compareTo(a["title"]!));
        dues.sort((a, b) => b["title"]!.compareTo(a["title"]!));
        break;
    }

    setState(() {
      _filteredMembershipReceipts = membership;
      _filteredMonthlyDuesReceipts = dues;
    });
  }

  void _goToMembershipReceipt(String date) {
    Navigator.pushNamed(context, '/membershipReceipt', arguments: {"date": date});
  }

  void _goToMonthlyDuesReceipt(String date) {
    Navigator.pushNamed(context, '/monthlyDuesReceipt', arguments: {"date": date});
  }

  Widget _buildReceiptTile(String title, String date, VoidCallback onViewPressed) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300, width: 1.2),
    ),
    child: Row(
      children: [
        Icon(Icons.receipt, size: 32, color: Colors.indigo),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
              Text("Date: $date"),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: onViewPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text("View Receipt", style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}


  Widget _buildMembershipTab() {
    if (_filteredMembershipReceipts.isEmpty) {
      return Center(child: Text("No membership receipts match the filter."));
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: _filteredMembershipReceipts.map((receipt) {
        return _buildReceiptTile(
          receipt["title"]!,
          receipt["date"]!,
          () => _goToMembershipReceipt(receipt["date"]!),
        );
      }).toList(),
    );
  }

  Widget _buildMonthlyDuesTab() {
    if (_filteredMonthlyDuesReceipts.isEmpty) {
      return Center(child: Text("No monthly dues receipts match the filter."));
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: _filteredMonthlyDuesReceipts.map((receipt) {
        return _buildReceiptTile(
          receipt["title"]!,
          receipt["date"]!,
          () => _goToMonthlyDuesReceipt(receipt["date"]!),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    backgroundColor: Colors.blue, // AppBar color
    title: const Text(
      "Billing — Membership Receipt",
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Row(
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
                ),
                ),
                SizedBox(width: 12),
                PopupMenuButton<String>(
                  icon: Icon(Icons.filter_alt_outlined),
                  tooltip: "Sort Options",
                  onSelected: (value) {
                    setState(() {
                      _selectedFilter = value;
                      _applyFilters();
                    });
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(value: "Recent", child: Text("Recent")),
                    PopupMenuItem(value: "Oldest", child: Text("Oldest")),
                    PopupMenuItem(value: "A-Z", child: Text("Title A-Z")),
                    PopupMenuItem(value: "Z-A", child: Text("Title Z-A")),
                  ],
                ),
              ],
            ),
          ),
          if (_searchController.text.isNotEmpty || _selectedFilter != 'Recent')
            Padding(
              padding: const EdgeInsets.only(top: 4, right: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _selectedFilter = 'Recent';
                      _applyFilters();
                    });
                  },
                  icon: Icon(Icons.cancel, color: Colors.redAccent),
                  label: Text("Clear Filter", style: TextStyle(color: Colors.redAccent)),
                ),
              ),
            ),
          TabBar(
            controller: _tabController,
            labelColor: Colors.indigo,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.indigo,
            tabs: [
              Tab(text: 'Membership'),
              Tab(text: 'Monthly Dues'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMembershipTab(),
                _buildMonthlyDuesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
