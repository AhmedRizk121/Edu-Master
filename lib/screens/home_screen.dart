import 'package:flutter/material.dart';
import '../widgets/footer.dart';
import 'hero_section.dart';


class HomeScreen extends StatelessWidget {
  final Function(String) onNavigate;

  const HomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            // 1. Hero Section
            HeroSection(onNavigate: onNavigate),

            // 2. About Us Section (inline on home)
            _AboutContent(onNavigate: onNavigate),

            // 3. Features Section (inline on home)
            _FeaturesContent(),

            // 4. XP Section (inline on home)
            _XPSectionPreview(),

            // 5. How It Works (inline on home)
            _HowItWorksPreview(),

            // 6. Why You'll Love It (inline on home)
            _WhyYoullLoveItPreview(),

            // 7. Start Learning CTA
            _StartLearningCTA(onNavigate: onNavigate),

            // 8. FAQ Section (inline on home)
            _FAQPreview(onNavigate: onNavigate),

            // 9. Footer
            EduFooter(onNavigate: onNavigate),
          ],
        ),
    );
  }
}

class _AboutContent extends StatelessWidget {
  final Function(String) onNavigate;

  const _AboutContent({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return _InlineAbout();
  }
}

// Inline About (reuse from AboutScreen logic)
class _InlineAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: isMobile ? 16 : 48),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: isMobile
              ? Column(children: [_AboutText(), const SizedBox(height: 32), _AboutIllustration()])
              : Row(children: [
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
        gradient: LinearGradient(colors: [const Color(0xFF6C63FF).withOpacity(0.08), const Color(0xFFFF6B6B).withOpacity(0.05)]),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF6C63FF).withOpacity(0.1)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(color: const Color(0xFF6C63FF).withOpacity(0.1), shape: BoxShape.circle),
              child: const Icon(Icons.lightbulb_rounded, size: 48, color: Color(0xFF6C63FF)),
            ),
            const SizedBox(height: 16),
            const Text('Smart Learning Platform', style: TextStyle(color: Color(0xFF6C63FF), fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Cairo')),
          ],
        ),
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
        RichText(
          text: const TextSpan(children: [
            TextSpan(text: 'ABOUT ', style: TextStyle(color: Color(0xFF2D2D2D), fontSize: 28, fontWeight: FontWeight.w800, fontFamily: 'Cairo')),
            TextSpan(text: 'US', style: TextStyle(color: Color(0xFF6C63FF), fontSize: 28, fontWeight: FontWeight.w800, fontFamily: 'Cairo', decoration: TextDecoration.underline, decorationColor: Color(0xFF6C63FF))),
          ]),
        ),
        const SizedBox(height: 16),
        const Text(
          'This platform helps students learn through structured tracks and test themselves using AI-generated questions from any uploaded file (PDF, Word, text, or slides).',
          style: TextStyle(color: Color(0xFF6B7280), fontSize: 15, fontFamily: 'Cairo', height: 1.7),
        ),
        const SizedBox(height: 20),
        ...[
          ('Learning Tracks', Icons.route_rounded, const Color(0xFF6C63FF)),
          ('AI Quiz Generator', Icons.auto_awesome_rounded, const Color(0xFFFF6B6B)),
          ('Progress Tracking', Icons.trending_up_rounded, const Color(0xFF4CAF50)),
        ].map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(color: item.$3.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Icon(item.$2, color: item.$3, size: 20),
            ),
            const SizedBox(width: 12),
            Text(item.$1, style: TextStyle(color: item.$3, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Cairo')),
          ]),
        )),
      ],
    );
  }
}

// Simple wrappers that reuse the existing screen content widgets
class _FeaturesContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const _HomeFeaturesWidget();
  }
}

class _HomeFeaturesWidget extends StatelessWidget {
  const _HomeFeaturesWidget();

