import 'package:flutter/material.dart';
import 'package:pegawai/components/presensi_mahasiswa.dart';
import 'package:pegawai/components/tugas_card.dart';
import 'package:pegawai/models/sesi.dart';
import 'package:pegawai/models/presensi.dart';
import 'package:pegawai/providers/materi_provider.dart';
import 'package:pegawai/providers/presensi_provider.dart';
import 'package:pegawai/providers/sesi_provider.dart';
import 'package:pegawai/screens/detail_tugas_screen.dart';
import 'package:pegawai/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DetailSesiScreen extends StatefulWidget {
  final Sesi sesi;
  const DetailSesiScreen({super.key, required this.sesi});

  @override
  State<DetailSesiScreen> createState() => _DetailSesiScreenState();
}

class _DetailSesiScreenState extends State<DetailSesiScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController();

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

  void downloadMateri(String id, String fileName) async {
    bool result = await context.read<MateriProvider>().downloadMateri(
      id,
      fileName,
    );

    if (mounted) {
      if (result) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Download file berhasil")));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Download file gagal")));
      }
    }
  }

  void _prosesTutupSesi(String id, String topic) async {
    final sesiProvider = context.read<SesiProvider>();
    final rootNavigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    UpdateSesiRequest updateSesiRequest = UpdateSesiRequest(
      status: "closed",
      topic: topic,
    );

    final isSuccess = await sesiProvider.updateSesi(updateSesiRequest, id);

    if (isSuccess != null) {
      if (isSuccess.status == "closed") {
        rootNavigator.pop(true);

        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text("Sesi berhasil ditutup"),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } else {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text("Gagal menutup sesi, coba lagi.")),
      );
    }
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.sesi.courseName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        if (widget.sesi.status == "opened")
                          SizedBox(
                            width: 150,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () => _prosesTutupSesi(
                                widget.sesi.id,
                                widget.sesi.topic ?? "topic",
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: AppColors.primaryColor,
                              ),
                              child: const Text(
                                "Tutup Sesi",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                    if (widget.sesi.status == "opened")
                      const Text(
                        "Sesi sedang berjalan",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
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
                    _buildInfoRow(
                      Icons.book,
                      "Sesi ${widget.sesi.sessionNumber} | ${widget.sesi.topic}",
                    ),
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
              DaftarMahasiswaTab(sesi: widget.sesi),

              (widget.sesi.assignments == null ||
                      widget.sesi.assignments!.isEmpty)
                  ? const Center(
                      child: Text(
                        "Tidak ada tugas pada sesi ini",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: widget.sesi.assignments!.length,
                      itemBuilder: (context, index) {
                        final tugas = widget.sesi.assignments![index];
                        return TugasItemCard(
                          tugas: tugas,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailTugasScreen(
                                  tugas: tugas,
                                  sesi: widget.sesi,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(height: 32, thickness: 1);
                      },
                    ),
              (widget.sesi.learningMaterials == null ||
                      widget.sesi.learningMaterials!.isEmpty)
                  ? const Center(
                      child: Text(
                        "Tidak ada materi pada sesi ini",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: widget.sesi.learningMaterials!.length,
                      itemBuilder: (context, index) {
                        final materi = widget.sesi.learningMaterials![index];

                        if (widget.sesi.learningMaterials!.isEmpty) {
                          return Center(
                            child: Text("Tidak ada materi pada sesi ini"),
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(child: Text(materi.originaFileName)),
                              const Spacer(),
                              ElevatedButton.icon(
                                onPressed: () => downloadMateri(
                                  materi.id,
                                  materi.originaFileName,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  minimumSize: const Size(50, 50),
                                ),
                                label: const Icon(
                                  Icons.download,
                                  color: Colors.white,
                                ),
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

class DaftarMahasiswaTab extends StatefulWidget {
  final Sesi sesi;
  const DaftarMahasiswaTab({super.key, required this.sesi});

  @override
  State<DaftarMahasiswaTab> createState() => _DaftarMahasiswaTabState();
}

class _DaftarMahasiswaTabState extends State<DaftarMahasiswaTab> {
  final List<String> daftarHadirList = [
    "Hadir",
    "Sakit",
    "Alpha",
    "Izin",
    "Status",
  ];
  String selectedStatus = "Status";
  final Map<String, String> _tempPresensiMap = {};
  bool _isMapInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final presensiProvider = context.watch<PresensiProvider>();
    final dataPresensiMahasiswa = presensiProvider.presensiMahasiswa;

    if (dataPresensiMahasiswa != null && !_isMapInitialized) {
      _tempPresensiMap.clear();
      for (var mhs in dataPresensiMahasiswa.mahasiswa) {
        _tempPresensiMap[mhs.detailId] = mhs.status;
      }
      _isMapInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final presensiProvider = context.read<PresensiProvider>();
    final dataPresensiMahasiswa = presensiProvider.presensiMahasiswa;

    final bool isSessionOpen = widget.sesi.status == "opened";

    if (dataPresensiMahasiswa != null && !_isMapInitialized) {
      for (var mhs in dataPresensiMahasiswa.mahasiswa) {
        _tempPresensiMap[mhs.detailId] = mhs.status;
      }
      _isMapInitialized = true;
    }

    if (dataPresensiMahasiswa == null ||
        dataPresensiMahasiswa.mahasiswa.isEmpty) {
      return const Center(child: Text("Presensi tidak ditemukan"));
    }

    return ListView(
      padding: const EdgeInsets.only(top: 15, left: 28, right: 28),
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 105,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: isSessionOpen ? AppColors.primaryColor : Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedStatus,
                isExpanded: true,
                onChanged: isSessionOpen
                    ? (newValue) {
                        setState(() {
                          selectedStatus = newValue!;
                          if (selectedStatus != "Status") {
                            _tempPresensiMap.updateAll(
                              (key, value) => selectedStatus,
                            );
                          }
                        });
                      }
                    : null,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
                dropdownColor: AppColors.primaryColor,
                disabledHint: Text(
                  selectedStatus,
                  style: const TextStyle(color: Colors.white60),
                ),
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
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Skeletonizer(
          enabled: presensiProvider.isLoading,
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 20),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dataPresensiMahasiswa.mahasiswa.length,
            itemBuilder: (context, index) {
              final mhs = dataPresensiMahasiswa.mahasiswa[index];

              return IgnorePointer(
                ignoring: !isSessionOpen,
                child: Opacity(
                  opacity: isSessionOpen ? 1.0 : 0.8,
                  child: PresensiMahasiswa(
                    name: mhs.name,
                    detailId: mhs.detailId,
                    sesiId: dataPresensiMahasiswa.sesiId,
                    currentStatus: _tempPresensiMap[mhs.detailId] ?? "",
                    onStatusChanged: (newStatus) {
                      setState(() {
                        _tempPresensiMap[mhs.detailId] = newStatus;
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        if (isSessionOpen)
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () async {
                List<DetailUpdatePresensiMahassiwa> listDetail = [];
                _tempPresensiMap.forEach((id, status) {
                  if (status.isNotEmpty && status != "Status") {
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
                    backgroundColor: sukses ? Colors.green : Colors.red,
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
                  fontSize: 16,
                ),
              ),
            ),
          ),
        const SizedBox(height: 50),
      ],
    );
  }
}
