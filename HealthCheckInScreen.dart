import 'package:flutter/material.dart';

void main() {
  runApp(const HealthCheckInApp());
}

class HealthCheckInApp extends StatelessWidget {
  const HealthCheckInApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Check-In',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFFDEDEDE),
        fontFamily: 'Montserrat',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      home: const MainNavigation(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // The pages are already arranged to match the bottom navigation bar order:
  // Home, Calendar, Notifications, Wellness, Profile
  final List<Widget> _pages = <Widget>[
    const DashboardPage(), // Corresponds to 'Home'
    const CalendarPage(), // Corresponds to 'Calendar'
    const NotificationPage(), // Corresponds to 'Notifications'
    const HealthStatsPage(), // Corresponds to 'Wellness'
    const ProfilePage(), // Corresponds to 'Profile'
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey[700],
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        // The bottom navigation bar items are already in the desired sequence:
        // Home, Calendar, Notifications, Wellness, Profile
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "Calendar"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none), label: "Notifications"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Wellness"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DashboardCard> dashboardCards = <DashboardCard>[
      DashboardCard(
        title: "Blood Pressure",
        color: const Color(0xFFFF9837),
        icon: Icons.monitor_heart,
        onTap: () {
          Navigator.of(context).push<void>(
            MaterialPageRoute<void>(
                builder: (BuildContext context) => const BloodPressurePage()),
          );
        },
      ),
      DashboardCard(
        title: "Sugar Level",
        color: const Color(0xFF37FF6C),
        icon: Icons.bloodtype,
        onTap: () {
          Navigator.of(context).push<void>(
            MaterialPageRoute<void>(
                builder: (BuildContext context) => const SugarLevelPage()),
          );
        },
      ),
      DashboardCard(
        title: "Temperature",
        color: const Color(0xFF42A3F4),
        icon: Icons.thermostat,
        onTap: () {
          Navigator.of(context).push<void>(
            MaterialPageRoute<void>(
                builder: (BuildContext context) => const TemperaturePage()),
          );
        },
      ),
      DashboardCard(
        title: "Heart Rate",
        color: const Color(0xFFCD5C5C),
        icon: Icons.favorite,
        onTap: () {
          Navigator.of(context).push<void>(
            MaterialPageRoute<void>(
                builder: (BuildContext context) => const HeartRatePage()),
          );
        },
      ),
      DashboardCard(
        title: "Emergency SOS",
        color: Colors.red.shade600,
        icon: Icons.warning,
        onTap: () {
          Navigator.of(context).push<void>(
            MaterialPageRoute<void>(
                builder: (BuildContext context) => const EmergencySosPage()),
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Check-In'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          const SizedBox(height: 10),
          // First four cards in a 2x2 grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: dashboardCards.sublist(0, 4),
          ),
          const SizedBox(height: 20), // Spacing between the grid and the centered card
          // The 5th card (SOS) centered in its own row
          Center(
            child: SizedBox(
              // Calculate width for a single card to match the grid cell width
              width: (MediaQuery.of(context).size.width - (20 * 2) - 20) / 2,
              child: dashboardCards[4], // The SOS card
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;
  final VoidCallback? onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.color,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // onTap is now provided by the parent
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(color.red, color.green, color.blue, 0.8),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 4,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 22,
              child: Icon(icon, color: Colors.black, size: 22),
            ),
            const SizedBox(height: 8),
            Text(
              title.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: const Center(
        child: Text(
          'Calendar Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: const Center(
        child: Text(
          'Notifications Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class HealthStatsPage extends StatelessWidget {
  const HealthStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellness Statistics'),
      ),
      body: const Center(
        child: Text(
          'Wellness Statistics Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Text(
          'Profile Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// New Pages for Dashboard Cards
class BloodPressurePage extends StatelessWidget {
  const BloodPressurePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Pressure Details'),
      ),
      body: const Center(
        child: Text(
          'Blood Pressure Monitoring and History',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class SugarLevelPage extends StatelessWidget {
  const SugarLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sugar Level Details'),
      ),
      body: const Center(
        child: Text(
          'Sugar Level Tracking and Trends',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class TemperaturePage extends StatelessWidget {
  const TemperaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Details'),
      ),
      body: const Center(
        child: Text(
          'Body Temperature Log',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class HeartRatePage extends StatelessWidget {
  const HeartRatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heart Rate Details'),
      ),
      body: const Center(
        child: Text(
          'Heart Rate Monitoring and Analysis',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class EmergencySosPage extends StatelessWidget {
  const EmergencySosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency SOS'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.warning_amber_rounded,
              color: Colors.red.shade700,
              size: 80,
            ),
            const SizedBox(height: 20),
            Text(
              'Sending Emergency Alert...',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade800),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Your emergency contacts have been notified.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop(); // Go back to the dashboard
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Dashboard'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.orange,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
