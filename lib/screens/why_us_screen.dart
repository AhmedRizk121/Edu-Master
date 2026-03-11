import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/responsive.dart';
import '../widgets/footer.dart';

class WhyUsScreen extends StatelessWidget {
  final Function(String) onNavigate;
  const WhyUsScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _WhyHero(),
          _ReasonsGrid(),
          _ComparisonSection(),
          _CTASection(onNavigate: onNavigate),
          EduFooter(onNavigate: onNavigate),
        ],
      ),
    );
  }
}

class _WhyHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: isMobile ? 16 : 48),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF0EEFF), Color(0xFFFFF5F5), Color(0xFFF8F9FF)],
        ),
      ),
      child: Column(
        children: [
          const Text('WHY YOU\'LL LOVE IT', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: AppTheme.textPrimary, fontFamily: 'Cairo'), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text(
            'Designed to make learning exciting, effective, and personal.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.textSecondary, fontSize: isMobile ? 15 : 17, fontFamily: 'Cairo', height: 1.6),
          ),
        ],
      ),
    );
  }
}

class _ReasonsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> reasons = const [
    {'emoji': '🚀', 'title': 'Learn faster', 'desc': 'Accelerate your learning with interactive, AI-personalized experiences designed for your specific pace and style.', 'color': AppTheme.primary},
    {'emoji': '🧠', 'title': 'Remember more', 'desc': 'Turn knowledge into lasting memories with spaced repetition and engaging, brain-friendly patterns.', 'color': AppTheme.accent},
    {'emoji': '🎯', 'title': 'Practice smarter', 'desc': 'Spend less time guessing what to study. AI identifies your weak spots and targets them precisely.', 'color': AppTheme.accentGreen},
    {'emoji': '😊', 'title': 'No boring exams', 'desc': 'Goodbye to stress. Hello to fun and inspiring challenges that excite you to keep going every single day.', 'color': AppTheme.accentOrange},
    {'emoji': '✨', 'title': 'Personalized quizzes', 'desc': 'Experience quizzes crafted just for you from your own files — because your learning journey is unique.', 'color': Color(0xFF8B5CF6)},
    {'emoji': '📊', 'title': 'Track your progress', 'desc': 'Real-time dashboards show exactly how far you\'ve come and where to focus next.', 'color': Color(0xFF06B6D4)},
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 52, horizontal: isMobile ? 16 : 48),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
          crossAxisSpacing: 16, mainAxisSpacing: 16,
          childAspectRatio: isMobile ? 4.0 : 1.5,
        ),
        itemCount: reasons.length,
        itemBuilder: (context, i) {
          final r = reasons[i];
          final color = r['color'] as Color;
          return Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: AppTheme.bgLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(0.2)),
              boxShadow: [BoxShadow(color: color.withOpacity(0.07), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: isMobile
                ? Row(children: [
                    Text(r['emoji'] as String, style: const TextStyle(fontSize: 34)),
                    const SizedBox(width: 16),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(r['title'] as String, style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Cairo')),
                      const SizedBox(height: 4),
                      Text(r['desc'] as String, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontFamily: 'Cairo', height: 1.5), maxLines: 2, overflow: TextOverflow.ellipsis),
                    ])),
                  ])
                : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(r['emoji'] as String, style: const TextStyle(fontSize: 36)),
                    const SizedBox(height: 14),
                    Text(r['title'] as String, style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Cairo')),
                    const SizedBox(height: 8),
                    Text(r['desc'] as String, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontFamily: 'Cairo', height: 1.6)),
                  ]),
          );
        },
      ),
    );
  }
}

class _ComparisonSection extends StatelessWidget {
  final List<Map<String, dynamic>> rows = const [
    {'feature': 'AI Quiz Generation', 'us': true, 'others': false},
    {'feature': 'Upload Your Own Files', 'us': true, 'others': false},
    {'feature': 'XP & Gamification', 'us': true, 'others': false},
    {'feature': 'Personalized Tracks', 'us': true, 'others': true},
    {'feature': 'Progress Dashboard', 'us': true, 'others': true},
    {'feature': 'Free to Start', 'us': true, 'others': false},
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
              const Text('EduMaster vs Others', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppTheme.textPrimary, fontFamily: 'Cairo'), textAlign: TextAlign.center),
              const SizedBox(height: 28),
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.borderColor)),
                child: Column(
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      decoration: const BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                      child: const Row(children: [
                        Expanded(child: Text('Feature', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontFamily: 'Cairo'))),
                        SizedBox(width: 80, child: Text('EduMaster', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontFamily: 'Cairo'))),
                        SizedBox(width: 80, child: Text('Others', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, fontFamily: 'Cairo'))),
                      ]),
                    ),
                    ...rows.asMap().entries.map((e) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                        color: e.key.isEven ? Colors.white : AppTheme.bgLight,
                        border: e.key < rows.length - 1 ? const Border(bottom: BorderSide(color: AppTheme.borderColor)) : null,
                      ),
                      child: Row(children: [
                        Expanded(child: Text(e.value['feature'] as String, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14, fontFamily: 'Cairo'))),
                        SizedBox(width: 80, child: Center(child: Icon(Icons.check_circle_rounded, color: AppTheme.accentGreen, size: 22))),
                        SizedBox(width: 80, child: Center(child: Icon(
                          (e.value['others'] as bool) ? Icons.check_circle_rounded : Icons.cancel_rounded,
                          color: (e.value['others'] as bool) ? AppTheme.accentGreen : AppTheme.accent,
                          size: 22,
                        ))),
                      ]),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CTASection extends StatelessWidget {
  final Function(String) onNavigate;
  const _CTASection({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 52, horizontal: isMobile ? 16 : 48),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              const Text('Ready to start your journey?', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppTheme.textPrimary, fontFamily: 'Cairo'), textAlign: TextAlign.center),
              const SizedBox(height: 12),
              const Text('Join thousands of learners already mastering topics with EduMaster.', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.textSecondary, fontSize: 15, fontFamily: 'Cairo', height: 1.6)),
              const SizedBox(height: 28),
              Wrap(spacing: 12, runSpacing: 12, alignment: WrapAlignment.center, children: [
                ElevatedButton.icon(
                  onPressed: () => onNavigate('/signup'),
                  icon: const Icon(Icons.rocket_launch_rounded, size: 18),
                  label: const Text('Get Started Free'),
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14)),
                ),
                OutlinedButton.icon(
                  onPressed: () => onNavigate('/how-it-works'),
                  icon: const Icon(Icons.play_circle_outline_rounded, size: 18),
                  label: const Text('See How It Works'),
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14)),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}