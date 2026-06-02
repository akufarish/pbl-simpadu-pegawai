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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.class_, color: Colors.black, size: 18),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TabBar(
                  controller: _tabController,
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  labelColor: AppColors.primaryColor,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: "Sesi"),
                    Tab(text: "Tugas"),
                    Tab(text: "Materi"),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: TabBarView(
            controller: _tabController,
            children: [
              ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: 15,
                itemBuilder: (context, index) =>
                    Card(child: ListTile(title: Text("Sesi Ke-${index + 1}"))),
              ),
              const TugasScreen(),
              const Center(child: Text("Konten Materi")),
            ],
          ),
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
