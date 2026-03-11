import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/responsive.dart';

class EduFooter extends StatelessWidget {
  final Function(String) onNavigate;

  const EduFooter({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      color: AppTheme.dark,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 48,
        vertical: 40,
      ),
      child: Column(
        children: [
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBrand(),
                    const SizedBox(height: 28),
                    _buildFollowUs(),
                    const SizedBox(height: 28),
                    _buildTagline(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildBrand()),
                    Expanded(child: _buildFollowUs()),
                    Expanded(child: _buildTagline()),
                  ],
                ),
          const SizedBox(height: 32),
          const Divider(color: Colors.white24),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '© 2026 EduMaster. All rights reserved.',
                style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12, fontFamily: 'Cairo'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBrand() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'EDU',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Cairo',
                ),
              ),
              TextSpan(
                text: 'MASTER',
                style: TextStyle(
                  color: AppTheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Cairo',
                ),
              ),
              TextSpan(
                text: ' 🚀',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Empowering learners for the future',
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 13,
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }

  Widget _buildFollowUs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Follow us on',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Cairo',
          ),
        ),
        const SizedBox(height: 12),
        _SocialLink(icon: Icons.language, label: 'Home'),
        _SocialLink(icon: Icons.alternate_email, label: 'Twitter'),
        _SocialLink(icon: Icons.book_rounded, label: 'Learning Tracks'),
        _SocialLink(icon: Icons.quiz_rounded, label: 'Test Yourself'),
      ],
    );
  }

  Widget _buildTagline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '"EduMaster is the most powerful platform which you can use to challenge yourself."',
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 13,
            fontStyle: FontStyle.italic,
            fontFamily: 'Cairo',
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => onNavigate('/signup'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text('Start Learning', style: TextStyle(fontSize: 13)),
        ),
      ],
    );
  }
}

class _SocialLink extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SocialLink({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.white60, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white60, fontSize: 13, fontFamily: 'Cairo'),
          ),
        ],
      ),
    );
  }
}