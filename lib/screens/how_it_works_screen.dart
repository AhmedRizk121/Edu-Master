import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/responsive.dart';
import '../widgets/footer.dart';

class HowItWorksScreen extends StatelessWidget {
  final Function(String) onNavigate;
  final bool standalone;
  const HowItWorksScreen({super.key, required this.onNavigate, this.standalone = false});

  @override
  Widget build(BuildContext context) {
    final body = SingleChildScrollView(
      child: Column(children: [
        _HowHero(),
        _StepsSection(),
        _WhySection(),
        EduFooter(onNavigate: onNavigate),
      ]),
    );
    if (standalone) return Scaffold(backgroundColor: AppTheme.bgLight, body: body);
    return body;
  }
}

class _HowHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: isMobile ? 16 : 48),
      decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFF0EEFF), Color(0xFFF8F9FF)])),
      child: Column(children: [
        const Text('HOW IT WORKS', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: AppTheme.textPrimary, fontFamily: 'Cairo'), textAlign: TextAlign.center),
        const SizedBox(height: 12),
        const Text('Follow these 4 easy steps to start learning, upload your notes, and generate personalized quizzes.',
          textAlign: TextAlign.center, style: TextStyle(color: AppTheme.textSecondary, fontSize: 15, fontFamily: 'Cairo', height: 1.6)),
      ]),
    );
  }
}

class _StepsSection extends StatelessWidget {
  final List<Map<String, dynamic>> steps = const [
    {'step': '1', 'title': 'Sign up for free', 'desc': 'Create your profile and boost your educational learning to get full access.', 'icon': Icons.person_add_rounded},
    {'step': '2', 'title': 'Pick your topics', 'desc': 'Unlock the latest or topics you want for your awesome learning journey.', 'icon': Icons.topic_rounded},
    {'step': '3', 'title': 'Upload notes or PDFs', 'desc': 'Let\'s upload your notes/docs so AI can personalize your quizzes.', 'icon': Icons.upload_rounded},
    {'step': '4', 'title': 'Generate quiz & review', 'desc': 'Automatically generates quizzes based on your material. Review and master!', 'icon': Icons.auto_awesome_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 52, horizontal: isMobile ? 16 : 48),
      child: Column(children: [
        Container(
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.primaryDark]), borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.all(isMobile ? 20 : 32),
          child: isMobile
              ? Column(children: steps.asMap().entries.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    _StepCircle(step: e.value),
                    const SizedBox(width: 16),
                    Expanded(child: _StepText(step: e.value, centered: false)),
                  ]),
                )).toList())
              : Row(children: steps.map((s) => Expanded(child: Column(children: [
                  _StepCircle(step: s),
                  const SizedBox(height: 16),
                  _StepText(step: s, centered: true),
                ]))).toList()),
        ),
      ]),
    );
  }
}

class _StepCircle extends StatelessWidget {
  final Map<String, dynamic> step;
  const _StepCircle({required this.step});
  @override
  Widget build(BuildContext context) => Container(
    width: 64, height: 64,
    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.4), width: 2)),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(step['icon'] as IconData, color: Colors.white, size: 26),
      Text(step['step'] as String, style: const TextStyle(color: Colors.white70, fontSize: 10, fontFamily: 'Cairo')),
    ]),
  );
}

class _StepText extends StatelessWidget {
  final Map<String, dynamic> step; final bool centered;
  const _StepText({required this.step, required this.centered});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: centered ? CrossAxisAlignment.center : CrossAxisAlignment.start, children: [
    Text(step['title'] as String, textAlign: centered ? TextAlign.center : TextAlign.left, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700, fontFamily: 'Cairo')),
    const SizedBox(height: 6),
    Text(step['desc'] as String, textAlign: centered ? TextAlign.center : TextAlign.left, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11, fontFamily: 'Cairo', height: 1.5)),
  ]);
}

class _WhySection extends StatelessWidget {
  final List<Map<String, dynamic>> reasons = const [
    {'emoji': '🚀', 'title': 'Learn faster', 'desc': 'Accelerate your learning journey with interactive experiences designed for your pace.', 'color': AppTheme.primary},
    {'emoji': '🧠', 'title': 'Remember more', 'desc': 'Turn knowledge into lasting memories with engaging, brain-friendly patterns.', 'color': AppTheme.accent},
    {'emoji': '🎯', 'title': 'Practice smarter', 'desc': 'Spend less time guessing and more time mastering what truly matters.', 'color': AppTheme.accentGreen},
    {'emoji': '😊', 'title': 'No boring exams', 'desc': 'Fun and inspiring challenges that excite you to keep going every day.', 'color': AppTheme.accentOrange},
    {'emoji': '✨', 'title': 'Personalized quizzes', 'desc': 'Quizzes crafted just for you — because your journey is unique.', 'color': Color(0xFF8B5CF6)},
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    return Container(
      color: AppTheme.bgLight,
      padding: EdgeInsets.symmetric(vertical: 52, horizontal: isMobile ? 16 : 48),
      child: Column(children: [
        const Text('WHY YOU\'LL LOVE IT', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppTheme.textPrimary, fontFamily: 'Cairo'), textAlign: TextAlign.center),
        const SizedBox(height: 32),
        GridView.builder(
          shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
            crossAxisSpacing: 16, mainAxisSpacing: 16,
            childAspectRatio: isMobile ? 3.5 : 1.4,
          ),
          itemCount: reasons.length,
          itemBuilder: (context, i) {
            final r = reasons[i]; final color = r['color'] as Color;
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.15)), boxShadow: [BoxShadow(color: color.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 4))]),
              child: isMobile
                  ? Row(children: [Text(r['emoji'] as String, style: const TextStyle(fontSize: 32)), const SizedBox(width: 16), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(r['title'] as String, style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Cairo')), const SizedBox(height: 4), Text(r['desc'] as String, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontFamily: 'Cairo', height: 1.5))]))])
                  : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(r['emoji'] as String, style: const TextStyle(fontSize: 32)), const SizedBox(height: 12), Text(r['title'] as String, style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Cairo')), const SizedBox(height: 6), Text(r['desc'] as String, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontFamily: 'Cairo', height: 1.5))]),
            );
          },
        ),
      ]),
    );
  }
}