import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'user_artikel.dart';
import 'user_detail_artikel.dart';

const Color _kTealMain = Color(0xFF5DCFCF);
const Color _kTeal = Color(0xFF76EAD0);
const Color _kBlue = Color(0xFF76D7EA);
const Color _kLGreen = Color(0xFFD0FF99);
const Color _kScaffold = Color(0xFFF0F4F3);

class UserBookmarkArtikelScreen extends StatefulWidget {
  const UserBookmarkArtikelScreen({super.key});

  @override
  State<UserBookmarkArtikelScreen> createState() =>
      _UserBookmarkArtikelScreenState();
}

class _UserBookmarkArtikelScreenState extends State<UserBookmarkArtikelScreen> {
  List<ArticleItem> get _bookmarked {
    return allArticles.where((article) {
      return globalBookmarkedIds.contains(article.id);
    }).toList();
  }

  void _removeBookmark(ArticleItem article) {
    setState(() {
      globalBookmarkedIds.remove(article.id);
      article.isBookmarked = false;
    });
  }

  void _goToDetail(ArticleItem article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserDetailArtikelScreen(article: article),
      ),
    ).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final bookmarks = _bookmarked;

    return Scaffold(
      backgroundColor: _kScaffold,
      body: Column(
        children: [
          _buildHeader(bookmarks.length),
          Expanded(
            child: bookmarks.isEmpty
                ? _buildEmpty()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    physics: const BouncingScrollPhysics(),
                    itemCount: bookmarks.length,
                    itemBuilder: (ctx, i) {
                      return _buildBookmarkCard(bookmarks[i]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(int bookmarkCount) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_kBlue, _kTeal],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Saved Articles',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$bookmarkCount saved',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: _kTeal.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.bookmark_outline_rounded,
              size: 38,
              color: _kTealMain,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No saved articles yet',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Tap the bookmark icon on any article\nto save it here',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookmarkCard(ArticleItem article) {
    return GestureDetector(
      onTap: () => _goToDetail(article),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(16),
              ),
              child: Image.network(
                article.imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                loadingBuilder: (ctx, child, progress) {
                  if (progress == null) return child;

                  return Container(
                    width: 100,
                    height: 100,
                    color: _kLGreen.withOpacity(0.3),
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: _kTealMain,
                      ),
                    ),
                  );
                },
                errorBuilder: (_, __, ___) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: _kLGreen.withOpacity(0.3),
                    child: Icon(
                      Icons.eco_rounded,
                      color: Colors.green.shade300,
                      size: 32,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.category,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _kTealMain,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      article.author,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _removeBookmark(article),
              child: const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.bookmark_rounded,
                  color: _kTealMain,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
