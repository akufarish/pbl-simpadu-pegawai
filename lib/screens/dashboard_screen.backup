import 'package:flutter/material.dart';
import 'package:pegawai/components/sesi_card.dart';
import 'package:pegawai/models/user.dart';
import 'package:pegawai/providers/sesi_provider.dart';
import 'package:pegawai/providers/user_provider.dart';
import 'package:pegawai/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<UserProvider>().profile();
        context.read<SesiProvider>().getDataSesi();
      }
    });
  }

  final String? data = null;

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.watch<UserProvider>();
    final UserResponse? user = userProvider.data;
    final SesiProvider sesiProvider = context.watch<SesiProvider>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 102,
              width: double.infinity,
              color: AppColors.primaryColor,
              child: Padding(
                padding: EdgeInsetsGeometry.only(top: 28, left: 28, right: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selamat Datang ${user?.name ?? "Joy"}",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      "Kada tahu handak diisi apa",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.primaryColor,
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 5,
                left: 28,
                right: 28,
                bottom: 28,
              ),
              child: SizedBox(
                height: 348,
                child: PageView(
                  children: [
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: sesiProvider.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Kelas Hari Ini",
                                            style: TextStyle(
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                          Text(
                                            DateFormat(
                                              'EEEE, d MMM',
                                              'id_ID',
                                            ).format(DateTime.now()),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () => Navigator.pushNamed(
                                          context,
                                          "/kalender",
                                        ),
                                        style: IconButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                        icon: const Icon(
                                          Icons.calendar_month,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Expanded(
                                    child: sesiProvider.data!.isEmpty
                                        ? const Center(
                                            child: Text(
                                              "Tidak ada jadwal hari ini",
                                            ),
                                          )
                                        : ListView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount:
                                                sesiProvider.data!.length,
                                            itemBuilder: (context, index) {
                                              return SesiCard(
                                                dataSesi:
                                                    sesiProvider.data![index],
                                              );
                                            },
                                          ),
                                  ),
                                ],
                              ),
                      ),
                    ),

                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kelas Hari Ini",
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              DateFormat(
                                'EEEE, d MMM',
                                'id_ID',
                              ).format(DateTime.now()),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Center(
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.verified,
                                    size: 64,
                                    color: Colors.greenAccent,
                                  ),
                                  const SizedBox(height: 12),
                                  const Text("Kamu Sudah Presensi Hari Ini"),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      "Presensi",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 43, 32, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _homeIcon(Icons.check_circle, "Validasi KRS"),
                  _homeIcon(Icons.person, "Mahasiswa"),
                  _homeIcon(Icons.insert_chart_rounded, "Presensi"),
                  _homeIcon(Icons.grid_view_rounded, "Segera"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _homeIcon(IconData icon, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.tertiaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: AppColors.primaryColor, size: 24),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 75,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
