import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TestYourselfScreen extends StatefulWidget {
  final Function(String) onNavigate;
  const TestYourselfScreen({super.key, required this.onNavigate});

  @override
  State<TestYourselfScreen> createState() => _TestYourselfScreenState();
}

class _TestYourselfScreenState extends State<TestYourselfScreen> {
  int _activeTab = 0;
  String? _uploadedFileName;

  void _setTab(int i) => setState(() => _activeTab = i);

  void _onFileUploaded(String name) => setState(() => _uploadedFileName = name);
  void _clearFile() => setState(() => _uploadedFileName = null);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: isMobile
          ? Column(children: [
              _UploadCard(fileName: _uploadedFileName, onUploaded: _onFileUploaded, onClear: _clearFile),
              const SizedBox(height: 16),
              _MainPanel(activeTab: _activeTab, onTabChange: _setTab, fileName: _uploadedFileName),
              const SizedBox(height: 20),
              _TestFooter(onNavigate: widget.onNavigate),
            ])
          : Column(children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(width: 260, child: _UploadCard(fileName: _uploadedFileName, onUploaded: _onFileUploaded, onClear: _clearFile)),
                const SizedBox(width: 20),
                Expanded(child: _MainPanel(activeTab: _activeTab, onTabChange: _setTab, fileName: _uploadedFileName)),
              ]),
              const SizedBox(height: 24),
              _TestFooter(onNavigate: widget.onNavigate),
            ]),
    );
  }
}

// ─── Upload Card ──────────────────────────────────────────────────────────────
class _UploadCard extends StatelessWidget {
  final String? fileName;
  final Function(String) onUploaded;
  final VoidCallback onClear;

  const _UploadCard({required this.fileName, required this.onUploaded, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('🎓', style: TextStyle(fontSize: 28)),
          const SizedBox(height: 6),
          const Text('Upload Document', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.textPrimary, fontFamily: 'Cairo')),
          const SizedBox(height: 14),

          // File picker button
          GestureDetector(
            onTap: () => onUploaded('Lecture_02_Fundamentals.pdf'),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppTheme.bgLight,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: Text(
                fileName != null ? 'Choose file  ${_truncate(fileName!)}' : 'Choose File  No file chosen',
                style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary, fontFamily: 'Cairo'),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          // Uploaded badge
          if (fileName != null) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.accentGreen.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.accentGreen.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    const Icon(Icons.check_box_rounded, color: AppTheme.accentGreen, size: 16),
                    const SizedBox(width: 6),
                    Expanded(child: Text(fileName!, style: const TextStyle(fontSize: 11, color: AppTheme.accentGreen, fontFamily: 'Cairo', fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
                  ]),
                  const SizedBox(height: 4),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const Text('ready for quiz generation', style: TextStyle(fontSize: 10, color: AppTheme.accentGreen, fontFamily: 'Cairo')),
                    GestureDetector(onTap: onClear, child: const Text('Clear', style: TextStyle(fontSize: 10, color: AppTheme.accent, fontFamily: 'Cairo', fontWeight: FontWeight.w700))),
                  ]),
                ],
              ),
            ),
          ],

          const SizedBox(height: 12),
          const Text('Powers AI Chat + Quiz Generator', style: TextStyle(fontSize: 11, color: AppTheme.textSecondary, fontFamily: 'Cairo')),
        ],
      ),
    );
  }

  String _truncate(String s) => s.length > 18 ? '${s.substring(0, 15)}...' : s;
}

// ─── Main Panel ───────────────────────────────────────────────────────────────
class _MainPanel extends StatelessWidget {
  final int activeTab;
  final Function(int) onTabChange;
  final String? fileName;

