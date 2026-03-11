import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/responsive.dart';

class DashboardScreen extends StatelessWidget {
  final Function(String) onNavigate;

  const DashboardScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopRow(context),
          const SizedBox(height: 20),
          _buildNoTracksCard(context),
          const SizedBox(height: 20),
          _buildBottomRow(context),
          const SizedBox(height: 20),
          _buildFooter(context),
        ],
      ),
    );
  }

  // ─── Top Row: Stats Card + Empty Track ───────────────────────────────────────
  Widget _buildTopRow(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return isMobile
        ? Column(children: [
            _StatsCard(onNavigate: onNavigate),
            const SizedBox(height: 16),
            _NoTrackBanner(onNavigate: onNavigate),
          ])
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 300, child: _StatsCard(onNavigate: onNavigate)),
              const SizedBox(width: 20),
              Expanded(child: _NoTrackBanner(onNavigate: onNavigate)),
            ],
          );
  }

  // ─── No Tracks Banner ────────────────────────────────────────────────────────
  Widget _buildNoTracksCard(BuildContext context) {
    // Already included in top row
    return const SizedBox.shrink();
  }

  // ─── Bottom Row: Recent Activity + Quick Actions ─────────────────────────────
  Widget _buildBottomRow(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return isMobile
        ? Column(children: [
            _RecentActivityCard(onNavigate: onNavigate),
            const SizedBox(height: 16),
            _QuickActionsCard(onNavigate: onNavigate),
          ])
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: _RecentActivityCard(onNavigate: onNavigate),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 2,
                child: _QuickActionsCard(onNavigate: onNavigate),
              ),
            ],
          );
  }

  // ─── Footer ──────────────────────────────────────────────────────────────────
  Widget _buildFooter(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F0FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FooterBrand(),
                const SizedBox(height: 24),
                _FooterLinks(onNavigate: onNavigate),
                const SizedBox(height: 24),
                _FooterQuote(onNavigate: onNavigate),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    '© 2026 eduMaster. All rights reserved.',
                    style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 11,
                        fontFamily: 'Cairo'),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _FooterBrand()),
                    Expanded(child: _FooterLinks(onNavigate: onNavigate)),
                    Expanded(child: _FooterQuote(onNavigate: onNavigate)),
                  ],
                ),
                const SizedBox(height: 24),
                const Divider(color: AppTheme.borderColor),
                const SizedBox(height: 12),
                const Text(
                  '© 2026 eduMaster. All rights reserved.',
                  style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 11,
                      fontFamily: 'Cairo'),
                ),
              ],
            ),
    );
  }
}

