import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/responsive.dart';

class EduNavBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;
  final Function(String) onNavigate;

  const EduNavBar({
    super.key,
    required this.currentIndex,
    required this.onNavigate,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: Responsive.getPadding(context),
          child: Row(
            children: [
              // Logo
              GestureDetector(
                onTap: () => onNavigate('/'),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Edu',
                        style: TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      TextSpan(
                        text: 'Master',
                        style: TextStyle(
                          color: AppTheme.primary,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              if (!isMobile) ...[
                _NavItem(label: 'Home', isActive: currentIndex == 0, onTap: () => onNavigate('/')),
                _NavItem(label: 'Features', isActive: currentIndex == 1, onTap: () => onNavigate('/features')),
                _NavItem(label: 'How It Works', isActive: currentIndex == 2, onTap: () => onNavigate('/how-it-works')),
                _NavItem(label: 'FAQ', isActive: currentIndex == 3, onTap: () => onNavigate('/faq')),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => onNavigate('/signup'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Cairo'),
                  ),
                  child: const Text('Sign Up'),
                ),
              ] else ...[
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu_rounded, color: AppTheme.textPrimary),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? AppTheme.primary : AppTheme.textSecondary,
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            fontFamily: 'Cairo',
          ),
        ),
      ),
    );
  }
}

class EduDrawer extends StatelessWidget {
  final Function(String) onNavigate;

  const EduDrawer({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Edu',
                      style: TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    TextSpan(
                      text: 'Master',
                      style: TextStyle(
                        color: AppTheme.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            _DrawerItem(icon: Icons.home_rounded, label: 'Home', onTap: () { Navigator.pop(context); onNavigate('/'); }),
            _DrawerItem(icon: Icons.star_rounded, label: 'Features', onTap: () { Navigator.pop(context); onNavigate('/features'); }),
            _DrawerItem(icon: Icons.help_outline_rounded, label: 'How It Works', onTap: () { Navigator.pop(context); onNavigate('/how-it-works'); }),
            _DrawerItem(icon: Icons.quiz_rounded, label: 'FAQ', onTap: () { Navigator.pop(context); onNavigate('/faq'); }),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () { Navigator.pop(context); onNavigate('/signup'); },
                  child: const Text('Sign Up Free'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primary),
      title: Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Cairo')),
      onTap: onTap,
    );
  }
}