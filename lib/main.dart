import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/explore_tracks_screen.dart';
import 'screens/test_yourself_screen.dart';
import 'widgets/sidebar.dart';

void main() {
  runApp(const EduMasterApp());
}

class EduMasterApp extends StatelessWidget {
  const EduMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduMaster',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  String _currentRoute = '/';
  bool _sidebarCollapsed = false;

  void _navigate(String route) => setState(() => _currentRoute = route);

  Widget _buildPage() {
    switch (_currentRoute) {
      case '/':                return HomeScreen(onNavigate: _navigate);
      case '/dashboard':       return DashboardScreen(onNavigate: _navigate);
      case '/explore-tracks':  return ExploreTracksScreen(onNavigate: _navigate);
      case '/my-tracks':       return _EmptyPage(title: 'My Tracks',      icon: Icons.bookmark_rounded,   onNavigate: _navigate);
      case '/test-yourself':   return TestYourselfScreen(onNavigate: _navigate);
      case '/my-quizzes':      return _EmptyPage(title: 'My Quizzes',     icon: Icons.assignment_rounded, onNavigate: _navigate);
      case '/signup':          return SignUpScreen(onNavigate: _navigate);
      default:                 return HomeScreen(onNavigate: _navigate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    if (isMobile) {
      return Scaffold(
        backgroundColor: AppTheme.bgLight,
        drawer: EduMobileDrawer(currentRoute: _currentRoute, onNavigate: _navigate),
        appBar: _MobileTopBar(currentRoute: _currentRoute),
        body: _AnimatedPage(route: _currentRoute, child: _buildPage()),
      );
    }

    // Tablet & Desktop: persistent sidebar
    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      body: Row(
        children: [
          ClipRect(
            child: EduSidebar(
              currentRoute: _currentRoute,
              onNavigate: _navigate,
              isCollapsed: _sidebarCollapsed,
              onToggle: () => setState(() => _sidebarCollapsed = !_sidebarCollapsed),
            ),
          ),
          Expanded(
            child: _AnimatedPage(route: _currentRoute, child: _buildPage()),
          ),
        ],
      ),
    );
  }
}

class _AnimatedPage extends StatelessWidget {
  final String route;
  final Widget child;
  const _AnimatedPage({required this.route, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 260),
      transitionBuilder: (child, anim) => FadeTransition(
        opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0.02, 0), end: Offset.zero)
              .animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
          child: child,
        ),
      ),
      child: KeyedSubtree(key: ValueKey(route), child: child),
    );
  }
}

class _MobileTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String currentRoute;
  const _MobileTopBar({required this.currentRoute});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  String get _title {
    const titles = {
      '/': 'Home',
      '/dashboard': 'Dashboard',
      '/explore-tracks': 'Explore Tracks',
      '/my-tracks': 'My Tracks',
      '/test-yourself': 'Test Yourself',
      '/my-quizzes': 'My Quizzes',
      '/signup': 'Sign Up',
    };
    return titles[currentRoute] ?? 'EduMaster';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color(0x0F000000), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Builder(
              builder: (ctx) => IconButton(
                icon: const Icon(Icons.menu_rounded, color: AppTheme.textPrimary),
                onPressed: () => Scaffold.of(ctx).openDrawer(),
              ),
            ),
            RichText(
              text: const TextSpan(children: [
                TextSpan(text: 'Edu', style: TextStyle(color: AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.w800, fontFamily: 'Cairo')),
                TextSpan(text: 'Master', style: TextStyle(color: AppTheme.primary, fontSize: 18, fontWeight: FontWeight.w800, fontFamily: 'Cairo')),
              ]),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(_title, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13, fontFamily: 'Cairo')),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Sign Up Screen ───────────────────────────────────────────────────────────
// ─── Empty placeholder page ───────────────────────────────────────────────────
class _EmptyPage extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function(String) onNavigate;

  const _EmptyPage({required this.title, required this.icon, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100, height: 100,
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 48, color: AppTheme.primary.withOpacity(0.4)),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.w800,
              color: AppTheme.textPrimary, fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'هذه الصفحة قيد الإنشاء...\nسيتم إضافة المحتوى قريباً 🚀',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14, color: AppTheme.textSecondary,
              fontFamily: 'Cairo', height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Sign Up Screen ───────────────────────────────────────────────────────────
class SignUpScreen extends StatelessWidget {
  final Function(String) onNavigate;
  const SignUpScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.borderColor),
                boxShadow: [BoxShadow(color: AppTheme.primary.withOpacity(0.08), blurRadius: 24, offset: const Offset(0, 8))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Text('🚀', style: TextStyle(fontSize: 48))),
                  const SizedBox(height: 16),
                  const Center(child: Text('Create Your Account', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppTheme.textPrimary, fontFamily: 'Cairo'))),
                  const Center(child: Text('Start your learning journey today', style: TextStyle(color: AppTheme.textSecondary, fontSize: 14, fontFamily: 'Cairo'))),
                  const SizedBox(height: 32),
                  _Field(label: 'Full Name', hint: 'Ahmed Mohamed', icon: Icons.person_rounded),
                  const SizedBox(height: 16),
                  _Field(label: 'Email Address', hint: 'ahmed@example.com', icon: Icons.email_rounded),
                  const SizedBox(height: 16),
                  _Field(label: 'Password', hint: '••••••••', icon: Icons.lock_rounded, isPassword: true),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, padding: const EdgeInsets.symmetric(vertical: 14)),
                      child: const Text('Sign Up Free', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () => onNavigate('/'),
                      child: const Text('Already have an account? Sign In', style: TextStyle(color: AppTheme.primary, fontFamily: 'Cairo')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label, hint;
  final IconData icon;
  final bool isPassword;
  const _Field({required this.label, required this.hint, required this.icon, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textPrimary, fontFamily: 'Cairo')),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppTheme.textSecondary, fontFamily: 'Cairo'),
            prefixIcon: Icon(icon, color: AppTheme.primary, size: 20),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.borderColor)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.borderColor)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.primary, width: 2)),
            filled: true, fillColor: AppTheme.bgLight,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}