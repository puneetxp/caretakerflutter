import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthcares/guard/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePageScreen extends StatefulWidget {
  const MyHomePageScreen({super.key, required this.title});

  final String title;

  @override
  State<MyHomePageScreen> createState() => _MyHomePageScreenState();
}

class _MyHomePageScreenState extends State<MyHomePageScreen> {
  /// After a click, increment the counter state and
  /// asynchronously save it to persistent storage.

  @override
  Widget build(BuildContext context) {
    const double gap = 10;
    return const Scaffold(
      // appBar: AppBar(
      //   title: const Text('Care'),
      //   backgroundColor: Colors.purple,
      //   foregroundColor: Colors.white,
      //   actions: <Widget>[
      //     IconButton(
      //       icon: const Icon(Icons.person),
      //       tooltip: signedIn ? "Login" : "Dashboard",
      //       onPressed: () {
      //         signedIn
      //             ? GoRouter.of(context).go('/dashboard')
      //             : GoRouter.of(context).go('/login');
      //         // ScaffoldMessenger.of(context).showSnackBar(
      //         //     const SnackBar(content: Text('This is a snackbar')));
      //       },
      //     )
      //   ],
      // ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(child: _SampleCard(cardName: 'Elevated Card')),
          SizedBox(height: gap),
          Card(child: _SampleCard(cardName: 'Filled Card')),
          SizedBox(height: gap),
          Card(child: _SampleCard(cardName: 'Outlined Card')),
          SizedBox(height: gap),
        ],
      )),
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

class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.cardName});
  final String cardName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 100,
      child: Center(child: Text(cardName)),
    );
  }
}
