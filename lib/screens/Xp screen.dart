import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/responsive.dart';
import '../widgets/footer.dart';

class XPScreen extends StatelessWidget {
  final Function(String) onNavigate;
  const XPScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _XPHero(),
          _XPCards(),
          _LeaderboardPreview(),
          EduFooter(onNavigate: onNavigate),
        ],
      ),
    );
  }
}

class _XPHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: isMobile ? 16 : 48),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
        ),
      ),
      child: Column(
        children: [
          const Text('🏆', style: TextStyle(fontSize: 56)),
          const SizedBox(height: 16),
          const Text('Earn XP as You Learn!', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w800, fontFamily: 'Cairo'), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text(
            'Our platform rewards your effort with points. Climb the ranks and build an unstoppable daily streak!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withOpacity(0.65), fontSize: 15, fontFamily: 'Cairo', height: 1.6),
          ),
          const SizedBox(height: 28),
          Wrap(spacing: 16, runSpacing: 12, alignment: WrapAlignment.center, children: [
            _StatBadge('🎯', 'XP Today', '0 / 200'),
            _StatBadge('🔥', 'Streak', '0 days'),
            _StatBadge('⭐', 'Total XP', '0 XP'),
          ]),
        ],
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String emoji, label, value;
  const _StatBadge(this.emoji, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Column(children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 11, fontFamily: 'Cairo')),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Cairo')),
      ]),
    );
  }
}

class _XPCards extends StatelessWidget {
  final List<Map<String, dynamic>> categories = const [
    {
      'icon': '🎯', 'title': 'Learning Basics', 'color': AppTheme.primary,
      'items': [('Pass a lesson', '+5 XP'), ('Watch a lesson', '+20 XP'), ('Complete Track', '+100 XP')],
    },
    {
      'icon': '🧠', 'title': 'Testing Knowledge', 'color': AppTheme.accentGreen,
      'items': [('Pass lesson Quiz', '+10 XP'), ('Pass final Track Quiz', '+60 XP')],
    },
    {
      'icon': '🔥', 'title': 'Daily Streaks', 'color': AppTheme.accent,
      'items': [('Daily Login', '+5 XP'), ('7 Days Streak', '+20 Bonus'), ('30 Days Streak', '+100 Bonus')],
    },
    {
      'icon': '📤', 'title': 'Upload & Generate', 'color': AppTheme.accentOrange,
      'items': [('Upload a file', '+10 XP'), ('Generate quiz', '+15 XP'), ('Complete generated quiz', '+30 XP')],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 52, horizontal: isMobile ? 16 : 48),
      child: Column(
        children: [
          const Text('How to Earn XP', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppTheme.textPrimary, fontFamily: 'Cairo')),
          const SizedBox(height: 32),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 4),
              crossAxisSpacing: 16, mainAxisSpacing: 16,
              childAspectRatio: isMobile ? 2.2 : 0.9,
            ),
            itemCount: categories.length,
            itemBuilder: (context, i) {
              final cat = categories[i];
              final color = cat['color'] as Color;
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.bgLight,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: color.withOpacity(0.2)),
                  boxShadow: [BoxShadow(color: color.withOpacity(0.07), blurRadius: 12, offset: const Offset(0, 4))],
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Text(cat['icon'] as String, style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 10),
                    Expanded(child: Text(cat['title'] as String, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Cairo'))),
                  ]),
                  const SizedBox(height: 16),
                  ...(cat['items'] as List<(String, String)>).map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Flexible(child: Text(item.$1, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontFamily: 'Cairo'))),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
                        child: Text(item.$2, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700, fontFamily: 'Cairo')),
                      ),
                    ]),
                  )),
                ]),
              );
            },
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
            ),
            child: const Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.info_outline_rounded, color: AppTheme.primary, size: 18),
              SizedBox(width: 10),
              Text('Daily Cap: You can earn a maximum of 200 XP per day. Stay consistent!', style: TextStyle(color: AppTheme.primary, fontSize: 13, fontFamily: 'Cairo')),
            ]),
          ),
        ],
      ),
    );
  }
}

class _LeaderboardPreview extends StatelessWidget {
  final List<Map<String, dynamic>> ranks = const [
    {'rank': 1, 'emoji': '🥇', 'name': 'Sara Ahmed', 'xp': 4820, 'streak': 30},
    {'rank': 2, 'emoji': '🥈', 'name': 'Omar Khaled', 'xp': 3960, 'streak': 21},
    {'rank': 3, 'emoji': '🥉', 'name': 'Nour Hassan', 'xp': 3510, 'streak': 18},
    {'rank': 4, 'emoji': '4️⃣', 'name': 'Ali Mohamed', 'xp': 2880, 'streak': 12},
    {'rank': 5, 'emoji': '5️⃣', 'name': 'Mona Adel', 'xp': 2200, 'streak': 7},
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      color: AppTheme.bgLight,
      padding: EdgeInsets.symmetric(vertical: 52, horizontal: isMobile ? 16 : 48),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(
            children: [
              const Text('🏆 Leaderboard', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppTheme.textPrimary, fontFamily: 'Cairo')),
              const SizedBox(height: 8),
              const Text('Top learners this month', style: TextStyle(color: AppTheme.textSecondary, fontSize: 14, fontFamily: 'Cairo')),
              const SizedBox(height: 28),
              ...ranks.map((r) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: r['rank'] == 1 ? const Color(0xFFFFF9E6) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: r['rank'] == 1 ? AppTheme.accentYellow.withOpacity(0.5) : AppTheme.borderColor,
                    width: r['rank'] == 1 ? 1.5 : 1,
                  ),
                ),
                child: Row(children: [
                  Text(r['emoji'] as String, style: const TextStyle(fontSize: 22)),
                  const SizedBox(width: 14),
                  Expanded(child: Text(r['name'] as String, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textPrimary, fontFamily: 'Cairo'))),
                  Row(children: [
                    const Icon(Icons.local_fire_department_rounded, color: AppTheme.accent, size: 16),
                    const SizedBox(width: 4),
                    Text('${r['streak']}d', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontFamily: 'Cairo')),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                      child: Text('${r['xp']} XP', style: const TextStyle(color: AppTheme.primary, fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Cairo')),
                    ),
                  ]),
                ]),
              )),
            ],
          ),
        ),
      ),
    );
  }
}