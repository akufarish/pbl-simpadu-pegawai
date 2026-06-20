import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pegawai/models/sesi.dart';
import 'package:pegawai/models/tugas.dart';
import 'package:pegawai/providers/materi_provider.dart';
import 'package:pegawai/utils/app_colors.dart';
import 'package:provider/provider.dart';

class DetailTugasScreen extends StatefulWidget {
  final Tugas tugas;
  final Sesi sesi;
  const DetailTugasScreen({super.key, required this.tugas, required this.sesi});

  @override
  State<DetailTugasScreen> createState() => _DetailTugasScreenState();
}

class _DetailTugasScreenState extends State<DetailTugasScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.tugas.title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Sesi ${widget.sesi.sessionNumber} | ${widget.sesi.courseName}",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsetsGeometry.only(top: 12, left: 12, right: 12),
            sliver: SliverToBoxAdapter(
              child: Card(
                color: Colors.white,
                elevation: 8.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Detail Tugas"),
                      SizedBox(height: 14),
                      Text(widget.tugas.title),
                      SizedBox(height: 12),
                      Text("Deadline", style: TextStyle(fontSize: 12)),
                      Text(widget.tugas.deadline),
                      SizedBox(height: 12),
                      Text(widget.tugas.description ?? "-"),
                      SizedBox(height: 12),
                      Text("Attachment", style: TextStyle(fontSize: 12)),
                      if (widget.tugas.attachment == null ||
                          widget.tugas.attachment!.isEmpty)
                        const Text(
                          "Tidak ada materi pada sesi ini",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (widget.tugas.attachment != null &&
              widget.tugas.attachment!.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              sliver: SliverList.separated(
                itemCount: widget.tugas.attachment!.length,
                itemBuilder: (context, index) {
                  final materi = widget.tugas.attachment![index];

                  return Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.insert_drive_file,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              materi.originaFileName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () => downloadMateri(
                              materi.id,
                              materi.originaFileName,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(44, 44),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Icon(
                              Icons.download,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 8),
              ),
            ),
        ],
      ),
    );
  }
}
