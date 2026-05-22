import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/data/auth_provider.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/otp_screen.dart';
import '../../features/society/presentation/society_home_screen.dart';
import '../../features/members/presentation/member_list_screen.dart';
import '../../features/members/presentation/member_detail_screen.dart';
import '../../features/members/presentation/add_member_screen.dart';
import '../../features/payments/presentation/payment_screen.dart';
import '../../features/payments/presentation/payment_history_screen.dart';
import '../../features/noticeboard/presentation/notice_list_screen.dart';
import 'route_names.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: RouteNames.home,
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull != null;
      final isAuthRoute = state.matchedLocation.startsWith('/auth');
      if (!isLoggedIn && !isAuthRoute) return RouteNames.login;
      if (isLoggedIn && isAuthRoute) return RouteNames.home;
      return null;
    },
    routes: [
      GoRoute(
        path: RouteNames.login,
        name: RouteNames.login,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.otp,
        name: RouteNames.otp,
        builder: (_, state) => OtpScreen(phone: state.extra as String),
      ),
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: RouteNames.home,
            name: RouteNames.home,
            builder: (_, __) => const SocietyHomeScreen(),
          ),
          GoRoute(
            path: RouteNames.members,
            name: RouteNames.members,
            builder: (_, __) => const MemberListScreen(),
            routes: [
              GoRoute(
                path: 'detail/:id',
                name: RouteNames.memberDetail,
                builder: (_, state) => MemberDetailScreen(
                  memberId: state.pathParameters['id']!,
                ),
              ),
              GoRoute(
                path: 'add',
                name: RouteNames.addMember,
                builder: (_, __) => const AddMemberScreen(),
              ),
            ],
          ),
          GoRoute(
            path: RouteNames.payments,
            name: RouteNames.payments,
            builder: (_, __) => const PaymentScreen(),
            routes: [
              GoRoute(
                path: 'history',
                name: RouteNames.paymentHistory,
                builder: (_, __) => const PaymentHistoryScreen(),
              ),
            ],
          ),
          GoRoute(
            path: RouteNames.noticeboard,
            name: RouteNames.noticeboard,
            builder: (_, __) => const NoticeListScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.error}')),
    ),
  );
});

// Bottom navigation shell
class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = _indexFromLocation(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (i) => _navigateTo(context, i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.people_outlined), selectedIcon: Icon(Icons.people), label: 'Members'),
          NavigationDestination(icon: Icon(Icons.payment_outlined), selectedIcon: Icon(Icons.payment), label: 'Payments'),
          NavigationDestination(icon: Icon(Icons.announcement_outlined), selectedIcon: Icon(Icons.announcement), label: 'Notices'),
        ],
      ),
    );
  }

  int _indexFromLocation(String location) {
    if (location.startsWith('/members')) return 1;
    if (location.startsWith('/payments')) return 2;
    if (location.startsWith('/noticeboard')) return 3;
    return 0;
  }

  void _navigateTo(BuildContext context, int index) {
    switch (index) {
      case 0: context.go(RouteNames.home); break;
      case 1: context.go(RouteNames.members); break;
      case 2: context.go(RouteNames.payments); break;
      case 3: context.go(RouteNames.noticeboard); break;
    }
  }
}
