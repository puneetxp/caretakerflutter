// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BasicScaffold extends StatelessWidget {
  final AppBar appbar;
  final Widget child;
  final int selectedIndex;

  const BasicScaffold({
    required this.appbar,
    required this.child,
    required this.selectedIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);

    return Scaffold(
      appBar: appbar,
      body: AdaptiveNavigationScaffold(
        selectedIndex: selectedIndex,
        body: child,
        onDestinationSelected: (idx) {
          // if (idx == 0) goRouter.go('/books/popular');
          if (idx == 0) goRouter.go('/dashboard');
          if (idx == 1) goRouter.go('/settings');
        },
        destinations: const [
          // AdaptiveScaffoldDestination(
          //   title: 'Books',
          //   icon: Icons.book,
          // ),
          AdaptiveScaffoldDestination(
            title: 'Dashboard',
            icon: Icons.person,
          ),
          AdaptiveScaffoldDestination(
            title: 'Settings',
            icon: Icons.settings,
          ),
        ],
      ),
    );
  }
}

class GuestScaffold extends StatelessWidget {
  final AppBar appbar;
  final Widget child;

  const GuestScaffold({
    super.key,
    required this.appbar,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);

    return Scaffold(appBar: appbar, body: child);
  }
}
