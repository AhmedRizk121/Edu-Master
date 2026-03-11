import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/responsive.dart';
import '../widgets/footer.dart';

class FAQScreen extends StatelessWidget {
  final Function(String) onNavigate;
  final bool standalone;
  const FAQScreen({super.key, required this.onNavigate, this.standalone = false});

  @override
  Widget build(BuildContext context) {
    final body = SingleChildScrollView(
      child: Column(children: [
        _FAQHero(),
        _FAQList(onNavigate: onNavigate),
        EduFooter(onNavigate: onNavigate),
      ]),
    );
    if (standalone) return Scaffold(backgroundColor: AppTheme.bgLight, body: body);
    return body;
  }
}

class _FAQHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: isMobile ? 16 : 48),
      decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFF0EEFF), Color(0xFFF8F9FF)])),
      child: Column(children: [
        RichText(textAlign: TextAlign.center, text: const TextSpan(children: [
          TextSpan(text: 'Frequently ', style: TextStyle(color: AppTheme.textPrimary, fontSize: 32, fontWeight: FontWeight.w800, fontFamily: 'Cairo')),
          TextSpan(text: 'Asked Questions', style: TextStyle(color: AppTheme.primary, fontSize: 32, fontWeight: FontWeight.w800, fontFamily: 'Cairo')),
        ])),
        const SizedBox(height: 12),
        const Text('Everything you need to know about EduMaster.', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.textSecondary, fontSize: 15, fontFamily: 'Cairo')),
      ]),
    );
  }
}

class _FAQList extends StatelessWidget {
  final Function(String) onNavigate;
  const _FAQList({required this.onNavigate});

  final List<Map<String, String>> faqs = const [
    {'q': 'Is it really free?', 'a': 'Yes! EduMaster offers a free tier with access to core features including learning tracks, quiz generation from uploaded files, and progress tracking. Premium features are available for power users.'},
    {'q': 'Can\'t I upload any kind of file?', 'a': 'Currently we support PDF, DOCX (Word), TXT, and PowerPoint files. We\'re working on expanding support for more file types including images and videos.'},
    {'q': 'Is my data private?', 'a': 'Absolutely. Your uploaded files and learning data are encrypted and stored securely. We never share your personal data or file contents with third parties.'},
    {'q': 'How does the AI quiz generator work?', 'a': 'Our AI analyzes your uploaded content, identifies key concepts, and generates diverse question types including multiple choice, true/false, and short answer questions — all tailored to your material.'},
    {'q': 'What ages/levels can use this platform?', 'a': 'EduMaster is designed for learners of all ages — from high school students to university students and professionals. Content adapts to beginner, intermediate, and advanced levels.'},
    {'q': 'Can teachers or tutors use it?', 'a': 'Definitely! Teachers can create custom learning tracks, assign quizzes to students, and track progress. We have special educator plans with classroom management features.'},
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 52, horizontal: isMobile ? 16 : 48),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(children: [
            ...faqs.map((faq) => _FAQItem(q: faq['q']!, a: faq['a']!)),
            const SizedBox(height: 48),
            _CTACard(onNavigate: onNavigate),
          ]),
        ),
      ),
    );
  }
}

class _FAQItem extends StatefulWidget {
  final String q, a;
  const _FAQItem({required this.q, required this.a});
  @override
  State<_FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<_FAQItem> {
  bool _open = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _open ? AppTheme.primary.withOpacity(0.3) : AppTheme.borderColor),
        boxShadow: _open ? [BoxShadow(color: AppTheme.primary.withOpacity(0.07), blurRadius: 12, offset: const Offset(0, 4))] : [],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => setState(() => _open = !_open),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(child: Text(widget.q, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _open ? AppTheme.primary : AppTheme.textPrimary, fontFamily: 'Cairo'))),
              AnimatedRotation(turns: _open ? 0.5 : 0, duration: const Duration(milliseconds: 200), child: Icon(Icons.keyboard_arrow_down_rounded, color: _open ? AppTheme.primary : AppTheme.textSecondary)),
            ]),
            if (_open) ...[
              const SizedBox(height: 12),
              Text(widget.a, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13, fontFamily: 'Cairo', height: 1.6)),
            ],
          ]),
        ),
      ),
    );
  }
}

class _CTACard extends StatelessWidget {
  final Function(String) onNavigate;
  const _CTACard({required this.onNavigate});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF1A1A2E), Color(0xFF16213E)]), borderRadius: BorderRadius.circular(24)),
      child: Column(children: [
        const Text('Start Learning', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800, fontFamily: 'Cairo')),
        const SizedBox(height: 8),
        const Text('Test Yourself like a pro !', style: TextStyle(color: AppTheme.primary, fontSize: 15, fontFamily: 'Cairo', fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Text('Unlock interactive quizzes, personalized tracks, and gamified challenges.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13, fontFamily: 'Cairo', height: 1.6)),
        const SizedBox(height: 24),
        Wrap(spacing: 12, runSpacing: 12, alignment: WrapAlignment.center, children: [
          ElevatedButton(
            onPressed: () => onNavigate('/signup'),
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
            child: const Text('Start Learning'),
          ),
          OutlinedButton(
            onPressed: () => onNavigate('/features'),
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white54), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
            child: const Text('Explore Tracks'),
          ),
        ]),
      ]),
    );
  }
}