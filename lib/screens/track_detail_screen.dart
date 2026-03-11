import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/track_models.dart';
import '../screens/Lesson_screen.dart';

class TrackDetailScreen extends StatefulWidget {
  final TrackModel track;
  final Function(String) onNavigate;

  const TrackDetailScreen({super.key, required this.track, required this.onNavigate});

  @override
  State<TrackDetailScreen> createState() => _TrackDetailScreenState();
}

class _TrackDetailScreenState extends State<TrackDetailScreen> {
  void _goToLesson(LessonModel lesson) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, anim, __) => LessonScreen(
          track: widget.track,
          lesson: lesson,
          onNavigate: widget.onNavigate,
        ),
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 250),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Breadcrumb ───────────────────────────────────────────────
            Container(
              color: AppTheme.primary,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SafeArea(
                bottom: false,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 16),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.track.title,
                        style: const TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'Cairo', fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Main content ─────────────────────────────────────────────
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.borderColor),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.track.title,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppTheme.textPrimary, fontFamily: 'Cairo', height: 1.3),
                  ),
                  const SizedBox(height: 12),
                  // Description
                  Text(
                    widget.track.description,
                    style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary, fontFamily: 'Cairo', height: 1.7),
                  ),
                  const SizedBox(height: 32),

                  // ── About this Track (animated) ──────────────────────
                  const Text('About this Track', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.textPrimary, fontFamily: 'Cairo')),
                  const SizedBox(height: 16),
                  _AnimatedAboutGrid(points: widget.track.aboutPoints),

                  const SizedBox(height: 32),

                  // ── Visual Highlights ────────────────────────────────
                  const Text('Visual Highlights', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.textPrimary, fontFamily: 'Cairo')),
                  const SizedBox(height: 16),
                  _VisualHighlights(trackId: widget.track.id),

                  const SizedBox(height: 32),

                  // ── Enroll button ────────────────────────────────────
                  Center(
                    child: ElevatedButton(
                      onPressed: widget.track.lessons.isNotEmpty
                          ? () => _goToLesson(widget.track.lessons.first)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Cairo'),
                      ),
                      child: const Text('Continue Learning'),
                    ),
                  ),
                ],
              ),
            ),

            // ── Footer ───────────────────────────────────────────────────
            _TrackDetailFooter(onNavigate: widget.onNavigate),
          ],
        ),
      ),
    );
  }
}

// ─── Animated About Grid ──────────────────────────────────────────────────────
class _AnimatedAboutGrid extends StatefulWidget {
  final List<String> points;
  const _AnimatedAboutGrid({required this.points});

  @override
  State<_AnimatedAboutGrid> createState() => _AnimatedAboutGridState();
}

class _AnimatedAboutGridState extends State<_AnimatedAboutGrid> {
  int _visibleCount = 0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() async {
    for (int i = 0; i < widget.points.length; i++) {
      await Future.delayed(const Duration(milliseconds: 5000));
      if (mounted) setState(() => _visibleCount = i + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    if (isMobile) {
      return Column(
        children: List.generate(widget.points.length, (i) {
          final visible = i < _visibleCount;
          return AnimatedOpacity(
            opacity: visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 600),
            child: AnimatedSlide(
              offset: visible ? Offset.zero : const Offset(-0.1, 0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _AboutCard(text: widget.points[i], isLeft: true),
              ),
            ),
          );
        }),
      );
    }

    // Desktop: 2-column grid with alternating left/right
    final List<Widget> rows = [];
    for (int i = 0; i < widget.points.length; i += 2) {
      final leftVisible = i < _visibleCount;
      final rightVisible = (i + 1) < _visibleCount;

      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Expanded(
                child: AnimatedOpacity(
                  opacity: leftVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 700),
                  child: AnimatedSlide(
                    offset: leftVisible ? Offset.zero : const Offset(-0.15, 0),
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOut,
                    child: _AboutCard(text: widget.points[i], isLeft: true),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              if (i + 1 < widget.points.length)
                Expanded(
                  child: AnimatedOpacity(
                    opacity: rightVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 700),
                    child: AnimatedSlide(
                      offset: rightVisible ? Offset.zero : const Offset(0.15, 0),
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeOut,
                      child: _AboutCard(text: widget.points[i + 1], isLeft: false),
                    ),
                  ),
                )
              else
                const Expanded(child: SizedBox()),
            ],
          ),
        ),
      );
    }

    return Column(children: rows);
  }
}

class _AboutCard extends StatelessWidget {
  final String text;
  final bool isLeft;
  const _AboutCard({required this.text, required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.bgLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: _TypingText(text: text),
    );
  }
}

// ─── Typing Text Animation ────────────────────────────────────────────────────
class _TypingText extends StatefulWidget {
  final String text;
  const _TypingText({required this.text});

