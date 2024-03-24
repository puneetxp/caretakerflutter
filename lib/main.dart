import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'guard/auth.dart';
import 'view/screens/layout/scaffhold.dart';
import 'view/screens/public/home.dart';
import 'view/screens/public/login.dart';
import 'view/screens/auth/setting.dart';
import 'view/widgets/fade_transition_page.dart';

const double windowWidth = 480;
const double windowHeight = 854;

// void setupWindow() {
//   if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
//     WidgetsFlutterBinding.ensureInitialized();
//     setWindowTitle('Navigation and routing');
//     setWindowMinSize(const Size(windowWidth, windowHeight));
//     setWindowMaxSize(const Size(windowWidth, windowHeight));
//     getCurrentScreen().then((screen) {
//       setWindowFrame(Rect.fromCenter(
//         center: screen!.frame.center,
//         width: windowWidth,
//         height: windowHeight,
//       ));
//     });
//   }
// }

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // setupWindow();
    return MaterialApp.router(
        builder: (context, child) {
          if (child == null) {
            throw ('No child in .router constructor builder');
          }
          return AuthGuardScope(
            notifier: AuthGuard(),
            child: child,
          );
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        title: 'Shared preferences demo',
        // theme: ThemeData(
        //     colorScheme: ColorScheme.fromSeed(
        //   // brightness: MediaQuery.platformBrightnessOf(context),
        //   seedColor: Colors.pinkAccent,
        // )),
        routerConfig: GoRouter(
          refreshListenable: AuthGuard(),
          debugLogDiagnostics: true,
          initialLocation: '/dashborad',
          redirect: (context, state) {
            final signedIn = AuthGuard.of(context).signedIn;
            if (state.uri.toString() != '/login' && !signedIn) {
              return '/login';
            }
            return null;
          },
          routes: <RouteBase>[
            GoRoute(
              path: '/',
              redirect: (context, state) {
                final signedIn = AuthGuard.of(context).signedIn;
                if (state.uri.toString() != '/login' && !signedIn) {
                  return '/login';
                }
                return null;
              },
              routes: <RouteBase>[
                ShellRoute(
                  builder: (context, state, child) {
                    return BasicScaffold(
                      selectedIndex: switch (state.uri.path) {
                        // var p when p.startsWith('/books') => 0,
                        var p when p.startsWith('/dashboard') => 0,
                        var p when p.startsWith('/settings') => 1,
                        _ => 0,
                      },
                      child: child,
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'dashboard',
                      pageBuilder: (context, state) {
                        return FadeTransitionPage<dynamic>(
                          key: state.pageKey,
                          child: const MyHomePageScreen(
                            title: 'Dashboard',
                          ),
                        );
                      },
                    ),
                    GoRoute(
                      path: 'settings',
                      pageBuilder: (context, state) {
                        return FadeTransitionPage<dynamic>(
                          key: state.pageKey,
                          child: const SettingsScreen(),
                        );
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: 'login',
                  builder: (context, state) {
                    // Use a builder to get the correct BuildContext
                    return Builder(
                      builder: (context) {
                        return SignInScreen(
                          onSignIn:
                              (Credentials value, BuildContext context) async {
                            final router = GoRouter.of(context);
                            await AuthGuard.of(context)
                                .signIn(value.username, value.password);
                            router.go('/dashboard');
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
