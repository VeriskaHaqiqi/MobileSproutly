import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'user_pencarian.dart';
import 'user_artikel.dart';
import 'user_consult.dart';
import 'user_setting.dart';
import 'user_detail_artikel.dart';

// ─── Color Palette ────────────────────────────────────────────────────────────
const Color kYellow = Color(0xFFFFFF9F);
const Color kLightGreen = Color(0xFFD0FF99);
const Color kGreen = Color(0xFF99FF99);
const Color kTeal = Color(0xFF76EAD0);
const Color kBlue = Color(0xFF76D7EA);
const Color kScaffold = Color(0xFFF0F4F3);

// ─── Dummy Article Data ───────────────────────────────────────────────────────
final List<Map<String, String>> _allArticles = [
  {
    'category': 'Houseplants',
    'title': 'Essential Care Tips for Tropical Houseplants',
    'author': 'Dr. Emily Chen',
    'time': '2 days ago',
    'plants': 'monstera philodendron pothos snake plant calathea peace lily',
    'image':
        'https://images.unsplash.com/photo-1485955900006-10f4d324d411?auto=format&fit=crop&w=800&q=80',
  },
  {
    'category': 'Home Vegetables',
    'title': 'Optimizing Sunlight for Your Home Vegetable Garden',
    'author': 'Dr. Mark Lee',
    'time': '5 days ago',
    'plants': 'chili tomato eggplant spinach pak choi lettuce vegetable garden',
    'image':
        'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?auto=format&fit=crop&w=800&q=80',
  },
  {
    'category': 'Houseplants',
    'title': 'How to Keep Orchids Blooming All Year',
    'author': 'Dr. Sarah Lee',
    'time': '1 week ago',
    'plants': 'orchid orchids flowering plant indoor houseplant',
    'image':
        'https://images.unsplash.com/photo-1490750967868-88df5691cc5e?auto=format&fit=crop&w=800&q=80',
  },
  {
    'category': 'Plant Care',
    'title': 'Watering Schedule for Indoor Plants',
    'author': 'Dr. James Wilson',
    'time': '1 week ago',
    'plants': 'watering indoor plants cactus succulent zz plant snake plant',
    'image':
        'https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?auto=format&fit=crop&w=800&q=80',
  },
  {
    'category': 'Plant Health',
    'title': 'Common Plant Diseases and How to Treat Them',
    'author': 'Dr. Emily Chen',
    'time': '2 weeks ago',
    'plants': 'plant disease leaf spot root rot pest aglaonema calathea',
    'image':
        'https://images.unsplash.com/photo-1591857177580-dc82b9ac4e1e?auto=format&fit=crop&w=800&q=80',
  },
  {
    'category': 'Herbs & Kitchen Spices',
    'title': 'Growing Herbs in Small Spaces at Home',
    'author': 'Dr. Mark Lee',
    'time': '2 weeks ago',
    'plants': 'ginger turmeric lemongrass mint basil rosemary oregano herbs',
    'image':
        'https://images.unsplash.com/photo-1466692476868-aef1dfb1e735?auto=format&fit=crop&w=800&q=80',
  },
  {
    'category': 'Potted Fruit Plants',
    'title': "Beginner's Guide to Starting Potted Fruit Plants",
    'author': 'Dr. Sarah Lee',
    'time': '3 weeks ago',
    'plants':
        'orange lemon guava strawberry mango avocado dragon fruit potted fruit',
    'image':
        'https://images.unsplash.com/photo-1560493676-04071c5f467b?auto=format&fit=crop&w=800&q=80',
  },
];

// ─── Dummy Activity Data ──────────────────────────────────────────────────────
final List<Map<String, dynamic>> _activities = [
  {
    'icon': 'assets/consultation.png',
    'fallbackIcon': Icons.chat_bubble_outline,
    'title': 'Dr. James Wilson replied',
    'subtitle': 'Your orchid consultation has a new message',
    'time': '10 minutes ago',
    'color': kTeal,
  },
  {
    'icon': 'assets/reviews.png',
    'fallbackIcon': Icons.star_border,
    'title': 'Rate your last session',
    'subtitle': 'Share your experience with Dr. Sarah Lee',
    'time': '1 hour ago',
    'color': kYellow,
  },
  {
    'icon': 'assets/ikon manage schedule.png',
    'fallbackIcon': Icons.calendar_today_outlined,
    'title': 'Upcoming Consultation',
    'subtitle': 'Your session with Dr. Emily Chen starts tomorrow',
    'time': '3 hours ago',
    'color': kLightGreen,
  },
  {
    'icon': 'assets/payment.png',
    'fallbackIcon': Icons.payment_outlined,
    'title': 'Payment Confirmed',
    'subtitle': 'Your consultation payment has been received',
    'time': 'Yesterday',
    'color': kBlue,
  },
  {
    'icon': 'assets/article.png',
    'fallbackIcon': Icons.article_outlined,
    'title': 'New Article Available',
    'subtitle': 'Read the latest guide about indoor plant care',
    'time': '2 days ago',
    'color': kGreen,
  },
];

