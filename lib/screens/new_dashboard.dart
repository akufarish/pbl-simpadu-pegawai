import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pegawai/components/sesi_card.dart';
import 'package:pegawai/models/user.dart';
import 'package:pegawai/providers/presensi_provider.dart';
import 'package:pegawai/providers/sesi_provider.dart';
import 'package:pegawai/providers/user_provider.dart';
import 'package:pegawai/utils/app_colors.dart';
import 'package:provider/provider.dart';

class NewDashboard extends StatefulWidget {
  const NewDashboard({super.key});

  @override
  State<NewDashboard> createState() => _NewDashboardState();
}

class _NewDashboardState extends State<NewDashboard> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<UserProvider>().profile();
        context.read<SesiProvider>().getDataSesi();
        context.read<PresensiProvider>().getDataPresensiPegawai();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.watch<UserProvider>();
    final UserResponse? user = userProvider.data;
    final SesiProvider sesiProvider = context.watch<SesiProvider>();
    final PresensiProvider presensiProvider = context.watch<PresensiProvider>();

    void doCreatePresensi() async {
      bool isSuccess = await presensiProvider.createPresensi();

      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Presensi berhasil dilakukan")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Presensi gagal dilakukan")),
        );
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: PageView(
          children: [
            CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsetsGeometry.only(
                    top: 28,
                    left: 12,
                    right: 12,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Selamat Datang, ${user?.name ?? "Joy"}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              sesiProvider.data!.isEmpty
                                  ? "Tidak ada kelas hari ini"
                                  : "Kamu ada ngajar ${sesiProvider.data?.length ?? 0} kelas hari ini",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, "/kalender"),
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsetsGeometry.only(top: 15),
                  sliver: sesiProvider.isLoading
                      ? SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : SliverToBoxAdapter(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Kelas hari ini",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      Text(
                                        DateFormat(
                                          'EEEE, d MMM',
                                          'id_ID',
                                        ).format(DateTime.now()),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),

                                if (sesiProvider.data!.isEmpty != true)
                                  ListView.separated(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: sesiProvider.data!.length,
                                    itemBuilder: (context, index) {
                                      final sesi = sesiProvider.data![index];

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        child: SesiCard(dataSesi: sesi),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                          return const Divider(
                                            height: 32,
                                            thickness: 1,
                                          );
                                        },
                                  )
                                else
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 12,
                                      bottom: 50,
                                    ),
                                    child: Center(
                                      child: Text("Tidak ada kelas hari ini"),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
            Center(
              child: Container(
                width: 377,
                height: 348,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            Text(presensiProvider.data?.sesiId ?? "Kosong"),
                            const Text("Kamu Sudah Presensi Hari Ini"),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: presensiProvider.isLoading
                                  ? null
                                  : doCreatePresensi,
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
            ),
          ],
        ),
      ),
    );
  }
}