// ─── Stats Card ───────────────────────────────────────────────────────────────
class _StatsCard extends StatelessWidget {
  final Function(String) onNavigate;
  const _StatsCard({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.bgLight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.borderColor),
                ),
                child: const Text('Your Stats',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                        fontFamily: 'Cairo')),
              ),
              GestureDetector(
                onTap: () => onNavigate('/explore-tracks'),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.bgLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  child: const Text('Start Learning',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                          fontFamily: 'Cairo')),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Avatar
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: AppTheme.primary.withOpacity(0.3), width: 3),
              color: AppTheme.bgLight,
            ),
            child: ClipOval(
              child: Icon(Icons.person_rounded,
                  size: 52, color: AppTheme.primary.withOpacity(0.4)),
            ),
          ),

          const SizedBox(height: 14),

          // Welcome text
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                    text: 'Welcome Back, ',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textPrimary,
                        fontFamily: 'Cairo')),
                TextSpan(
                    text: 'Ahmed',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textPrimary,
                        fontFamily: 'Cairo')),
                TextSpan(text: ' 👋', style: TextStyle(fontSize: 15)),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Stats row
          Row(
            children: [
              Expanded(
                  child: _StatBox(
                      label: 'Total Experience',
                      value: '0',
                      icon: Icons.star_rounded,
                      color: AppTheme.accentYellow)),
              const SizedBox(width: 8),
              Expanded(
                  child: _StatBox(
                      label: 'Current Streak 🔥',
                      value: '0 Day\nStreak',
                      icon: Icons.local_fire_department_rounded,
                      color: AppTheme.accent,
                      isHighlight: true)),
              const SizedBox(width: 8),
              Expanded(
                  child: _StatBox(
                      label: 'Overall Progress',
                      value: '0%',
                      icon: Icons.trending_up_rounded,
                      color: AppTheme.accentGreen)),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color;
  final bool isHighlight;

  const _StatBox({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isHighlight ? color.withOpacity(0.08) : AppTheme.bgLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: isHighlight ? color.withOpacity(0.3) : AppTheme.borderColor),
      ),
      child: Column(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 9,
                color: AppTheme.textSecondary,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isHighlight ? 13 : 16,
              fontWeight: FontWeight.w800,
              color: isHighlight ? color : AppTheme.textPrimary,
              fontFamily: 'Cairo',
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── No Track Banner ──────────────────────────────────────────────────────────
class _NoTrackBanner extends StatelessWidget {
  final Function(String) onNavigate;
  const _NoTrackBanner({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.bgLight,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: const Text(
              'userCoursesNoTrack',
              style: TextStyle(
                  fontSize: 13,
                  color: AppTheme.textSecondary,
                  fontFamily: 'Cairo'),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => onNavigate('/explore-tracks'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Cairo'),
            ),
            child: const Text('startLearning'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ─── Recent Activity Card ─────────────────────────────────────────────────────
class _RecentActivityCard extends StatelessWidget {
  final Function(String) onNavigate;
  const _RecentActivityCard({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Recent Activity',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                      fontFamily: 'Cairo')),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.bgLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  child: const Text('View All',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textSecondary,
                          fontFamily: 'Cairo')),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Empty state
          Center(
            child: Column(
              children: [
                Icon(Icons.history_rounded,
                    size: 48, color: AppTheme.textSecondary.withOpacity(0.3)),
                const SizedBox(height: 12),
                const Text(
                  'No recent activity yet.',
                  style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 14,
                      fontFamily: 'Cairo'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ─── Quick Actions Card ───────────────────────────────────────────────────────
class _QuickActionsCard extends StatelessWidget {
  final Function(String) onNavigate;
  const _QuickActionsCard({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickAction(
          icon: Icons.add_circle_outline_rounded,
          iconColor: const Color(0xFF22C55E),
          label: 'Upload Notes',
          route: '/my-tracks'),
      _QuickAction(
          icon: Icons.science_outlined,
          iconColor: AppTheme.primary,
          label: 'Generate Quiz',
          route: '/test-yourself'),
      _QuickAction(
          icon: Icons.menu_book_rounded,
          iconColor: const Color(0xFF8B5CF6),
          label: 'Resume Course',
          route: '/my-tracks'),
      _QuickAction(
          icon: Icons.bar_chart_rounded,
          iconColor: AppTheme.primary,
          label: 'View Statistics',
          route: '/dashboard'),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Quick Actions',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                  fontFamily: 'Cairo')),
          const SizedBox(height: 16),
          ...actions.map((action) =>
              _QuickActionTile(action: action, onNavigate: onNavigate)),
        ],
      ),
    );
  }
}

class _QuickAction {
  final IconData icon;
  final Color iconColor;
  final String label, route;
  const _QuickAction(
      {required this.icon,
      required this.iconColor,
      required this.label,
      required this.route});
}

class _QuickActionTile extends StatefulWidget {
  final _QuickAction action;
  final Function(String) onNavigate;
  const _QuickActionTile({required this.action, required this.onNavigate});

  @override
  State<_QuickActionTile> createState() => _QuickActionTileState();
}

class _QuickActionTileState extends State<_QuickActionTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: () => widget.onNavigate(widget.action.route),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: _hovered
                  ? widget.action.iconColor.withOpacity(0.05)
                  : AppTheme.bgLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _hovered
                    ? widget.action.iconColor.withOpacity(0.3)
                    : AppTheme.borderColor,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: widget.action.iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(widget.action.icon,
                      color: widget.action.iconColor, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  widget.action.label,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                      fontFamily: 'Cairo'),
                ),
                const Spacer(),
                Icon(Icons.chevron_right_rounded,
                    color: AppTheme.textSecondary.withOpacity(0.4), size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Footer Widgets ───────────────────────────────────────────────────────────
class _FooterBrand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                  text: 'EDU',
                  style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Cairo')),
              TextSpan(
                  text: 'MASTER',
                  style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Cairo')),
              TextSpan(text: ' 🎓', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text('Empowering learners for the future',
            style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
                fontFamily: 'Cairo')),
      ],
    );
  }
}

class _FooterLinks extends StatelessWidget {
  final Function(String) onNavigate;
  const _FooterLinks({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final links = [
      ('Home', Icons.home_outlined, '/'),
      ('Dashboard', Icons.dashboard_outlined, '/dashboard'),
      ('Explore Tracks', Icons.explore_outlined, '/explore-tracks'),
      ('Test Yourself', Icons.quiz_outlined, '/test-yourself'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Follow us on',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppTheme.primary,
                fontFamily: 'Cairo')),
        const SizedBox(height: 12),
        ...links.map((l) => GestureDetector(
              onTap: () => onNavigate(l.$3),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(children: [
                  Icon(l.$2, size: 16, color: AppTheme.textSecondary),
                  const SizedBox(width: 8),
                  Text(l.$1,
                      style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 13,
                          fontFamily: 'Cairo')),
                ]),
              ),
            )),
      ],
    );
  }
}

class _FooterQuote extends StatelessWidget {
  final Function(String) onNavigate;
  const _FooterQuote({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '"Education is the most powerful weapon which you can use to change the world."',
          style: TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
              fontFamily: 'Cairo',
              fontStyle: FontStyle.italic,
              height: 1.6),
        ),
        const SizedBox(height: 8),
        const Text('— Nelson Mandela',
            style: TextStyle(
                fontSize: 11,
                color: AppTheme.textSecondary,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => onNavigate('/explore-tracks'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Start Learning',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
          ),
        ),
      ],
    );
  }
}
