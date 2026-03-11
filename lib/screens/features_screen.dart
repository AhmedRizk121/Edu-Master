import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/responsive.dart';
import '../widgets/footer.dart';

class FeaturesScreen extends StatelessWidget {
  final Function(String) onNavigate;
  final bool standalone;
  const FeaturesScreen({super.key, required this.onNavigate, this.standalone = false});

  @override
  Widget build(BuildContext context) {
    final body = SingleChildScrollView(
      child: Column(children: [
        _FeaturesHero(),
        _FeaturesGrid(),
        _XPSection(),
        EduFooter(onNavigate: onNavigate),
      ]),
    );
    if (standalone) return Scaffold(backgroundColor: AppTheme.bgLight, body: body);
    return body;
  }
}

class _FeaturesHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: isMobile ? 16 : 48),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [Color(0xFFF0EEFF), Color(0xFFFFF5F5), Color(0xFFF8F9FF)],
        ),
      ),
      child: Column(children: [
        RichText(textAlign: TextAlign.center, text: const TextSpan(children: [
          TextSpan(text: 'OUR ', style: TextStyle(color: AppTheme.textPrimary, fontSize: 32, fontWeight: FontWeight.w800, fontFamily: 'Cairo')),
          TextSpan(text: 'FEATURES', style: TextStyle(color: AppTheme.primary, fontSize: 32, fontWeight: FontWeight.w800, fontFamily: 'Cairo', decoration: TextDecoration.underline, decorationColor: AppTheme.primary)),
        ])),
        const SizedBox(height: 12),
        const Text('Everything you need to learn smarter, faster, and more effectively.',
          textAlign: TextAlign.center, style: TextStyle(color: AppTheme.textSecondary, fontSize: 15, fontFamily: 'Cairo', height: 1.6)),
      ]),
    );
  }
}

class _FeaturesGrid extends StatelessWidget {
  final List<Map<String, dynamic>> features = const [
    {'number': '01', 'title': 'Structured Learning Tracks', 'icon': Icons.route_rounded, 'color': AppTheme.primary, 'items': ['Beginner', 'Intermediate', 'Advanced']},
    {'number': '02', 'title': 'Upload Any File', 'icon': Icons.upload_file_rounded, 'color': AppTheme.accent, 'items': ['Upload PDF, DOCX, TXT', 'AI generates MCQs', 'True/False, Short answers']},
    {'number': '03', 'title': 'Smart Feedback', 'icon': Icons.psychology_rounded, 'color': AppTheme.accentGreen, 'items': ['See correct answers', 'Track weak topics']},
    {'number': '04', 'title': 'Progress Dashboard', 'icon': Icons.dashboard_rounded, 'color': AppTheme.accentOrange, 'items': ['Courses completed', 'Quiz scores', 'Learning streak']},
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
          crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 4),
          crossAxisSpacing: 16, mainAxisSpacing: 16,
          childAspectRatio: isMobile ? 2.5 : 0.85,
        ),
        itemCount: features.length,
        itemBuilder: (context, i) => _FeatureCard(feature: features[i]),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final Map<String, dynamic> feature;
  const _FeatureCard({required this.feature});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final color = feature['color'] as Color;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.bgLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
        boxShadow: [BoxShadow(color: color.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, 4))],
      ),
      child: isMobile
          ? Row(children: [
              _CardIcon(color: color, icon: feature['icon'] as IconData, number: feature['number'] as String),
              const SizedBox(width: 16),
              Expanded(child: _CardContent(feature: feature, color: color)),
            ])
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _CardIcon(color: color, icon: feature['icon'] as IconData, number: feature['number'] as String),
              const SizedBox(height: 16),
              _CardContent(feature: feature, color: color),
            ]),
    );
  }
}

class _CardIcon extends StatelessWidget {
  final Color color; final IconData icon; final String number;
  const _CardIcon({required this.color, required this.icon, required this.number});
  @override
  Widget build(BuildContext context) => Stack(children: [
    Container(width: 52, height: 52, decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: color, size: 26)),
    Positioned(top: 0, right: 0, child: Container(width: 20, height: 20, decoration: BoxDecoration(color: color, shape: BoxShape.circle), child: Center(child: Text(number, style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w700, fontFamily: 'Cairo'))))),
  ]);
}

class _CardContent extends StatelessWidget {
  final Map<String, dynamic> feature; final Color color;
  const _CardContent({required this.feature, required this.color});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(feature['title'] as String, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Cairo')),
    const SizedBox(height: 8),
    ...(feature['items'] as List<String>).map((item) => Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(children: [
        Icon(Icons.check_circle_rounded, color: color, size: 14),
        const SizedBox(width: 6),
        Flexible(child: Text(item, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontFamily: 'Cairo'))),
      ]),
    )),
  ]);
}

class _XPSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      color: AppTheme.bgLight,
      padding: EdgeInsets.symmetric(vertical: 52, horizontal: isMobile ? 16 : 48),
      child: Column(children: [
        const Text('Earn XP as You Learn! 🚀', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppTheme.textPrimary, fontFamily: 'Cairo'), textAlign: TextAlign.center),
        const SizedBox(height: 8),
        const Text('Our platform rewards your effort with points. Climb the ranks and build an unstoppable daily streak!', style: TextStyle(color: AppTheme.textSecondary, fontSize: 14, fontFamily: 'Cairo', height: 1.6), textAlign: TextAlign.center),
        const SizedBox(height: 32),
        Wrap(spacing: 16, runSpacing: 16, alignment: WrapAlignment.center, children: [
          _XPCard(icon: '🎯', title: 'Learning Basics', items: [('Pass a lesson', '+5 XP'), ('Watch a lesson', '+20 XP'), ('Complete Track', '+100 XP')], color: AppTheme.primary),
          _XPCard(icon: '🧠', title: 'Testing Knowledge', items: [('Pass lesson Quiz', '+10 XP'), ('Pass final Track Quiz', '+60 XP')], color: AppTheme.accentGreen),
          _XPCard(icon: '🔥', title: 'Daily Streaks', items: [('Daily Login', '+5 XP'), ('7 Days Streak', '+20 Bonus'), ('30 Days Streak', '+100 Bonus')], color: AppTheme.accent),
        ]),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(8), border: Border.all(color: AppTheme.primary.withOpacity(0.2))),
          child: const Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.info_outline_rounded, color: AppTheme.primary, size: 16),
            SizedBox(width: 8),
            Text('Daily Cap: You can earn a maximum of 200 XP per day. Stay consistent!', style: TextStyle(color: AppTheme.primary, fontSize: 12, fontFamily: 'Cairo')),
          ]),
        ),
      ]),
    );
  }
}

class _XPCard extends StatelessWidget {
  final String icon, title;
  final List<(String, String)> items;
  final Color color;
  const _XPCard({required this.icon, required this.title, required this.items, required this.color});

  @override
  Widget build(BuildContext context) => Container(
    width: 220, padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.2)), boxShadow: [BoxShadow(color: color.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4))]),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Text(icon, style: const TextStyle(fontSize: 24)), const SizedBox(width: 10), Expanded(child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.textPrimary, fontFamily: 'Cairo')))]),
      const SizedBox(height: 16),
      ...items.map((item) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(item.$1, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontFamily: 'Cairo')),
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Text(item.$2, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700, fontFamily: 'Cairo'))),
        ]),
      )),
    ]),
  );
}