  const _MainPanel({required this.activeTab, required this.onTabChange, required this.fileName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          // Tab bar
          _TabBar(activeTab: activeTab, onTabChange: onTabChange),

          // Content with animation
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) => FadeTransition(
              opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero)
                    .animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
                child: child,
              ),
            ),
            child: KeyedSubtree(
              key: ValueKey(activeTab),
              child: activeTab == 0
                  ? _ChatTab()
                  : activeTab == 1
                      ? _QuizGeneratorTab(fileName: fileName)
                      : _TakeQuizTab(fileName: fileName),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Tab Bar ──────────────────────────────────────────────────────────────────
class _TabBar extends StatelessWidget {
  final int activeTab;
  final Function(int) onTabChange;

  const _TabBar({required this.activeTab, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    final tabs = ['Chat & Summary', 'Quiz Generator', 'Take Quiz'];
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.borderColor)),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        children: tabs.asMap().entries.map((e) {
          final isActive = e.key == activeTab;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabChange(e.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: isActive ? AppTheme.primary : Colors.transparent,
                  borderRadius: e.key == 0
                      ? const BorderRadius.only(topLeft: Radius.circular(15))
                      : e.key == 2
                          ? const BorderRadius.only(topRight: Radius.circular(15))
                          : BorderRadius.zero,
                ),
                child: Text(
                  e.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    color: isActive ? Colors.white : AppTheme.textSecondary,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─── Chat Tab ─────────────────────────────────────────────────────────────────
class _ChatTab extends StatefulWidget {
  @override
  State<_ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<_ChatTab> {
  final TextEditingController _ctrl = TextEditingController();
  final ScrollController _scroll = ScrollController();
  final List<Map<String, String>> _messages = [
    {'role': 'ai', 'text': 'Hello! How can I assist you with your code today?'},
  ];

  void _send() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add({'role': 'user', 'text': text});
      _ctrl.clear();
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() => _messages.add({'role': 'ai', 'text': 'I received your message: "$text". Upload a document first so I can help you better!'}));
        Future.delayed(const Duration(milliseconds: 100), () {
          if (_scroll.hasClients) _scroll.animateTo(_scroll.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 8),
          const Text('🤖  AI Chat & Document Summary', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppTheme.textPrimary, fontFamily: 'Cairo')),
          const SizedBox(height: 16),

          // Messages area
          Container(
            height: 340,
            decoration: BoxDecoration(
              color: AppTheme.bgLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.all(14),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final msg = _messages[i];
                final isAi = msg['role'] == 'ai';
                return Align(
                  alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
                    decoration: BoxDecoration(
                      color: isAi ? Colors.white : AppTheme.primary,
                      borderRadius: BorderRadius.circular(12),
                      border: isAi ? Border.all(color: AppTheme.borderColor) : null,
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
                    ),
                    child: Text(
                      msg['text']!,
                      style: TextStyle(fontSize: 13, color: isAi ? AppTheme.textPrimary : Colors.white, fontFamily: 'Cairo', height: 1.5),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // Input bar
          Container(
            decoration: BoxDecoration(
              color: AppTheme.bgLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    onSubmitted: (_) => _send(),
                    decoration: const InputDecoration(
                      hintText: 'Send a message...',
                      hintStyle: TextStyle(color: AppTheme.textSecondary, fontSize: 13, fontFamily: 'Cairo'),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: ElevatedButton(
                    onPressed: _send,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Send', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ─── Quiz Generator Tab ───────────────────────────────────────────────────────
class _QuizGeneratorTab extends StatefulWidget {
  final String? fileName;
  const _QuizGeneratorTab({required this.fileName});

  @override
  State<_QuizGeneratorTab> createState() => _QuizGeneratorTabState();
}

class _QuizGeneratorTabState extends State<_QuizGeneratorTab> {
  String _questionType = 'mcq';
  int _questionCount = 5;
  int _timeLimit = 30;

  String get _typeLabel {
    switch (_questionType) {
      case 'mcq': return 'MCQ';
      case 'truefalse': return 'True/False';
      default: return 'Mix';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 8),
          const Text('🎯  Quiz Generator', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppTheme.textPrimary, fontFamily: 'Cairo')),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.bgLight,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Column(
              children: [
                const Text('🎯', style: TextStyle(fontSize: 36)),
                const SizedBox(height: 8),
                const Text('Quiz Generator', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.textPrimary, fontFamily: 'Cairo')),
                const SizedBox(height: 4),
                const Text('Create quizzes from your uploaded document', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary, fontFamily: 'Cairo')),
                const SizedBox(height: 20),

                // No file warning
                if (widget.fileName == null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFBEB),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFFBBF24).withOpacity(0.5)),
                    ),
                    child: Column(children: [
                      const Text('📤', style: TextStyle(fontSize: 28)),
                      const SizedBox(height: 6),
                      const Text('No file uploaded', style: TextStyle(color: Color(0xFFB45309), fontWeight: FontWeight.w700, fontFamily: 'Cairo')),
                      const Text('Upload a PDF using the sidebar first', style: TextStyle(color: Color(0xFFB45309), fontSize: 12, fontFamily: 'Cairo')),
                    ]),
                  ),

                if (widget.fileName != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.accentGreen.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppTheme.accentGreen.withOpacity(0.3)),
                    ),
                    child: Row(children: [
                      const Icon(Icons.check_circle_rounded, color: AppTheme.accentGreen, size: 18),
                      const SizedBox(width: 8),
                      Expanded(child: Text(widget.fileName!, style: const TextStyle(color: AppTheme.accentGreen, fontFamily: 'Cairo', fontWeight: FontWeight.w600, fontSize: 13))),
                    ]),
                  ),

                const SizedBox(height: 20),

                // Question type
                Row(children: [
                  Expanded(child: _FormField(
                    label: '📋  Question Type',
                    child: _TypeSelector(value: _questionType, onChanged: (v) => setState(() => _questionType = v)),
                  )),
                  const SizedBox(width: 14),
                  Expanded(child: _FormField(
                    label: '🔢  Questions (1-20)',
                    child: _NumberInput(value: _questionCount, min: 1, max: 20, onChanged: (v) => setState(() => _questionCount = v)),
                  )),
                ]),
                const SizedBox(height: 14),

                // Time limit
                _FormField(
                  label: '⏱  Time Limit (minutes)',
                  child: _NumberInput(value: _timeLimit, min: 5, max: 120, onChanged: (v) => setState(() => _timeLimit = v)),
                ),
                const SizedBox(height: 20),

                // Generate button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: widget.fileName != null ? () {} : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary.withOpacity(0.85),
                      disabledBackgroundColor: AppTheme.primary.withOpacity(0.4),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      '✨  Generate $_questionCount $_typeLabel Questions',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Cairo'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final Widget child;
  const _FormField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textSecondary, fontFamily: 'Cairo')),
      const SizedBox(height: 6),
      child,
    ],
  );
}

class _TypeSelector extends StatelessWidget {
  final String value;
  final Function(String) onChanged;
  const _TypeSelector({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          style: const TextStyle(fontSize: 13, color: AppTheme.textPrimary, fontFamily: 'Cairo'),
          items: const [
            DropdownMenuItem(value: 'mcq', child: Text('Multiple Choice (4 options)')),
            DropdownMenuItem(value: 'truefalse', child: Text('True & False')),
            DropdownMenuItem(value: 'mix', child: Text('Mix (MCQ + T/F)')),
          ],
          onChanged: (v) => onChanged(v!),
        ),
      ),
    );
  }
}

class _NumberInput extends StatelessWidget {
  final int value, min, max;
  final Function(int) onChanged;
  const _NumberInput({required this.value, required this.min, required this.max, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.remove_rounded, size: 16), onPressed: value > min ? () => onChanged(value - 1) : null, color: AppTheme.textSecondary),
          Expanded(child: Text('$value', textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Cairo'))),
          IconButton(icon: const Icon(Icons.add_rounded, size: 16), onPressed: value < max ? () => onChanged(value + 1) : null, color: AppTheme.textSecondary),
        ],
      ),
    );
  }
}

// ─── Take Quiz Tab ────────────────────────────────────────────────────────────
class _TakeQuizTab extends StatefulWidget {
  final String? fileName;
  const _TakeQuizTab({required this.fileName});

  @override
  State<_TakeQuizTab> createState() => _TakeQuizTabState();
}

class _TakeQuizTabState extends State<_TakeQuizTab> {
  int _current = 0;
  int? _selected;
  bool _answered = false;
  final Map<int, int> _answers = {};

  final List<Map<String, dynamic>> _questions = [
    {'q': 'What is the definition of a robot according to the given text?', 'opts': ['A) A human-made machine that can think', 'B) An artificial physical agent that performs tasks by manipulating the physical world', 'C) A computer program that can learn', 'D) A device that can only perform repetitive tasks'], 'correct': 1},
    {'q': 'Which of the following best describes machine learning?', 'opts': ['A) Programming rules manually', 'B) Systems that learn from data', 'C) Hardware components of a robot', 'D) A type of database'], 'correct': 1},
    {'q': 'What does AI stand for?', 'opts': ['A) Automated Integration', 'B) Artificial Intelligence', 'C) Algorithmic Information', 'D) Applied Informatics'], 'correct': 1},
    {'q': 'Which technology allows computers to understand human language?', 'opts': ['A) Computer Vision', 'B) Robotics', 'C) Natural Language Processing', 'D) Data Mining'], 'correct': 2},
    {'q': 'What is the main purpose of a neural network?', 'opts': ['A) Store data', 'B) Connect to the internet', 'C) Mimic the human brain to learn patterns', 'D) Manage files'], 'correct': 2},
  ];

  void _selectAnswer(int i) {
    if (_answered) return;
    setState(() { _selected = i; _answered = true; _answers[_current] = i; });
  }

  void _next() {
    if (_current < _questions.length - 1) {
      setState(() { _current++; _selected = _answers[_current]; _answered = _answers.containsKey(_current); });
    }
  }

  void _prev() {
    if (_current > 0) {
      setState(() { _current--; _selected = _answers[_current]; _answered = _answers.containsKey(_current); });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fileName == null) {
      return Padding(
        padding: const EdgeInsets.all(40),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('📋', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          const Text('Take Your Quiz', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.textPrimary, fontFamily: 'Cairo')),
          const SizedBox(height: 8),
          const Text('Upload a document and generate a quiz first', style: TextStyle(color: AppTheme.textSecondary, fontFamily: 'Cairo', fontSize: 13)),
        ]),
      );
    }

    final q = _questions[_current];
    final opts = q['opts'] as List<String>;
    final correct = q['correct'] as int;
    final labels = ['A', 'B', 'C', 'D'];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('📋  Take Your Quiz', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppTheme.textPrimary, fontFamily: 'Cairo')),
          const SizedBox(height: 16),

          // Progress
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('${_answers.length}/${_questions.length}', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontFamily: 'Cairo')),
          ]),
          const SizedBox(height: 8),

          // Question number
          Row(children: [
            Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle)),
            const SizedBox(width: 8),
            Text('Question ${_current + 1} of ${_questions.length}',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.textPrimary, fontFamily: 'Cairo')),
          ]),
          const SizedBox(height: 16),

          // Question text
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Container(
              key: ValueKey(_current),
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.bgLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: Text(q['q'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textPrimary, fontFamily: 'Cairo', height: 1.5)),
            ),
          ),
          const SizedBox(height: 14),

          // Options
          ...opts.asMap().entries.map((e) {
            final isSelected = _selected == e.key;
            final isCorrect = e.key == correct;
            Color bg = AppTheme.bgLight;
            Color border = AppTheme.borderColor;
            Color textColor = AppTheme.textPrimary;

            if (_answered) {
              if (isCorrect) { bg = AppTheme.accentGreen.withOpacity(0.1); border = AppTheme.accentGreen; textColor = AppTheme.accentGreen; }
              else if (isSelected) { bg = AppTheme.accent.withOpacity(0.1); border = AppTheme.accent; textColor = AppTheme.accent; }
            } else if (isSelected) {
              bg = AppTheme.primary.withOpacity(0.08); border = AppTheme.primary; textColor = AppTheme.primary;
            }

            return GestureDetector(
              onTap: () => _selectAnswer(e.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10), border: Border.all(color: border)),
                child: Row(children: [
                  Container(
                    width: 28, height: 28,
                    decoration: BoxDecoration(
                      color: isSelected || (_answered && isCorrect) ? AppTheme.primary : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: border),
                    ),
                    child: Center(child: Text(labels[e.key], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: isSelected || (_answered && isCorrect) ? Colors.white : AppTheme.textSecondary, fontFamily: 'Cairo'))),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(e.value, style: TextStyle(fontSize: 13, color: textColor, fontFamily: 'Cairo'))),
                  if (_answered && isCorrect) const Icon(Icons.check_circle_rounded, color: AppTheme.accentGreen, size: 18),
                  if (_answered && isSelected && !isCorrect) const Icon(Icons.cancel_rounded, color: AppTheme.accent, size: 18),
                ]),
              ),
            );
          }),

          const SizedBox(height: 8),
          const Divider(color: AppTheme.borderColor),
          const SizedBox(height: 8),

          // Navigation
          Row(children: [
            OutlinedButton(
              onPressed: _current > 0 ? _prev : null,
              style: OutlinedButton.styleFrom(foregroundColor: AppTheme.textSecondary, side: const BorderSide(color: AppTheme.borderColor), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
              child: const Text('Previous', style: TextStyle(fontFamily: 'Cairo')),
            ),
            Expanded(child: Center(child: Text(_answered ? '' : 'Answer to continue', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontFamily: 'Cairo')))),
            ElevatedButton(
              onPressed: _answered && _current < _questions.length - 1 ? _next : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                disabledBackgroundColor: AppTheme.borderColor,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text('Next', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w700)),
            ),
          ]),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ─── Footer ───────────────────────────────────────────────────────────────────