// ─── Home Screen ──────────────────────────────────────────────────────────────
class HomeUserScreen extends StatefulWidget {
  const HomeUserScreen({super.key});

  @override
  State<HomeUserScreen> createState() => _HomeUserScreenState();
}

class _HomeUserScreenState extends State<HomeUserScreen> {
  void _goToSearchConsultation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const UserPencarianScreen(),
      ),
    );
  }

  void _goToArticles() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const UserArtikelScreen(),
      ),
    );
  }

  void _goToConsultations() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const UserConsultScreen(),
      ),
    );
  }

  void _goToAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const UserSettingScreen(),
      ),
    );
  }

  void _goToArticleDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const UserDetailArtikelScreen(),
      ),
    );
  }

  void _onBottomNavTapped(int index) {
    if (index == 0) return;

    if (index == 1) {
      _goToArticles();
    } else if (index == 2) {
      _goToConsultations();
    } else if (index == 3) {
      _goToAccount();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffold,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          _buildGradientHeader(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildConsultationBanner(),
                  const SizedBox(height: 28),
                  _buildArticlesSection(),
                  const SizedBox(height: 28),
                  _buildRecentActivity(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildGradientHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kBlue, kTeal],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 22),
          child: _buildGreetingRow(),
        ),
      ),
    );
  }

  Widget _buildGreetingRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.white.withOpacity(0.88),
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Sarah Johnson',
              style: GoogleFonts.inter(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.notifications_outlined,
            color: Colors.white,
            size: 22,
          ),
        ),
      ],
    );
  }

  Widget _buildConsultationBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [kLightGreen, kGreen],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chat with Expert',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Get instant advice for houseplants,\nvegetables, fruits, and herbs.',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _goToSearchConsultation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Start Consultation',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.55),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/vector.png',
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) {
                    return Image.asset(
                      'assets/consultation.png',
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) {
                        return const Icon(
                          Icons.local_florist_outlined,
                          color: Colors.black45,
                          size: 36,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticlesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommended Articles',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _goToArticles,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text(
                    'See All',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: kBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 236,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 6),
            itemCount: _allArticles.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildArticleCard(_allArticles[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildArticleCard(Map<String, String> article) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _goToArticleDetail,
      child: Container(
        width: 214,
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildArticleCover(
              imageUrl: article['image'] ?? '',
              category: article['category'] ?? '',
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article['category'] ?? '',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: Text(
                        article['title'] ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            article['author'] ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            '•',
                            style: GoogleFonts.inter(
                              color: Colors.grey.shade400,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        Text(
                          article['time'] ?? '',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleCover({
    required String imageUrl,
    required String category,
  }) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: SizedBox(
        height: 112,
        width: double.infinity,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          gaplessPlayback: true,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;

            return _articleFallback(
              category: category,
              isLoading: true,
            );
          },
          errorBuilder: (_, __, ___) {
            return _articleFallback(
              category: category,
              isLoading: false,
            );
          },
        ),
      ),
    );
  }

  Widget _articleFallback({
    required String category,
    required bool isLoading,
  }) {
    return Container(
      height: 112,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            kLightGreen.withOpacity(0.85),
            kTeal.withOpacity(0.75),
          ],
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.local_florist_outlined,
              color: Colors.white.withOpacity(0.85),
              size: 34,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              category,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          if (isLoading)
            const Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Recent Activity',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 14),
        ..._activities.map((activity) {
          return _buildActivityItem(activity);
        }),
      ],
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: (activity['color'] as Color).withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                activity['icon'] as String,
                width: 22,
                height: 22,
                color: Colors.black54,
                errorBuilder: (_, __, ___) {
                  return Icon(
                    activity['fallbackIcon'] as IconData,
                    color: Colors.black45,
                    size: 21,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['title'] as String,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  activity['subtitle'] as String,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  activity['time'] as String,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    final List<Map<String, dynamic>> items = [
      {
        'label': 'Home',
        'icon': 'assets/dashboard.png',
        'fallback': Icons.home_outlined,
      },
      {
        'label': 'Articles',
        'icon': 'assets/article.png',
        'fallback': Icons.article_outlined,
      },
      {
        'label': 'Consultations',
        'icon': 'assets/consultation.png',
        'fallback': Icons.chat_bubble_outline,
      },
      {
        'label': 'Account',
        'icon': 'assets/user.png',
        'fallback': Icons.person_outline,
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final bool isSelected = index == 0;

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _onBottomNavTapped(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        items[index]['icon'] as String,
                        width: 24,
                        height: 24,
                        color: isSelected ? kBlue : Colors.grey.shade400,
                        errorBuilder: (_, __, ___) {
                          return Icon(
                            items[index]['fallback'] as IconData,
                            color: isSelected ? kBlue : Colors.grey.shade400,
                            size: 24,
                          );
                        },
                      ),
                      const SizedBox(height: 4),
                      Text(
                        items[index]['label'] as String,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected ? kBlue : Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
