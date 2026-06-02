import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:pegawai/models/pengampu.dart';
import 'package:pegawai/screens/tugas_screen.dart';
import 'package:pegawai/utils/app_colors.dart';

class DetailMatkulScreen extends StatefulWidget {
  final Pengampu pengampu;
  const DetailMatkulScreen({super.key, required this.pengampu});

  @override
  State<DetailMatkulScreen> createState() => _DetailMatkulScreenState();
}

class _DetailMatkulScreenState extends State<DetailMatkulScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsetsGeometry.only(bottom: 12),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.class_, color: Colors.black, size: 18),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            widget.pengampu.mataKuliah.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),
                    _buildInfoRow(Icons.person, widget.pengampu.dosen.name),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      labelColor: AppColors.primaryColor,
                      unselectedLabelColor: Colors.grey,
                      onTap: (index) {
                        _pageController.animateToPage(
                          index,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      tabs: [
                        Tab(text: "Sesi"),
                        Tab(text: "Tugas"),
                        Tab(text: "Materi"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsetsGeometry.only(top: 20),
              sliver: SliverToBoxAdapter(
                child: ExpandablePageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    _tabController.animateTo(index);
                  },
                  children: [Text("1"), TugasScreen(), Text("3")],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[500], size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