  final List<Map<String, dynamic>> features = const [
    {'number': '01', 'title': 'Structured Learning Tracks', 'icon': Icons.route_rounded, 'color': Color(0xFF6C63FF), 'items': ['Beginner', 'Intermediate', 'Advanced']},
    {'number': '02', 'title': 'Upload Any File', 'icon': Icons.upload_file_rounded, 'color': Color(0xFFFF6B6B), 'items': ['Upload PDF, DOCX, TXT', 'AI generates MCQs', 'True/False, Short answers']},
    {'number': '03', 'title': 'Smart Feedback', 'icon': Icons.psychology_rounded, 'color': Color(0xFF4CAF50), 'items': ['See correct answers', 'Track weak topics']},
    {'number': '04', 'title': 'Progress Dashboard', 'icon': Icons.dashboard_rounded, 'color': Color(0xFFFF9800), 'items': ['Courses completed', 'Quiz scores', 'Learning streak']},
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1200;

    return Container(
      color: const Color(0xFFF8F9FF),
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: isMobile ? 16 : 48),
      child: Column(
        children: [
          RichText(textAlign: TextAlign.center, text: const TextSpan(children: [
            TextSpan(text: 'OUR ', style: TextStyle(color: Color(0xFF2D2D2D), fontSize: 28, fontWeight: FontWeight.w800, fontFamily: 'Cairo')),
            TextSpan(text: 'FEATURES', style: TextStyle(color: Color(0xFF6C63FF), fontSize: 28, fontWeight: FontWeight.w800, fontFamily: 'Cairo', decoration: TextDecoration.underline, decorationColor: Color(0xFF6C63FF))),
          ])),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 4),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: isMobile ? 2.5 : 0.85,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) {
              final f = features[index];
              final color = f['color'] as Color;
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  boxShadow: [BoxShadow(color: color.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, 4))],
                ),
                child: isMobile
                    ? Row(children: [
                        _FeatureIcon(color: color, icon: f['icon'] as IconData, number: f['number'] as String),
                        const SizedBox(width: 16),
                        Expanded(child: _FeatureContent(feature: f, color: color)),
                      ])
                    : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        _FeatureIcon(color: color, icon: f['icon'] as IconData, number: f['number'] as String),
                        const SizedBox(height: 16),
                        _FeatureContent(feature: f, color: color),
                      ]),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FeatureIcon extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String number;

  const _FeatureIcon({required this.color, required this.icon, required this.number});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: 52, height: 52,
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: color, size: 26),
      ),
      Positioned(
        top: 0, right: 0,
        child: Container(
          width: 20, height: 20,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(child: Text(number, style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w700, fontFamily: 'Cairo'))),
        ),
      ),
    ]);
  }
}

class _FeatureContent extends StatelessWidget {
  final Map<String, dynamic> feature;
  final Color color;

  const _FeatureContent({required this.feature, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(feature['title'] as String, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Cairo')),
      const SizedBox(height: 8),
      ...(feature['items'] as List<String>).map((item) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(children: [
          Icon(Icons.check_circle_rounded, color: color, size: 14),
          const SizedBox(width: 6),
          Flexible(child: Text(item, style: const TextStyle(color: Color(0xFF6B7280), fontSize: 12, fontFamily: 'Cairo'))),
        ]),
      )),
    ]);
  }
}

class _XPSectionPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: isMobile ? 16 : 48),
      child: Column(
        children: [
          const Text('Earn XP as You Learn! 🚀', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xFF2D2D2D), fontFamily: 'Cairo'), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          const Text('Our platform rewards your effort with points. Climb the ranks and build an unstoppable daily streak!', style: TextStyle(color: Color(0xFF6B7280), fontSize: 14, fontFamily: 'Cairo', height: 1.6), textAlign: TextAlign.center),
          const SizedBox(height: 32),
          Wrap(
            spacing: 16, runSpacing: 16, alignment: WrapAlignment.center,
            children: [
              _XPCardSimple(icon: '🎯', title: 'Learning Basics', items: [('Pass a lesson', '+5 XP'), ('Watch a lesson', '+20 XP'), ('Complete Track', '+100 XP')], color: const Color(0xFF6C63FF)),
              _XPCardSimple(icon: '🧠', title: 'Testing Knowledge', items: [('Pass lesson Quiz', '+10 XP'), ('Pass final Track Quiz', '+60 XP')], color: const Color(0xFF4CAF50)),
              _XPCardSimple(icon: '🔥', title: 'Daily Streaks', items: [('Daily Login', '+5 XP'), ('7 Days Streak', '+20 Bonus'), ('30 Days Streak', '+100 Bonus')], color: const Color(0xFFFF6B6B)),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(color: const Color(0xFF6C63FF).withOpacity(0.08), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFF6C63FF).withOpacity(0.2))),
            child: const Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.info_outline_rounded, color: Color(0xFF6C63FF), size: 16),
              SizedBox(width: 8),
              Text('Daily Cap: You can earn a maximum of 200 XP per day. Stay consistent!', style: TextStyle(color: Color(0xFF6C63FF), fontSize: 12, fontFamily: 'Cairo')),
            ]),
          ),
        ],
      ),
    );
  }
}

class _XPCardSimple extends StatelessWidget {
  final String icon;
  final String title;
  final List<(String, String)> items;
  final Color color;

  const _XPCardSimple({required this.icon, required this.title, required this.items, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [BoxShadow(color: color.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 10),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF2D2D2D), fontFamily: 'Cairo'))),
        ]),
        const SizedBox(height: 16),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(item.$1, style: const TextStyle(color: Color(0xFF6B7280), fontSize: 12, fontFamily: 'Cairo')),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Text(item.$2, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700, fontFamily: 'Cairo')),
            ),
          ]),
        )),
      ]),
    );
  }
}

