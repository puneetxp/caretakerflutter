import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPageScreen extends StatefulWidget {
  const DashboardPageScreen({super.key, required this.title});

  final String title;

  @override
  State<DashboardPageScreen> createState() => _DashboardPageScreenState();
}

class _DashboardPageScreenState extends State<DashboardPageScreen> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  /// Load the initial counter value from persistent storage on start,
  /// or fallback to 0 if it doesn't exist.
  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  /// After a click, increment the counter state and
  /// asynchronously save it to persistent storage.
  Future<void> _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0) + 1;
      prefs.setInt('counter', _counter);
    });
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('AppBar Demo'),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: const Icon(Icons.add_alert),
      //       tooltip: 'Show Snackbar',
      //       onPressed: () {
      //         GoRouter.of(context).go('/login');
      //         // ScaffoldMessenger.of(context).showSnackBar(
      //         //     const SnackBar(content: Text('This is a snackbar')));
      //       },
      //     ),
      //     IconButton(
      //       icon: const Icon(Icons.navigate_next),
      //       tooltip: 'Go to the next page',
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      body: const Center(
        child: Text(
          'This is the Dashoboard',
          style: TextStyle(fontSize: 24),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Dashboard',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.date_range),
      //       label: 'Schedules',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Setting',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   // selectedItemColor: const Color.fromARGB(255, 63, 151, 235),
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
