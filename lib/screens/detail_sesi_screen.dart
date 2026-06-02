import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:pegawai/components/presensi_mahasiswa.dart';
import 'package:pegawai/models/sesi.dart';
import 'package:pegawai/utils/app_colors.dart';

class DetailSesiScreen extends StatefulWidget {
  const DetailSesiScreen({super.key});

  @override
  State<DetailSesiScreen> createState() => _DetailSesiScreenState();
}

class _DetailSesiScreenState extends State<DetailSesiScreen>
    with SingleTickerProviderStateMixin {
  final List<String> daftarHadirList = [
    "Hadir",
    "Sakit",
    "Alpha",
    "Izin",
    "Status",
  ];
  late TabController _tabController;
  late PageController _pageController;
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController();
    selectedStatus = "Status";
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sesi = ModalRoute.of(context)!.settings.arguments as Sesi;
    debugPrint("Id Sesi: ${sesi.id}");
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsetsGeometry.fromLTRB(26, 14, 26, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    sesi.courseName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    Icons.access_time_filled_rounded,
                    "${sesi.startTime} - ${sesi.endTime} WITA",
                  ),
                  const SizedBox(height: 4),
                  _buildInfoRow(Icons.person, sesi.lecturer.employeeName),
                  const SizedBox(height: 4),
                  _buildInfoRow(Icons.book, "Sesi ${sesi.id}"),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
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
                      Tab(text: "Presensi"),
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
                children: [_daftarMahasiswa(), Text("2"), Text("3")],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _daftarMahasiswa() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 28, right: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 105,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedStatus,
                  isExpanded: true,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                  dropdownColor: AppColors.primaryColor,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  items: daftarHadirList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedStatus = newValue!;
                    });
                  },
                ),
              ),
            ),
          ),
          for (var i = 0; i < 20; i++) PresensiMahasiswa(),
        ],
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
