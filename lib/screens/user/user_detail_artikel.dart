import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'user_artikel.dart';
import 'user_pencarian.dart';

const Color _dTealMain = Color(0xFF5DCFCF);
const Color _dTeal = Color(0xFF76EAD0);
const Color _dBlue = Color(0xFF76D7EA);
const Color _dLGreen = Color(0xFFD0FF99);

// ─── Dummy article body content per category ──────────────────────────────────
String _getDummyContent(ArticleItem article) {
  return '''
${article.title}

Growing and caring for plants at home can be one of the most rewarding hobbies. Whether you're a complete beginner or have some experience, understanding the basics of plant care will help your ${article.category.toLowerCase()} thrive in any environment.

Getting Started

Every plant has its own unique requirements when it comes to light, water, and soil. The key is to observe your plant regularly and adjust your care routine based on how it responds.

For ${article.category} like the ones covered in this guide, you'll want to start by choosing the right location. Most plants prefer bright, indirect light — near a window but not in direct afternoon sun.

Watering Guidelines

Overwatering is one of the most common mistakes beginners make. Always check the soil moisture before watering. Stick your finger about 2 cm into the soil — if it feels dry, it's time to water. If it still feels moist, wait another day or two.

Water your plants thoroughly until it drains from the bottom, then empty the saucer to prevent root rot.

Soil & Fertilization

Use well-draining potting mix appropriate for your plant type. A general-purpose mix works well for most indoor and outdoor plants. During the growing season (spring and summer), feed your plants with a balanced liquid fertilizer every 2–4 weeks.

Common Problems & Solutions

• Yellowing leaves — Usually a sign of overwatering or lack of nutrients. Check your watering schedule and consider adding fertilizer.

• Brown leaf tips — Often caused by low humidity or fluoride in tap water. Try misting the leaves or using filtered water.

• Wilting — Can indicate underwatering or root rot. Check the soil and inspect the roots if necessary.

• Pest infestations — Inspect leaves regularly for pests like aphids or spider mites. Treat early with neem oil or insecticidal soap.

Pro Tips from Our Experts

"The best plant parents are observant plant parents. Take a few minutes each week to really look at your plants — new growth is a great sign, while dropping leaves or color changes usually signal something needs attention." — ${article.author}

Remember, every plant is different and it may take some time to learn what your specific plant needs. Don't be discouraged by early setbacks. With patience and attention, your plants will flourish.

About Sproutly

Sproutly connects you with certified botanist experts who specialize in home and garden plants, including ornamental plants, vegetables, fruit trees in pots, and culinary herbs. Our experts are available for one-on-one consultations to help you solve plant problems and improve your growing skills.
''';
}

class UserDetailArtikelScreen extends StatefulWidget {
  final ArticleItem article;

  const UserDetailArtikelScreen({super.key, required this.article});

  @override
  State<UserDetailArtikelScreen> createState() =>
      _UserDetailArtikelScreenState();
}

class _UserDetailArtikelScreenState extends State<UserDetailArtikelScreen> {
  bool get _isBookmarked => globalBookmarkedIds.contains(widget.article.id);

  void _toggleBookmark() {
    setState(() {
      if (_isBookmarked) {
        globalBookmarkedIds.remove(widget.article.id);
        widget.article.isBookmarked = false;
      } else {
        globalBookmarkedIds.add(widget.article.id);
        widget.article.isBookmarked = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: _dTeal.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.article.category,
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _dTealMain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Title
                  Text(
                    widget.article.title,
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Author row
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: _dTeal.withOpacity(0.3),
                        child: Text(
                          widget.article.author[0],
                          style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w700,
                              color: _dTealMain,
                              fontSize: 14),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.article.author,
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            widget.article.time,
                            style: GoogleFonts.outfit(
                                fontSize: 11, color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Divider
                  Divider(color: Colors.grey.shade200, thickness: 1),
                  const SizedBox(height: 16),

                  // Article body
                  Text(
                    _getDummyContent(widget.article),
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.75,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // CTA — Consult with expert
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFD0FF99), Color(0xFF99FF99)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Need personalized advice?',
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Chat directly with a certified botanist expert for your specific plant problems.',
                          style: GoogleFonts.outfit(
                              fontSize: 12, color: Colors.black54, height: 1.5),
                        ),
                        const SizedBox(height: 14),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const UserPencarianScreen()),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 11),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              'Start Consultation',
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 260,
      pinned: true,
      backgroundColor: _dTealMain,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 16),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: _toggleBookmark,
          child: Container(
            margin: const EdgeInsets.all(8),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _isBookmarked ? _dTealMain : Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _isBookmarked
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_outline_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              widget.article.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (ctx, child, progress) {
                if (progress == null) return child;
                return Container(
                  color: _dTeal.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: _dTealMain),
                  ),
                );
              },
              errorBuilder: (_, __, ___) => Container(
                color: _dLGreen.withOpacity(0.3),
                child: Icon(Icons.eco_rounded,
                    color: Colors.green.shade300, size: 48),
              ),
            ),
            // Gradient overlay at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.35),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