class _TestFooter extends StatelessWidget {
  final Function(String) onNavigate;
  const _TestFooter({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(color: const Color(0xFFF1F0FF), borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.borderColor)),
      child: Column(children: [
        isMobile
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_FB(), const SizedBox(height: 20), _FL(onNavigate: onNavigate), const SizedBox(height: 20), _FQ(onNavigate: onNavigate)])
            : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: _FB()), Expanded(child: _FL(onNavigate: onNavigate)), Expanded(child: _FQ(onNavigate: onNavigate))]),
        const SizedBox(height: 20), const Divider(color: AppTheme.borderColor), const SizedBox(height: 10),
        const Text('© 2026 eduMaster. All rights reserved.', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11, fontFamily: 'Cairo')),
      ]),
    );
  }
}

class _FB extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    RichText(text: const TextSpan(children: [
      TextSpan(text: 'EDU', style: TextStyle(color: AppTheme.textPrimary, fontSize: 16, fontWeight: FontWeight.w800, fontFamily: 'Cairo')),
      TextSpan(text: 'MASTER', style: TextStyle(color: AppTheme.primary, fontSize: 16, fontWeight: FontWeight.w800, fontFamily: 'Cairo')),
      TextSpan(text: ' 🎓', style: TextStyle(fontSize: 14)),
    ])),
    const SizedBox(height: 6),
    const Text('Empowering learners for the future', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontFamily: 'Cairo')),
  ]);
}

class _FL extends StatelessWidget {
  final Function(String) onNavigate;
  const _FL({required this.onNavigate});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('Follow us on', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.primary, fontFamily: 'Cairo')),
    const SizedBox(height: 10),
    ...[('Home', Icons.home_outlined, '/'), ('Dashboard', Icons.dashboard_outlined, '/dashboard'),
        ('Explore Tracks', Icons.explore_outlined, '/explore-tracks'), ('Test Yourself', Icons.quiz_outlined, '/test-yourself')]
        .map((l) => GestureDetector(onTap: () => onNavigate(l.$3), child: Padding(padding: const EdgeInsets.only(bottom: 7),
          child: Row(children: [Icon(l.$2, size: 14, color: AppTheme.textSecondary), const SizedBox(width: 7), Text(l.$1, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontFamily: 'Cairo'))])))),
  ]);
}

class _FQ extends StatelessWidget {
  final Function(String) onNavigate;
  const _FQ({required this.onNavigate});
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