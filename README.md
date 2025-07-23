# GCH HOA Financial Management System

A comprehensive Flutter-based mobile application for Homeowners Association (HOA) financial management and community administration.

## 📱 Overview

The GCH HOA App is a dual-user system designed to streamline HOA operations, financial management, and community communication. It provides separate interfaces for homeowners and financial managers with role-based access control.

## ✨ Key Features

### 🏠 Homeowner Features
- **Dashboard**: Personal overview of HOA activities and notifications
- **Billing & Payments**: View and manage monthly dues, membership fees
- **Facility Booking**: Reserve community facilities (basketball court, chapel, swimming pool, clubhouse)
- **Service Requests**: Submit maintenance and repair requests
- **Incident Reporting**: Report community incidents and violations
- **Complaints & Feedback**: Submit complaints and provide feedback
- **Vehicle Registration**: Register vehicle stickers for community access
- **Payment History**: Track payment records and receipts
- **Profile Management**: Update personal information and preferences

### 💼 Financial Manager Features
- **Administrative Dashboard**: Comprehensive overview of HOA operations
- **Homeowner Management**: View and manage all homeowner accounts
- **Financial Operations**: Process membership fees and monthly dues
- **Receipt Management**: Handle payment receipts and confirmations
- **Billing Oversight**: Manage billing cycles and payment tracking
- **Announcements**: Create and distribute community announcements
- **GCash Integration**: Process digital payments through GCash
- **Pending Operations**: Review and approve pending transactions

## 🏗️ Architecture

### Technology Stack
- **Framework**: Flutter (Dart SDK ^3.8.1)
- **State Management**: Provider pattern
- **Local Storage**: SharedPreferences
- **UI Framework**: Material Design with custom theming
- **Typography**: TikTok Sans font family
- **Date/Time Picker**: Omni DateTime Picker

### Project Structure
```
lib/
├── main.dart                     # Application entry point and routing
├── homeowner/                    # Homeowner module
│   ├── dashboard_page.dart       # Homeowner dashboard
│   ├── billing_page.dart         # Billing and payment management
│   ├── facility_booking.dart     # Facility reservation system
│   ├── service_req.dart          # Service request management
│   ├── incident_report.dart      # Incident reporting system
│   ├── complaint.dart            # Complaint submission
│   ├── feedback.dart             # Feedback system
│   ├── profile_page.dart         # Profile management
│   ├── register_page.dart        # User registration
│   ├── login.dart                # Authentication
│   └── vehicle_sticker_registration_page.dart
└── financial_manager/            # Financial manager module
    ├── dashboard.dart            # FM dashboard
    ├── homeowner.dart            # Homeowner management
    ├── billing.dart              # Billing operations
    ├── membership_receipt.dart   # Membership fee receipts
    ├── monthly_dues_receipt.dart # Monthly dues receipts
    ├── pending_*.dart            # Pending operations management
    ├── announcement.dart         # Announcement system
    ├── gcash.dart                # GCash payment integration
    ├── profile.dart              # FM profile management
    └── components/
        └── custom_app_bar.dart   # Reusable UI components
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK ^3.8.1
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd GCH-HOA-FIN
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure assets**
   Ensure all assets in the `assets/` directory are properly configured in `pubspec.yaml`

4. **Run the application**
   ```bash
   flutter run
   ```

### Build for Production

**Android**
```bash
flutter build apk --release
```

**iOS**
```bash
flutter build ios --release
```

**Web**
```bash
flutter build web
```

## 🔐 Authentication System

The application uses a role-based authentication system with specific SR Code formats:

- **Homeowners**: `HO-XXXXX` (e.g., HO-12345)
- **Financial Managers**: `FM-XXXXX` (e.g., FM-54321)

### Login Flow
1. Enter SR Code in the specified format
2. System validates format and user type
3. Redirects to appropriate dashboard based on role

## 🛠️ Development

### Dependencies
```yaml
dependencies:
  flutter: sdk
  intl: ^0.18.1              # Internationalization
  provider: ^6.1.1           # State management
  shared_preferences: ^2.0.15 # Local storage
  cupertino_icons: ^1.0.8    # iOS-style icons
  omni_datetime_picker: ^2.1.1 # Date/time selection
```

### Code Style
- Follows Flutter/Dart conventions
- Uses linting rules defined in `analysis_options.yaml`
- Material Design principles with custom theming

### Testing
```bash
flutter test
```

## 🎨 UI/UX Design

### Theme Configuration
- **Primary Color**: Custom blue palette (#0056D8)
- **Secondary Color**: Orange accent (#FFA000)
- **Font Family**: TikTok Sans (multiple weights)
- **Design System**: Material Design 3.0 principles

### Responsive Design
- Adaptive layouts for different screen sizes
- Optimized for mobile-first approach
- Consistent spacing and typography hierarchy

## 🔮 Future Enhancements

The application is designed for future expansion with planned enhancements including:

- **Enhanced RBAC**: Implementation of 3 customer roles and 10 authority levels
- **Modular Architecture**: Component-based architecture with service injection
- **Advanced Permissions**: Granular permission system with role-specific access
- **Accessibility**: WCAG 2.1 AA compliance implementation
- **Modern UI/UX**: Enhanced responsive design and user experience

## 📱 Platform Support

- ✅ Android
- ✅ iOS  
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📞 Support

For support and questions, please contact the development team or create an issue in the repository.

---

**Built with ❤️ using Flutter**
