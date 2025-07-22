import 'package:flutter/material.dart';
import 'theme_config.dart';
import 'login.dart';
import 'dashboard.dart';
import 'profile.dart';
import 'homeowner.dart';
import 'billing.dart';
import 'membership_receipt.dart';
import 'monthly_dues_receipt.dart';
import 'pending_membership.dart';
import 'pending_msreceipt.dart';
import 'pending_monthlydues.dart';
import 'pending_mdreceipt.dart';
import 'homeowner_details.dart';
import 'announcement.dart';
import 'gcash.dart';


void main() {
  runApp(GCHApp());
}

class GCHApp extends StatefulWidget {
  @override
  State<GCHApp> createState() => _GCHAppState();
}

class _GCHAppState extends State<GCHApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GCH HOA Manager',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/profile': (context) => FMProfilePage(),
        '/dashboard': (context) => const FMDashboardPage(),
        '/homeowners': (context) => HomeownersPage(),
        '/billing': (context) => FMBillingPage(),
        '/membershipReceipt': (context) => const MembershipReceiptPage(),
        '/monthlyDuesReceipt': (context) => MonthlyDuesReceiptPage(),
        '/pendingMembership': (context) => const PendingMembershipPage(),
        '/pendingMonthlyDues': (context) => const PendingMonthlyDuesPage(),
        '/homeownerDetails': (context) => HomeownerDetailsPage(),
        '/pendingMSReceipt': (context) => const PendingMSReceiptPage(),
        '/pendingMonthlyDuesReceipt': (context) => const PendingMDReceiptPage(),
        '/announcement': (context) => AnnouncementPage(),
        '/gcashReceipt': (context) => const GCashReceiptPage(),
      },
    );
  }
}
