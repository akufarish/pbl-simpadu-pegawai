import 'package:flutter/material.dart';
import 'package:pegawai/providers/pengampu_provider.dart';
import 'package:pegawai/screens/detail_matkul_screen.dart';
import 'package:pegawai/utils/app_colors.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text("Mata Kuliah")),
      body: pengampuProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsetsGeometry.only(
                    top: 20,
                    left: 23,
                    right: 23,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final matkul = pengampuProvider.data![index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.class_),
                                    SizedBox(width: 12),
                                    Text(matkul.mataKuliah.name),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.person),
                                    SizedBox(width: 12),
                                    Text(matkul.dosen.name),
                                    Spacer(),
                                    ElevatedButton(
                                      onPressed: () => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailMatkulScreen(
                                                  pengampu: matkul,
                                                ),
                                          ),
                                        ),
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
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
                    }, childCount: pengampuProvider.data!.length),
                  ),
                ),
              ],
            ),
    );
  }
}
