import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/track_models.dart';

class LessonScreen extends StatefulWidget {
  final TrackModel track;
  final LessonModel lesson;
  final Function(String) onNavigate;

  const LessonScreen({
    super.key,
    required this.track,
    required this.lesson,
    required this.onNavigate,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  late LessonModel _currentLesson;
  bool _sidebarOpen = true;

  @override
  void initState() {
    super.initState();
    _currentLesson = widget.lesson;
  }

  void _switchLesson(LessonModel lesson) {
    setState(() => _currentLesson = lesson);
  }

  LessonModel? get _prevLesson {
    final idx = widget.track.lessons.indexOf(_currentLesson);
    return idx > 0 ? widget.track.lessons[idx - 1] : null;
  }

  LessonModel? get _nextLesson {
    final idx = widget.track.lessons.indexOf(_currentLesson);
    return idx < widget.track.lessons.length - 1 ? widget.track.lessons[idx + 1] : null;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: Column(
        children: [
          // ── Top bar ─────────────────────────────────────────────────────
          _LessonTopBar(
            track: widget.track,
            currentLesson: _currentLesson,
            sidebarOpen: _sidebarOpen,
            isMobile: isMobile,
            onToggleSidebar: () => setState(() => _sidebarOpen = !_sidebarOpen),
            onBack: () => Navigator.pop(context),
          ),

          // ── Body ─────────────────────────────────────────────────────────
          Expanded(
            child: isMobile
                ? _buildMobileBody()
                : _buildDesktopBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopBody() {
    return Row(
      children: [
        // Sidebar
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: _sidebarOpen ? 240 : 0,
          child: _sidebarOpen
              ? _LessonSidebar(
                  track: widget.track,
                  currentLesson: _currentLesson,
                  onSelect: _switchLesson,
                )
              : const SizedBox(),
        ),
        // Content
        Expanded(
          child: _LessonContent(
            lesson: _currentLesson,
            prev: _prevLesson,
            next: _nextLesson,
            onSwitch: _switchLesson,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileBody() {
    return Stack(
      children: [
        _LessonContent(
          lesson: _currentLesson,
          prev: _prevLesson,
          next: _nextLesson,
          onSwitch: _switchLesson,
        ),
        if (_sidebarOpen)
          GestureDetector(
            onTap: () => setState(() => _sidebarOpen = false),
            child: Container(color: Colors.black54),
          ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          left: _sidebarOpen ? 0 : -260,
          top: 0, bottom: 0,
          width: 250,
          child: _LessonSidebar(
            track: widget.track,
            currentLesson: _currentLesson,
            onSelect: (l) {
              _switchLesson(l);
              setState(() => _sidebarOpen = false);
            },
          ),
        ),
      ],
    );
  }
}

// ─── Top Bar ──────────────────────────────────────────────────────────────────
class _LessonTopBar extends StatelessWidget {
  final TrackModel track;
  final LessonModel currentLesson;
  final bool sidebarOpen, isMobile;
  final VoidCallback onToggleSidebar, onBack;

  const _LessonTopBar({
    required this.track,
    required this.currentLesson,
    required this.sidebarOpen,
    required this.isMobile,
    required this.onToggleSidebar,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF16213E),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white70, size: 18),
              onPressed: onBack,
              tooltip: 'Back to track',
            ),
            IconButton(
              icon: Icon(sidebarOpen ? Icons.menu_open_rounded : Icons.menu_rounded, color: Colors.white70),
              onPressed: onToggleSidebar,
              tooltip: 'Toggle lessons',
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                currentLesson.title,
                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Cairo'),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Progress indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.accentGreen.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.accentGreen.withOpacity(0.4)),
              ),
              child: const Text('In Progress', style: TextStyle(color: AppTheme.accentGreen, fontSize: 11, fontFamily: 'Cairo', fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Lesson Sidebar ───────────────────────────────────────────────────────────
class _LessonSidebar extends StatelessWidget {
  final TrackModel track;
  final LessonModel currentLesson;
  final Function(LessonModel) onSelect;

  const _LessonSidebar({required this.track, required this.currentLesson, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0F0F23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              track.title,
              style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 11, fontFamily: 'Cairo', fontWeight: FontWeight.w600, letterSpacing: 0.5),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Divider(color: Colors.white12),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: track.lessons.length,
              itemBuilder: (context, i) {
                final lesson = track.lessons[i];
                final isActive = lesson.id == currentLesson.id;
                return GestureDetector(
                  onTap: () => onSelect(lesson),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: isActive ? AppTheme.primary.withOpacity(0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: isActive ? Border.all(color: AppTheme.primary.withOpacity(0.4)) : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 22, height: 22,
                          decoration: BoxDecoration(
                            color: isActive ? AppTheme.primary : Colors.white12,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${i + 1}',
                              style: TextStyle(color: isActive ? Colors.white : Colors.white38, fontSize: 10, fontWeight: FontWeight.w700, fontFamily: 'Cairo'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            lesson.title,
                            style: TextStyle(
                              color: isActive ? Colors.white : Colors.white60,
                              fontSize: 13,
                              fontFamily: 'Cairo',
                              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Lesson Content ───────────────────────────────────────────────────────────
class _LessonContent extends StatelessWidget {
  final LessonModel lesson;
  final LessonModel? prev, next;
  final Function(LessonModel) onSwitch;

  const _LessonContent({required this.lesson, required this.prev, required this.next, required this.onSwitch});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E1E3A),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Nav buttons ──────────────────────────────────────────────
            Row(
              children: [
                if (prev != null)
                  OutlinedButton.icon(
                    onPressed: () => onSwitch(prev!),
                    icon: const Icon(Icons.arrow_back_rounded, size: 16),
                    label: const Text('Previous Lesson'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white70,
                      side: const BorderSide(color: Colors.white24),
                      textStyle: const TextStyle(fontSize: 12, fontFamily: 'Cairo'),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    ),
                  ),
                const Spacer(),
                if (next != null)
                  ElevatedButton.icon(
                    onPressed: () => onSwitch(next!),
                    icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                    label: const Text('Next Lesson'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      textStyle: const TextStyle(fontSize: 12, fontFamily: 'Cairo'),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),

            // ── Content ──────────────────────────────────────────────────
            _MarkdownRenderer(content: lesson.content),

            const SizedBox(height: 40),

            // ── Lesson Quiz ──────────────────────────────────────────────
            _LessonQuiz(quiz: lesson.quiz),
          ],
        ),
      ),
    );
  }
}

// ─── Simple Markdown Renderer ─────────────────────────────────────────────────
class _MarkdownRenderer extends StatelessWidget {
  final String content;
  const _MarkdownRenderer({required this.content});

  @override
  Widget build(BuildContext context) {
    final lines = content.split('\n');
    final widgets = <Widget>[];

    for (final line in lines) {
      if (line.startsWith('# ')) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(bottom: 16, top: 8),
          child: Text(line.substring(2), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white, fontFamily: 'Cairo')),
        ));
      } else if (line.startsWith('## ')) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 20),
          child: Text(line.substring(3), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'Cairo')),
        ));
      } else if (line.startsWith('```')) {
        // skip fence markers
      } else if (line.startsWith('**') && line.endsWith('**')) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(bottom: 6, top: 10),
          child: Text(
            line.replaceAll('**', ''),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'Cairo'),
          ),
        ));
      } else if (line.trim().isEmpty) {
        widgets.add(const SizedBox(height: 6));
      } else if (line.startsWith('    ') || line.contains('{') || line.contains('<')) {
        // Code block
        widgets.add(Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF0D0D1A),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white12),
          ),
          child: Text(
            line,
            style: const TextStyle(color: Color(0xFF82AAFF), fontSize: 13, fontFamily: 'monospace', height: 1.5),
          ),
        ));
      } else {
        widgets.add(Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(line, style: const TextStyle(fontSize: 14, color: Colors.white70, fontFamily: 'Cairo', height: 1.7)),
        ));
      }
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }
}