class _HowItWorksPreview extends StatelessWidget {
  final List<Map<String, dynamic>> steps = const [
    {'step': '1', 'title': 'Sign up for free', 'desc': 'Create your profile and boost your educational learning.', 'icon': Icons.person_add_rounded},
    {'step': '2', 'title': 'Pick your topics', 'desc': 'Unlock the topics you want for your learning journey.', 'icon': Icons.topic_rounded},
    {'step': '3', 'title': 'Upload notes or PDFs', 'desc': 'AI will personalize your quizzes based on your material.', 'icon': Icons.upload_rounded},
    {'step': '4', 'title': 'Generate quiz & review', 'desc': 'Auto-generates quizzes and review your results.', 'icon': Icons.auto_awesome_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      color: const Color(0xFFF8F9FF),
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: isMobile ? 16 : 48),
      child: Column(
        children: [
          const Text('HOW IT WORKS', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF2D2D2D), fontFamily: 'Cairo')),
          const SizedBox(height: 8),
          const Text('Follow these 4 easy steps to start learning, upload your notes, and generate personalized quizzes.', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF6B7280), fontSize: 14, fontFamily: 'Cairo', height: 1.6)),
          const SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFF4A42D0)]), borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.all(isMobile ? 20 : 30),
            child: isMobile
                ? Column(children: steps.asMap().entries.map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Container(
                        width: 60, height: 60,
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.4), width: 2)),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Icon(e.value['icon'] as IconData, color: Colors.white, size: 24),
                          Text(e.value['step'] as String, style: const TextStyle(color: Colors.white70, fontSize: 10, fontFamily: 'Cairo')),
                        ]),
                      ),
                      const SizedBox(width: 16),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(e.value['title'] as String, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700, fontFamily: 'Cairo')),
                        const SizedBox(height: 4),
                        Text(e.value['desc'] as String, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11, fontFamily: 'Cairo', height: 1.5)),
                      ])),
                    ]),
                  )).toList())
                : Row(children: steps.map((s) => Expanded(child: Column(children: [
                    Container(
                      width: 60, height: 60,
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.4), width: 2)),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(s['icon'] as IconData, color: Colors.white, size: 24),
                        Text(s['step'] as String, style: const TextStyle(color: Colors.white70, fontSize: 10, fontFamily: 'Cairo')),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    Text(s['title'] as String, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700, fontFamily: 'Cairo')),
                    const SizedBox(height: 6),
                    Text(s['desc'] as String, textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11, fontFamily: 'Cairo', height: 1.5)),
                  ]))).toList()),
          ),
        ],
      ),
    );
  }
}

