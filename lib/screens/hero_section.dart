import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/responsive.dart';

class HeroSection extends StatelessWidget {
  final Function(String) onNavigate;

  const HeroSection({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF0EEFF), Color(0xFFFFF5F5), Color(0xFFF8F9FF)],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.getMaxContentWidth(context)),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 0,
              vertical: isMobile ? 40 : 60,
            ),
            child: isMobile || isTablet
                ? _MobileHero(onNavigate: onNavigate)
                : _DesktopHero(onNavigate: onNavigate),
          ),
        ),
      ),
    );
  }
}

class _DesktopHero extends StatelessWidget {
  final Function(String) onNavigate;

  const _DesktopHero({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _HeroText(onNavigate: onNavigate),
            ],
          ),
        ),
        const SizedBox(width: 48),
        Expanded(
          child: _HeroIllustration(),
        ),
      ],
    );
  }
}

class _MobileHero extends StatelessWidget {
  final Function(String) onNavigate;

  const _MobileHero({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HeroIllustration(isMobile: true),
        const SizedBox(height: 32),
        _HeroText(onNavigate: onNavigate, centered: true),
      ],
    );
  }
}

class _HeroText extends StatelessWidget {
  final Function(String) onNavigate;
  final bool centered;

  const _HeroText({required this.onNavigate, this.centered = false});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: centered ? TextAlign.center : TextAlign.left,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Learn ',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: isMobile ? 30 : 42,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Cairo',
                  height: 1.2,
                ),
              ),
              TextSpan(
                text: 'Smarter',
                style: TextStyle(
                  color: AppTheme.primary,
                  fontSize: isMobile ? 30 : 42,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Cairo',
                  height: 1.2,
                ),
              ),
              TextSpan(
                text: ', Test ',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: isMobile ? 30 : 42,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Cairo',
                  height: 1.2,
                ),
              ),
              TextSpan(
                text: 'Yourself',
                style: TextStyle(
                  color: AppTheme.accent,
                  fontSize: isMobile ? 30 : 42,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Cairo',
                  height: 1.2,
                ),
              ),
              TextSpan(
                text: ', Master ',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: isMobile ? 30 : 42,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Cairo',
                  height: 1.2,
                ),
              ),
              TextSpan(
                text: 'Any Topic',
                style: TextStyle(
                  color: AppTheme.accentOrange,
                  fontSize: isMobile ? 30 : 42,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Cairo',
                  height: 1.2,
                ),
              ),
              TextSpan(
                text: '.',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: isMobile ? 30 : 42,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Cairo',
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'AI-powered learning tracks + Instant quizzes from your own files.',
          textAlign: centered ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: isMobile ? 15 : 17,
            fontFamily: 'Cairo',
            height: 1.6,
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: () => onNavigate('/features'),
              icon: const Icon(Icons.rocket_launch_rounded, size: 18),
              label: const Text('Start Learning'),
            ),
            OutlinedButton.icon(
              onPressed: () => onNavigate('/how-it-works'),
              icon: const Icon(Icons.play_circle_outline_rounded, size: 18),
              label: const Text('Test Yourself'),
            ),
          ],
        ),
      ],
    );
  }
}

class _HeroIllustration extends StatelessWidget {
  final bool isMobile;

  const _HeroIllustration({this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMobile ? 200 : 360,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primary.withOpacity(0.1),
            AppTheme.accent.withOpacity(0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.primary.withOpacity(0.15), width: 1.5),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circles
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.accent.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: isMobile ? 80 : 100,
                height: isMobile ? 80 : 100,
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.school_rounded,
                  size: isMobile ? 44 : 56,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'AI-Powered Learning',
                style: TextStyle(
                  color: AppTheme.primary,
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  _Tag('📄 PDF', AppTheme.accentOrange),
                  _Tag('📝 Word', AppTheme.accentGreen),
                  _Tag('📊 Slides', AppTheme.primary),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;

  const _Tag(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Cairo'),
      ),
    );
  }
}