// ─── Lesson Quiz ──────────────────────────────────────────────────────────────
class _LessonQuiz extends StatefulWidget {
  final List<QuizQuestion> quiz;
  const _LessonQuiz({required this.quiz});

  @override
  State<_LessonQuiz> createState() => _LessonQuizState();
}

class _LessonQuizState extends State<_LessonQuiz> {
  final Map<int, int> _answers = {};
  bool _submitted = false;

  int get _score => _answers.entries
      .where((e) => e.value == widget.quiz[e.key].correctIndex)
      .length;

  @override
  Widget build(BuildContext context) {
    if (widget.quiz.isEmpty) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.quiz_rounded, color: AppTheme.primary, size: 22),
              SizedBox(width: 10),
              Text('Lesson Quiz', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white, fontFamily: 'Cairo')),
            ],
          ),
          const SizedBox(height: 20),
          ...widget.quiz.asMap().entries.map((e) => _QuizItem(
            index: e.key,
            question: e.value,
            selectedIndex: _answers[e.key],
            submitted: _submitted,
            onSelect: _submitted ? null : (i) => setState(() => _answers[e.key] = i),
          )),
          const SizedBox(height: 16),
          if (!_submitted)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _answers.length == widget.quiz.length
                    ? () => setState(() => _submitted = true)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentGreen,
                  disabledBackgroundColor: Colors.white12,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Submit Quiz', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Cairo')),
              ),
            )
          else
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _score >= widget.quiz.length / 2 ? AppTheme.accentGreen.withOpacity(0.15) : AppTheme.accent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _score >= widget.quiz.length / 2 ? AppTheme.accentGreen.withOpacity(0.4) : AppTheme.accent.withOpacity(0.4),
                ),
              ),
              child: Column(children: [
                Text(
                  _score >= widget.quiz.length / 2 ? '🎉 Well Done!' : '📚 Keep Practicing!',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white, fontFamily: 'Cairo'),
                ),
                const SizedBox(height: 6),
                Text(
                  'You scored $_score / ${widget.quiz.length}',
                  style: const TextStyle(fontSize: 14, color: Colors.white70, fontFamily: 'Cairo'),
                ),
              ]),
            ),
        ],
      ),
    );
  }
}

