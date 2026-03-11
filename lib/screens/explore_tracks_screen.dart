import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/track_models.dart';
import 'track_detail_screen.dart';

class ExploreTracksScreen extends StatefulWidget {
  final Function(String) onNavigate;
  const ExploreTracksScreen({super.key, required this.onNavigate});

  @override
  State<ExploreTracksScreen> createState() => _ExploreTracksScreenState();
}

class _ExploreTracksScreenState extends State<ExploreTracksScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<TrackModel> get _filtered => kSampleTracks
      .where((t) => t.title.toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openTrack(TrackModel track) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, anim, __) => TrackDetailScreen(
          track: track,
          onNavigate: widget.onNavigate,
        ),
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 280),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // ── Hero ──────────────────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF0EEFF), Color(0xFFF8F9FF)],
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'Learn',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textPrimary,
                    fontFamily: 'Cairo',
                    height: 1,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your Personalized Learning Dashboard',
                  style: TextStyle(
                    fontSize: 15,
                    color: AppTheme.textSecondary,
                    fontFamily: 'Cairo',
                  ),
                ),
                const SizedBox(height: 28),
                // Search bar
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primary.withOpacity(0.1),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (v) => setState(() => _searchQuery = v),
                            decoration: const InputDecoration(
                              hintText: 'search for courses, e.g. HTML',
                              hintStyle: TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 14,
                                fontFamily: 'Cairo',
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(4),
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: const Icon(
                            Icons.search_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Track list ───────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(20),
            child: _filtered.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 60),
                    child: Column(
                      children: [
                        Icon(Icons.search_off_rounded, size: 52, color: AppTheme.textSecondary),
                        SizedBox(height: 12),
                        Text('No courses found.', style: TextStyle(color: AppTheme.textSecondary, fontFamily: 'Cairo')),
                      ],
                    ),
                  )
                : Column(
                    children: _filtered
                        .map((track) => _TrackCard(track: track, onTap: () => _openTrack(track)))
                        .toList(),
                  ),
          ),

          // ── Footer ───────────────────────────────────────────────────────
          _ExploreFooter(onNavigate: widget.onNavigate),
        ],
      ),
    );
  }
}

// ─── Track Card ───────────────────────────────────────────────────────────────
class _TrackCard extends StatefulWidget {
  final TrackModel track;
  final VoidCallback onTap;
  const _TrackCard({required this.track, required this.onTap});

  @override
  State<_TrackCard> createState() => _TrackCardState();
}

class _TrackCardState extends State<_TrackCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered ? AppTheme.primary.withOpacity(0.4) : AppTheme.borderColor,
            ),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? AppTheme.primary.withOpacity(0.08)
                    : Colors.black.withOpacity(0.04),
                blurRadius: _hovered ? 20 : 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Level badge (top right)
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.bgLight,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppTheme.borderColor),
                      ),
                      child: const Icon(Icons.menu_book_rounded, color: AppTheme.primary, size: 22),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: _levelColor(widget.track.level).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: _levelColor(widget.track.level).withOpacity(0.3)),
                      ),
                      child: Text(
                        widget.track.level,
                        style: TextStyle(
                          color: _levelColor(widget.track.level),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  widget.track.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                    fontFamily: 'Cairo',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.track.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                    fontFamily: 'Cairo',
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: widget.onTap,
                    icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                    label: const Text('Start Learning'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Cairo'),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    '${widget.track.lessonsCount} lessons',
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _levelColor(String level) {
    switch (level.toLowerCase()) {
      case 'beginner': return AppTheme.accentGreen;
      case 'intermediate': return AppTheme.accentOrange;
      case 'advanced': return AppTheme.accent;
      default: return AppTheme.primary;
    }
  }
}

// ─── Footer ───────────────────────────────────────────────────────────────────
class _ExploreFooter extends StatelessWidget {
  final Function(String) onNavigate;
  const _ExploreFooter({required this.onNavigate});

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
                  _FooterBrand(),
                  const SizedBox(height: 24),
                  _FooterLinks(onNavigate: onNavigate),
                  const SizedBox(height: 24),
                  _FooterQuote(onNavigate: onNavigate),
                ])
              : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(child: _FooterBrand()),
                  Expanded(child: _FooterLinks(onNavigate: onNavigate)),
                  Expanded(child: _FooterQuote(onNavigate: onNavigate)),
                ]),
          const SizedBox(height: 24),
          const Divider(color: AppTheme.borderColor),
          const SizedBox(height: 12),
          const Text('© 2026 eduMaster. All rights reserved.',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 11, fontFamily: 'Cairo')),
        ],
      ),
    );
  }
}

class _FooterBrand extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RichText(text: const TextSpan(children: [
        TextSpan(text: 'EDU', style: TextStyle(color: AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.w800, fontFamily: 'Cairo')),
        TextSpan(text: 'MASTER', style: TextStyle(color: AppTheme.primary, fontSize: 18, fontWeight: FontWeight.w800, fontFamily: 'Cairo')),
        TextSpan(text: ' 🎓', style: TextStyle(fontSize: 16)),
      ])),
      const SizedBox(height: 8),
      const Text('Empowering learners for the future', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontFamily: 'Cairo')),
    ],
  );
}

class _FooterLinks extends StatelessWidget {
  final Function(String) onNavigate;
  const _FooterLinks({required this.onNavigate});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Follow us on', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.primary, fontFamily: 'Cairo')),
      const SizedBox(height: 12),
      ...[('Home', Icons.home_outlined, '/'), ('Dashboard', Icons.dashboard_outlined, '/dashboard'),
          ('Explore Tracks', Icons.explore_outlined, '/explore-tracks'), ('Test Yourself', Icons.quiz_outlined, '/test-yourself')]
          .map((l) => GestureDetector(
            onTap: () => onNavigate(l.$3),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(children: [
                Icon(l.$2, size: 16, color: AppTheme.textSecondary),
                const SizedBox(width: 8),
                Text(l.$1, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13, fontFamily: 'Cairo')),
              ]),
            ),
          )),
    ],
  );
}

class _FooterQuote extends StatelessWidget {
  final Function(String) onNavigate;
  const _FooterQuote({required this.onNavigate});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('"Education is the most powerful weapon which you can use to change the world."',
          style: TextStyle(fontSize: 12, color: AppTheme.textSecondary, fontFamily: 'Cairo', fontStyle: FontStyle.italic, height: 1.6)),
      const SizedBox(height: 6),
      const Text('— Nelson Mandela', style: TextStyle(fontSize: 11, color: AppTheme.textSecondary, fontFamily: 'Cairo', fontWeight: FontWeight.w600)),
      const SizedBox(height: 14),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => onNavigate('/explore-tracks'),
          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          child: const Text('Start Learning', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
        ),
      ),
    ],
  );
}