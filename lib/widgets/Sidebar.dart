import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NavItem {
  final String route;
  final IconData icon;
  final IconData iconActive;
  final String label;
  final String? badge;

  const NavItem({
    required this.route,
    required this.icon,
    required this.iconActive,
    required this.label,
    this.badge,
  });
}

const List<NavItem> kNavItems = [
  NavItem(
      route: '/',
      icon: Icons.home_outlined,
      iconActive: Icons.home_rounded,
      label: 'Home'),
  NavItem(
      route: '/dashboard',
      icon: Icons.dashboard_outlined,
      iconActive: Icons.dashboard_rounded,
      label: 'Dashboard'),
  NavItem(
      route: '/explore-tracks',
      icon: Icons.explore_outlined,
      iconActive: Icons.explore_rounded,
      label: 'Explore Tracks'),
  NavItem(
      route: '/my-tracks',
      icon: Icons.bookmark_outline_rounded,
      iconActive: Icons.bookmark_rounded,
      label: 'My Tracks'),
  NavItem(
      route: '/test-yourself',
      icon: Icons.quiz_outlined,
      iconActive: Icons.quiz_rounded,
      label: 'Test Yourself'),
  NavItem(
      route: '/my-quizzes',
      icon: Icons.assignment_outlined,
      iconActive: Icons.assignment_rounded,
      label: 'My Quizzes'),
];

/// Full persistent sidebar for tablet/desktop
class EduSidebar extends StatelessWidget {
  final String currentRoute;
  final Function(String) onNavigate;
  final bool isCollapsed;
  final VoidCallback onToggle;

  const EduSidebar({
    super.key,
    required this.currentRoute,
    required this.onNavigate,
    required this.isCollapsed,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final width = isCollapsed ? 72.0 : 240.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      width: width,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(4, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Logo + toggle
          Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: isCollapsed ? 8 : 16),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
            ),
            child: Row(
              mainAxisAlignment: isCollapsed
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                if (!isCollapsed)
                  Flexible(
                    child: GestureDetector(
                      onTap: () => onNavigate('/'),
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Edu',
                              style: TextStyle(
                                  color: AppTheme.textPrimary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Cairo'),
                            ),
                            TextSpan(
                              text: 'Master',
                              style: TextStyle(
                                  color: AppTheme.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Cairo'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                IconButton(
                  onPressed: onToggle,
                  icon: AnimatedRotation(
                    turns: isCollapsed ? 0 : 0.5,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      isCollapsed
                          ? Icons.menu_rounded
                          : Icons.menu_open_rounded,
                      color: AppTheme.textSecondary,
                      size: 22,
                    ),
                  ),
                  tooltip: isCollapsed ? 'Expand sidebar' : 'Collapse sidebar',
                  style: IconButton.styleFrom(
                    backgroundColor: AppTheme.bgLight,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ),

          // Nav items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: ListView(
                children: [
                  if (!isCollapsed)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      child: Text(
                        'NAVIGATION',
                        style: TextStyle(
                          color: AppTheme.textSecondary.withOpacity(0.6),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                  ...kNavItems.map((item) => _SidebarNavItem(
                        item: item,
                        isActive: currentRoute == item.route,
                        isCollapsed: isCollapsed,
                        onTap: () => onNavigate(item.route),
                      )),
                ],
              ),
            ),
          ),

          // Bottom: Logout button
          Container(
            padding: EdgeInsets.all(isCollapsed ? 10 : 16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
            ),
            child: isCollapsed
                ? IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.logout_rounded, color: Colors.red),
                    tooltip: 'Logout',
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.red.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.logout_rounded, size: 16),
                      label: const Text('Logout'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Cairo'),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _SidebarNavItem extends StatefulWidget {
  final NavItem item;
  final bool isActive;
  final bool isCollapsed;
  final VoidCallback onTap;

  const _SidebarNavItem({
    required this.item,
    required this.isActive,
    required this.isCollapsed,
    required this.onTap,
  });

  @override
  State<_SidebarNavItem> createState() => _SidebarNavItemState();
}

class _SidebarNavItemState extends State<_SidebarNavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isHighlighted = widget.isActive || _hovered;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Tooltip(
        message: widget.isCollapsed ? widget.item.label : '',
        preferBelow: false,
        verticalOffset: 0,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: EdgeInsets.symmetric(
                horizontal: widget.isCollapsed ? 12 : 12,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: widget.isActive
                    ? AppTheme.primary.withOpacity(0.1)
                    : _hovered
                        ? AppTheme.bgLight
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: widget.isActive
                    ? Border.all(color: AppTheme.primary.withOpacity(0.2))
                    : null,
              ),
              child: Row(
                mainAxisAlignment: widget.isCollapsed
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  // Active indicator bar (only when expanded)
                  if (!widget.isCollapsed)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 3,
                      height: 20,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: widget.isActive
                            ? AppTheme.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  Icon(
                    widget.isActive ? widget.item.iconActive : widget.item.icon,
                    color: widget.isActive
                        ? AppTheme.primary
                        : (isHighlighted
                            ? AppTheme.textPrimary
                            : AppTheme.textSecondary),
                    size: 20,
                  ),
                  if (!widget.isCollapsed) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.item.label,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: widget.isActive
                              ? AppTheme.primary
                              : (isHighlighted
                                  ? AppTheme.textPrimary
                                  : AppTheme.textSecondary),
                          fontSize: 14,
                          fontWeight: widget.isActive
                              ? FontWeight.w700
                              : FontWeight.w500,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                    if (widget.item.badge != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.accentOrange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.item.badge!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Mobile bottom sheet drawer
class EduMobileDrawer extends StatelessWidget {
  final String currentRoute;
  final Function(String) onNavigate;

  const EduMobileDrawer({
    super.key,
    required this.currentRoute,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: 280,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF0EEFF), Color(0xFFFFF5F5)],
                ),
                border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                            text: 'Edu',
                            style: TextStyle(
                                color: AppTheme.textPrimary,
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Cairo')),
                        TextSpan(
                            text: 'Master',
                            style: TextStyle(
                                color: AppTheme.primary,
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Cairo')),
                        TextSpan(text: ' 🚀', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Empowering learners for the future',
                    style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                        fontFamily: 'Cairo'),
                  ),
                ],
              ),
            ),

            // Nav items
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                      child: Text(
                        'PAGES',
                        style: TextStyle(
                          color: Color(0xFFB0B8C8),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                    ...kNavItems.map((item) => _MobileNavItem(
                          item: item,
                          isActive: currentRoute == item.route,
                          onTap: () {
                            Navigator.pop(context);
                            onNavigate(item.route);
                          },
                        )),
                  ],
                ),
              ),
            ),

            // Logout
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.logout_rounded, size: 16),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Cairo'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _MobileNavItem(
      {required this.item, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor:
            isActive ? AppTheme.primary.withOpacity(0.08) : Colors.transparent,
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isActive
                ? AppTheme.primary.withOpacity(0.15)
                : AppTheme.bgLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            isActive ? item.iconActive : item.icon,
            color: isActive ? AppTheme.primary : AppTheme.textSecondary,
            size: 20,
          ),
        ),
        title: Text(
          item.label,
          style: TextStyle(
            color: isActive ? AppTheme.primary : AppTheme.textPrimary,
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            fontFamily: 'Cairo',
          ),
        ),
        trailing: item.badge != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: AppTheme.accentOrange,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(item.badge!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Cairo')),
              )
            : (isActive
                ? const Icon(Icons.chevron_right_rounded,
                    color: AppTheme.primary, size: 18)
                : null),
      ),
    );
  }
}
