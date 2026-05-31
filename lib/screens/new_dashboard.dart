import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pegawai/components/sesi_card.dart';
import 'package:pegawai/models/user.dart';
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.watch<UserProvider>();
    final UserResponse? user = userProvider.data;
    final SesiProvider sesiProvider = context.watch<SesiProvider>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32),
        child: PageView(
          children: [
            CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsetsGeometry.fromLTRB(0, 28, 0, 15),
                  sliver: SliverToBoxAdapter(
                    child: Column(
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
                          "Kamu ada ngajar 3 kelas hari ini",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                SliverPadding(
                  padding: EdgeInsetsGeometry.only(top: 15),
                  sliver: sesiProvider.isLoading
                      ? SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final sesi = sesiProvider.data![index];
                            return SesiCard(dataSesi: sesi);
                          }, childCount: sesiProvider.data!.length),
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
            ),
          ],
        ),
      ),
    );
  }
}
