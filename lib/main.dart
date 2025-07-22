import 'package:flutter/material.dart';
import 'homeowner/login.dart';
import 'homeowner/register_page.dart';
import 'homeowner/dashboard_page.dart';
import 'homeowner/profile_page.dart';
import 'homeowner/vehicle_sticker_registration_page.dart';
import 'homeowner/billing_page.dart';
import 'homeowner/facility_booking.dart';
import 'homeowner/feedback.dart';
import 'homeowner/incident_report.dart';
import 'homeowner/service_req.dart';
import 'homeowner/landlord_app.dart';
import 'homeowner/complaint.dart';

import 'financial_manager/dashboard.dart';
import 'financial_manager/profile.dart';
import 'financial_manager/homeowner.dart';
import 'financial_manager/billing.dart';
import 'financial_manager/membership_receipt.dart';
import 'financial_manager/monthly_dues_receipt.dart';
import 'financial_manager/pending_membership.dart';
import 'financial_manager/pending_msreceipt.dart';
import 'financial_manager/pending_monthlydues.dart';
import 'financial_manager/pending_mdreceipt.dart';
import 'financial_manager/homeowner_details.dart';
import 'financial_manager/announcement.dart';
import 'financial_manager/gcash.dart';

MaterialColor customPrimaryColor = MaterialColor(
  0xFF0056D8, // Your primary color value (e.g., a shade of blue)
  <int, Color>{
    50: Color(0xFFE0F2F7),
    100: Color(0xFFB3E0ED),
    200: Color(0xFF80D0E2),
    300: Color(0xFF4DBFD8),
    400: Color(0xFF26B2D1),
    500: Color(0xFF00A5CB), // Your main color
    600: Color(0xFF009CC5),
    700: Color(0xFF0090BE),
    800: Color(0xFF0085B8),
    900: Color(0xFF0073AD),
  },
);

const Color customSecondaryColor = Color(0xFFFFA000);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GCH HOA App',
      theme: ThemeData(
        primarySwatch: customPrimaryColor, // Keep this for overall primary usage
        fontFamily: 'TikTok', // Keep your custom font

        // Add the colorScheme to define primary, secondary, and other on-colors
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: customPrimaryColor,
          accentColor: customSecondaryColor, // Accent color is often used for selection highlights
        ).copyWith(
          // For Material 3, `secondary` is often used instead of `accentColor`
          // and directly impacts selection in pickers
          secondary: customPrimaryColor, // Or customSecondaryColor if you prefer a different accent
          surface: Colors.white, // Default background for dialogs
          onPrimary: Colors.white, // Text/icons that appear on primary color
          onSurface: Colors.black87, // Text/icons that appear on surface color
        )),
      initialRoute: '/',
      routes: {
        '/': (_) => LoginPage(), 
        '/register': (_) => RegisterPage(),
        '/dashboard': (_) => DashboardPage(),
        '/profile': (_) => ProfilePage(),
        '/vehicleSticker': (_) => VehicleStickerRegistrationPage(),
        '/billing': (_) => BillingPage(),
        '/facilityBooking': (_) => FacilityBooking(),
        '/feedback': (_) => FeedbackPage(),
        '/complaint': (_) => Complaint(),
        '/incidentReport': (_) => IncidentReportPage(),
        '/serviceRequest': (_) => ServiceRequestPage(),
        '/landlordApplication': (_) => LandlordApplicationPage(),
        
        '/fm_profile': (context) => FMProfilePage(),
        '/fm_dashboard': (context) => const FMDashboardPage(),
        '/homeowners': (context) => HomeownersPage(),
        '/fm_billing': (context) => FMBillingPage(),
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