class _WhyYoullLoveItPreview extends StatelessWidget {
  final List<Map<String, dynamic>> reasons = const [
    {'emoji': '🚀', 'title': 'Learn faster', 'desc': 'Accelerate your learning journey with interactive experiences.', 'color': Color(0xFF6C63FF)},
    {'emoji': '🧠', 'title': 'Remember more', 'desc': 'Turn knowledge into lasting memories with engaging patterns.', 'color': Color(0xFFFF6B6B)},
    {'emoji': '🎯', 'title': 'Practice smarter', 'desc': 'Spend less time guessing and more time mastering what matters.', 'color': Color(0xFF4CAF50)},
    {'emoji': '😊', 'title': 'No boring exams', 'desc': 'Fun and inspiring challenges that excite you to keep going.', 'color': Color(0xFFFF9800)},
    {'emoji': '✨', 'title': 'Personalized quizzes', 'desc': 'Quizzes crafted just for you — because your journey is unique.', 'color': Color(0xFFFFD700)},
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1200;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: isMobile ? 16 : 48),
      child: Column(
        children: [
          const Text('WHY YOU\'LL LOVE IT', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF2D2D2D), fontFamily: 'Cairo')),
          const SizedBox(height: 32),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
              crossAxisSpacing: 16, mainAxisSpacing: 16,
              childAspectRatio: isMobile ? 3.5 : 1.5,
            ),
            itemCount: reasons.length,
            itemBuilder: (context, index) {
              final r = reasons[index];
              final color = r['color'] as Color;
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FF),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: color.withOpacity(0.15)),
                  boxShadow: [BoxShadow(color: color.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 4))],
                ),
                child: isMobile
                    ? Row(children: [
                        Text(r['emoji'] as String, style: const TextStyle(fontSize: 32)),
                        const SizedBox(width: 16),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(r['title'] as String, style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Cairo')),
                          const SizedBox(height: 4),
                          Text(r['desc'] as String, style: const TextStyle(color: Color(0xFF6B7280), fontSize: 12, fontFamily: 'Cairo', height: 1.5)),
                        ])),
                      ])
                    : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(r['emoji'] as String, style: const TextStyle(fontSize: 32)),
                        const SizedBox(height: 12),
                        Text(r['title'] as String, style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Cairo')),
                        const SizedBox(height: 6),
                        Text(r['desc'] as String, style: const TextStyle(color: Color(0xFF6B7280), fontSize: 12, fontFamily: 'Cairo', height: 1.5)),
                      ]),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StartLearningCTA extends StatelessWidget {
  final Function(String) onNavigate;

  const _StartLearningCTA({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      color: const Color(0xFFF8F9FF),
      padding: EdgeInsets.symmetric(vertical: 48, horizontal: isMobile ? 16 : 48),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 800),
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            const Text('Start Learning', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800, fontFamily: 'Cairo')),
            const SizedBox(height: 8),
            const Text('Test Yourself like a pro !', style: TextStyle(color: Color(0xFF6C63FF), fontSize: 15, fontFamily: 'Cairo', fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text('Unlock interactive quizzes, personalized tracks, and gamified challenges designed to make you smarter, faster.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13, fontFamily: 'Cairo', height: 1.6)),
            const SizedBox(height: 24),
            Wrap(spacing: 12, runSpacing: 12, alignment: WrapAlignment.center, children: [
              ElevatedButton(
                onPressed: () => onNavigate('/signup'),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C63FF), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                child: const Text('Start Learning'),
              ),
              OutlinedButton(
                onPressed: () => onNavigate('/features'),
                style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white54), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                child: const Text('Explore Tracks'),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

class _FAQPreview extends StatelessWidget {
  final Function(String) onNavigate;

  const _FAQPreview({required this.onNavigate});

  final List<Map<String, String>> faqs = const [
    {'question': 'Is it really free?', 'answer': 'Yes! EduMaster offers a free tier with access to core features including learning tracks, quiz generation from uploaded files, and progress tracking.'},
    {'question': 'Can\'t I upload any kind of file?', 'answer': 'We support PDF, DOCX (Word), TXT, and PowerPoint files. We\'re working on expanding support for more file types.'},
    {'question': 'Is my data private?', 'answer': 'Absolutely. Your uploaded files and learning data are encrypted and stored securely. We never share your personal data.'},
    {'question': 'How does the AI quiz generator work?', 'answer': 'Our AI analyzes your uploaded content and generates diverse question types including multiple choice, true/false, and short answer questions.'},
    {'question': 'What ages/levels can use this platform?', 'answer': 'EduMaster is designed for learners of all ages — from high school students to university students and professionals.'},
    {'question': 'Can teachers or tutors use it?', 'answer': 'Definitely! Teachers can create custom learning tracks, assign quizzes to students, and track progress with special educator plans.'},
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: isMobile ? 16 : 48),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              RichText(textAlign: TextAlign.center, text: const TextSpan(children: [
                TextSpan(text: 'Frequently ', style: TextStyle(color: Color(0xFF2D2D2D), fontSize: 28, fontWeight: FontWeight.w800, fontFamily: 'Cairo')),
                TextSpan(text: 'Asked Questions', style: TextStyle(color: Color(0xFF6C63FF), fontSize: 28, fontWeight: FontWeight.w800, fontFamily: 'Cairo')),
              ])),
              const SizedBox(height: 40),
              ...faqs.map((faq) => _FAQItemSimple(faq: faq)),
            ],
          ),
        ),
      ),
    );
  }
}

class _FAQItemSimple extends StatefulWidget {
  final Map<String, String> faq;

  const _FAQItemSimple({required this.faq});

  @override
  State<_FAQItemSimple> createState() => _FAQItemSimpleState();
}

class _FAQItemSimpleState extends State<_FAQItemSimple> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _expanded ? const Color(0xFF6C63FF).withOpacity(0.3) : const Color(0xFFE5E7EB)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => setState(() => _expanded = !_expanded),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(child: Text(widget.faq['question']!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _expanded ? const Color(0xFF6C63FF) : const Color(0xFF2D2D2D), fontFamily: 'Cairo'))),
              AnimatedRotation(turns: _expanded ? 0.5 : 0, duration: const Duration(milliseconds: 200), child: Icon(Icons.keyboard_arrow_down_rounded, color: _expanded ? const Color(0xFF6C63FF) : const Color(0xFF6B7280))),
            ]),
            if (_expanded) ...[
              const SizedBox(height: 12),
              Text(widget.faq['answer']!, style: const TextStyle(color: Color(0xFF6B7280), fontSize: 13, fontFamily: 'Cairo', height: 1.6)),
            ],
          ]),
        ),
      ),
    );
  }
}