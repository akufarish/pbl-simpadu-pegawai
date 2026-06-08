import 'package:flutter/material.dart';
import 'package:pegawai/providers/pengampu_provider.dart';
import 'package:pegawai/screens/detail_matkul_screen.dart';
import 'package:pegawai/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MataKuliahScreen extends StatefulWidget {
  const MataKuliahScreen({super.key});

  @override
  State<MataKuliahScreen> createState() => _MataKuliahScreenState();
}

class _MataKuliahScreenState extends State<MataKuliahScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<PengampuProvider>().getPengampu();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final PengampuProvider pengampuProvider = context.watch<PengampuProvider>();

    final listPengampu = pengampuProvider.data;

    return Scaffold(
      appBar: AppBar(title: const Text("Mata Kuliah")),
      body: (listPengampu == null || listPengampu.isEmpty)
          ? const Center(child: Text("Data mata kuliah tidak ditemukan"))
          : CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.only(top: 20, left: 23, right: 23),
                  sliver: SliverSkeletonizer(
                    enabled: pengampuProvider.isLoading,
                    child: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final matkul = listPengampu[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.class_),
                                      const SizedBox(width: 12),
                                      Text(matkul.mataKuliah.name),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.person),
                                      const SizedBox(width: 12),
                                      Text(matkul.dosen.name),
                                      const Spacer(),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailMatkulScreen(
                                                    pengampu: matkul,
                                                  ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          elevation: 0,
                                        ),
                                        child: const Text("Detail Matkul"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }, childCount: listPengampu.length),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