class _QuizItem extends StatelessWidget {
  final int index;
  final QuizQuestion question;
  final int? selectedIndex;
  final bool submitted;
  final Function(int)? onSelect;

  const _QuizItem({
    required this.index,
    required this.question,
    required this.selectedIndex,
    required this.submitted,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Q${index + 1}. ${question.question}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'Cairo'),
          ),
          const SizedBox(height: 10),
          ...question.options.asMap().entries.map((e) {
            final isSelected = selectedIndex == e.key;
            final isCorrect = e.key == question.correctIndex;

            Color bgColor = Colors.white.withOpacity(0.04);
            Color borderColor = Colors.white12;
            Color textColor = Colors.white70;

            if (submitted) {
              if (isCorrect) {
                bgColor = AppTheme.accentGreen.withOpacity(0.15);
                borderColor = AppTheme.accentGreen.withOpacity(0.5);
                textColor = AppTheme.accentGreen;
              } else if (isSelected && !isCorrect) {
                bgColor = AppTheme.accent.withOpacity(0.15);
                borderColor = AppTheme.accent.withOpacity(0.5);
                textColor = AppTheme.accent;
              }
            } else if (isSelected) {
              bgColor = AppTheme.primary.withOpacity(0.15);
              borderColor = AppTheme.primary.withOpacity(0.5);
              textColor = Colors.white;
            }

            return GestureDetector(
              onTap: onSelect != null ? () => onSelect!(e.key) : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20, height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: isSelected ? AppTheme.primary : Colors.white24, width: 2),
                        color: isSelected ? AppTheme.primary : Colors.transparent,
                      ),
                      child: isSelected
                          ? const Icon(Icons.check_rounded, color: Colors.white, size: 13)
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text(e.value, style: TextStyle(color: textColor, fontSize: 13, fontFamily: 'Cairo'))),
                    if (submitted && isCorrect)
                      const Icon(Icons.check_circle_rounded, color: AppTheme.accentGreen, size: 16),
                    if (submitted && isSelected && !isCorrect)
                      const Icon(Icons.cancel_rounded, color: AppTheme.accent, size: 16),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}