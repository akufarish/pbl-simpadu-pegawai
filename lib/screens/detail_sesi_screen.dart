import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:pegawai/components/presensi_mahasiswa.dart';
import 'package:pegawai/models/sesi.dart';
import 'package:pegawai/models/presensi.dart';
import 'package:pegawai/providers/presensi_provider.dart';
import 'package:pegawai/screens/tugas_screen.dart';
import 'package:pegawai/utils/app_colors.dart';
import 'package:provider/provider.dart';

class DetailSesiScreen extends StatefulWidget {
  final Sesi sesi;
  const DetailSesiScreen({super.key, required this.sesi});

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

  final Map<String, String> _tempPresensiMap = {};
  bool _isMapInitialized = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController();
    selectedStatus = "Status";

    Future.microtask(() {
      if (mounted) {
        context.read<PresensiProvider>().getDataPresensiMahasiswa(
          widget.sesi.id,
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Id Sesi: ${widget.sesi.id}");
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
                    Text(
                      widget.sesi.courseName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      Icons.access_time_filled_rounded,
                      "${widget.sesi.startTime} - ${widget.sesi.endTime} WITA",
                    ),
                    const SizedBox(height: 4),
                    _buildInfoRow(
                      Icons.person,
                      widget.sesi.lecturer.employeeName,
                    ),
                    const SizedBox(height: 4),
                    _buildInfoRow(Icons.book, "Sesi ${widget.sesi.id}"),
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
                    Tab(text: "Presensi"),
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
              _daftarMahasiswa(),
              // const TugasScreen(),
              ListView.separated(
                padding: const EdgeInsets.only(bottom: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.sesi.learningMaterials!.length,
                itemBuilder: (context, index) {
                  final materi = widget.sesi.learningMaterials![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(materi.originaFileName),
                        Spacer(),
                        ElevatedButton.icon(
                          onPressed: () {},
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            minimumSize: Size(50, 50),
                          ),
                          label: Icon(Icons.download, color: Colors.white),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: 32, thickness: 1);
                },
              ),
              ListView.separated(
                padding: const EdgeInsets.only(bottom: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.sesi.learningMaterials!.length,
                itemBuilder: (context, index) {
                  final materi = widget.sesi.learningMaterials![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(materi.originaFileName),
                        Spacer(),
                        ElevatedButton.icon(
                          onPressed: () {},
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            minimumSize: Size(50, 50),
                          ),
                          label: Icon(Icons.download, color: Colors.white),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: 32, thickness: 1);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView _daftarMahasiswa() {
    PresensiProvider presensiProvider = context.watch<PresensiProvider>();
    final dataPresensiMahasiswa = presensiProvider.presensiMahasiswa;

    if (dataPresensiMahasiswa != null && !_isMapInitialized) {
      for (var mhs in dataPresensiMahasiswa.mahasiswa) {
        _tempPresensiMap[mhs.detailId] = mhs.status ?? "";
      }
      _isMapInitialized = true;
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 28, right: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 105,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
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
            presensiProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : (dataPresensiMahasiswa == null)
                ? const Center(child: Text("Presensi tidak ditemukan"))
                : Column(
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: dataPresensiMahasiswa.mahasiswa.length,
                        itemBuilder: (context, index) {
                          final sesi = dataPresensiMahasiswa.mahasiswa[index];

                          return PresensiMahasiswa(
                            name: sesi.name,
                            detailId: sesi.detailId,
                            sesiId: dataPresensiMahasiswa.sesiId,

                            currentStatus:
                                _tempPresensiMap[sesi.detailId] ?? "",
                            onStatusChanged: (newStatus) {
                              setState(() {
                                _tempPresensiMap[sesi.detailId] = newStatus;
                              });
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () async {
                            List<DetailUpdatePresensiMahassiwa> listDetail = [];
                            _tempPresensiMap.forEach((id, status) {
                              if (status.isNotEmpty) {
                                listDetail.add(
                                  DetailUpdatePresensiMahassiwa(
                                    detailId: id,
                                    status: status.toLowerCase(),
                                  ),
                                );
                              }
                            });

                            final payload = UpdatePresensiMahasiswa(
                              sesiId: dataPresensiMahasiswa.sesiId,
                              detail: listDetail,
                            );

                            bool sukses = await context
                                .read<PresensiProvider>()
                                .updatePresensiMahasiswa(payload);

                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  sukses
                                      ? "Semua data presensi berhasil diperbarui!"
                                      : "Gagal menyimpan presensi",
                                ),
                                backgroundColor: sukses
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Simpan",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
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