  @override
  State<_TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<_TypingText> {
  String _displayed = '';
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _type();
  }

  void _type() async {
    while (_index < widget.text.length) {
      await Future.delayed(const Duration(milliseconds: 18));
      if (mounted) {
        setState(() {
          _displayed = widget.text.substring(0, _index + 1);
          _index++;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayed,
      style: const TextStyle(
        fontSize: 13,
        color: AppTheme.textSecondary,
        fontFamily: 'Cairo',
        height: 1.6,
      ),
    );
  }
}

// ─── Visual Highlights ────────────────────────────────────────────────────────
class _VisualHighlights extends StatelessWidget {
  final String trackId;
  const _VisualHighlights({required this.trackId});

  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xFF6C63FF),
      const Color(0xFF1A1A2E),
      const Color(0xFF16213E),
    ];
    final icons = [
      Icons.code_rounded,
      Icons.terminal_rounded,
      Icons.web_rounded,
    ];

    return SizedBox(
      height: 160,
      child: Row(
        children: List.generate(3, (i) => Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i < 2 ? 10 : 0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [colors[i], colors[i].withOpacity(0.7)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(icons[i], color: Colors.white.withOpacity(0.8), size: 48),
              ),
            ),
          ),
        )),
      ),
    );
  }
}

// ─── Footer ───────────────────────────────────────────────────────────────────
class _TrackDetailFooter extends StatelessWidget {
  final Function(String) onNavigate;
  const _TrackDetailFooter({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      color: const Color(0xFFF1F0FF),
      child: Column(
        children: [
          isMobile
              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _FBrand(), const SizedBox(height: 20),
                  _FLinks(onNavigate: onNavigate), const SizedBox(height: 20),
                  _FQuote(onNavigate: onNavigate),
                ])
              : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(child: _FBrand()),
                  Expanded(child: _FLinks(onNavigate: onNavigate)),
                  Expanded(child: _FQuote(onNavigate: onNavigate)),
                ]),
          const SizedBox(height: 20),
          const Divider(color: AppTheme.borderColor),
          const SizedBox(height: 10),
          const Text('© 2026 eduMaster. All rights reserved.',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 11, fontFamily: 'Cairo')),
        ],
      ),
    );
  }
}

class _FBrand extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    RichText(text: const TextSpan(children: [
      TextSpan(text: 'EDU', style: TextStyle(color: AppTheme.textPrimary, fontSize: 16, fontWeight: FontWeight.w800, fontFamily: 'Cairo')),
      TextSpan(text: 'MASTER', style: TextStyle(color: AppTheme.primary, fontSize: 16, fontWeight: FontWeight.w800, fontFamily: 'Cairo')),
      TextSpan(text: ' 🎓', style: TextStyle(fontSize: 14)),
    ])),
    const SizedBox(height: 6),
    const Text('Empowering learners for the future', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11, fontFamily: 'Cairo')),
  ]);
}

class _FLinks extends StatelessWidget {
  final Function(String) onNavigate;
  const _FLinks({required this.onNavigate});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('Follow us on', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.primary, fontFamily: 'Cairo')),
    const SizedBox(height: 10),
    ...[('Home', Icons.home_outlined, '/'), ('Dashboard', Icons.dashboard_outlined, '/dashboard'),
        ('Explore Tracks', Icons.explore_outlined, '/explore-tracks'), ('Test Yourself', Icons.quiz_outlined, '/test-yourself')]
        .map((l) => GestureDetector(
          onTap: () { Navigator.pop(context); onNavigate(l.$3); },
          child: Padding(padding: const EdgeInsets.only(bottom: 7), child: Row(children: [
            Icon(l.$2, size: 14, color: AppTheme.textSecondary), const SizedBox(width: 7),
            Text(l.$1, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontFamily: 'Cairo')),
          ])),
        )),
  ]);
}

class _FQuote extends StatelessWidget {
  final Function(String) onNavigate;
  const _FQuote({required this.onNavigate});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('"Education is the most powerful weapon which you can use to change the world."',
        style: TextStyle(fontSize: 11, color: AppTheme.textSecondary, fontFamily: 'Cairo', fontStyle: FontStyle.italic, height: 1.6)),
    const SizedBox(height: 5),
    const Text('— Nelson Mandela', style: TextStyle(fontSize: 10, color: AppTheme.textSecondary, fontFamily: 'Cairo', fontWeight: FontWeight.w600)),
    const SizedBox(height: 12),
    SizedBox(width: double.infinity, child: ElevatedButton(
      onPressed: () => onNavigate('/explore-tracks'),
      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, padding: const EdgeInsets.symmetric(vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      child: const Text('Start Learning', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
    )),
  ]);
}