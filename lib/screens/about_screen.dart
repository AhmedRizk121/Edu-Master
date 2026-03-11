import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/responsive.dart';
import '../widgets/footer.dart';

class AboutScreen extends StatelessWidget {
  final Function(String) onNavigate;

  const AboutScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _AboutHero(),
          _AboutContent(),
          EduFooter(onNavigate: onNavigate),
        ],
      ),
    );
  }
}

class _AboutHero extends StatelessWidget {
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
          colors: [Color(0xFFF0EEFF), Color(0xFFFFF5F5), Color(0xFFF8F9FF)],
        ),
      ),
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(children: [
              TextSpan(text: 'ABOUT ', style: TextStyle(color: AppTheme.textPrimary, fontSize: 32, fontWeight: FontWeight.w800, fontFamily: 'Cairo')),
              TextSpan(text: 'US', style: TextStyle(color: AppTheme.primary, fontSize: 32, fontWeight: FontWeight.w800, fontFamily: 'Cairo', decoration: TextDecoration.underline, decorationColor: AppTheme.primary)),
            ]),
          ),
          const SizedBox(height: 12),
          const Text(
            'This platform helps students learn through structured tracks and test themselves using AI-generated questions from any uploaded file.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 15, fontFamily: 'Cairo', height: 1.7),
          ),
        ],
      ),
    );
  }
}

class _AboutContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: isMobile ? 16 : 48),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.getMaxContentWidth(context)),
          child: isMobile
              ? Column(children: [_AboutText(), const SizedBox(height: 32), _AboutIllustration()])
              : Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(child: _AboutIllustration()),
                  const SizedBox(width: 60),
                  Expanded(child: _AboutText()),
                ]),
        ),
      ),
    );
  }
}

class _AboutIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppTheme.primary.withOpacity(0.08), AppTheme.accent.withOpacity(0.05)]),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.primary.withOpacity(0.1)),
      ),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 90, height: 90,
            decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.1), shape: BoxShape.circle),
            child: const Icon(Icons.lightbulb_rounded, size: 48, color: AppTheme.primary),
          ),
          const SizedBox(height: 16),
          const Text('Smart Learning Platform', style: TextStyle(color: AppTheme.primary, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Cairo')),
        ]),
      ),
    );
  }
}

class _AboutText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Our Mission', style: TextStyle(color: AppTheme.primary, fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 1, fontFamily: 'Cairo')),
        const SizedBox(height: 10),
        const Text('Empowering every learner with AI', style: TextStyle(color: AppTheme.textPrimary, fontSize: 24, fontWeight: FontWeight.w800, fontFamily: 'Cairo', height: 1.2)),
        const SizedBox(height: 16),
        const Text(
          'This platform helps students learn through structured tracks and test themselves using AI-generated questions from any uploaded file (PDF, Word, text, or slides).',
          style: TextStyle(color: AppTheme.textSecondary, fontSize: 15, fontFamily: 'Cairo', height: 1.7),
        ),
        const SizedBox(height: 24),
        ...[
          ('Learning Tracks', Icons.route_rounded, AppTheme.primary, 'Structured paths from beginner to advanced'),
          ('AI Quiz Generator', Icons.auto_awesome_rounded, AppTheme.accent, 'MCQs generated from your own files'),
          ('Progress Tracking', Icons.trending_up_rounded, AppTheme.accentGreen, 'Visual dashboards to track growth'),
        ].map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: item.$3.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
              child: Icon(item.$2, color: item.$3, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(item.$1, style: TextStyle(color: item.$3, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Cairo')),
              Text(item.$4, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontFamily: 'Cairo')),
            ])),
          ]),
        )),
      ],
    );
  }
}