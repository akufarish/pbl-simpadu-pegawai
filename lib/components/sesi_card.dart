import 'package:flutter/material.dart';
import 'package:pegawai/models/presensi.dart';
import 'package:pegawai/models/sesi.dart';
import 'package:pegawai/providers/presensi_provider.dart';
import 'package:pegawai/providers/sesi_provider.dart';
import 'package:pegawai/screens/detail_sesi_screen.dart';
import 'package:pegawai/utils/app_colors.dart';
import 'package:provider/provider.dart';

class SesiCard extends StatefulWidget {
  final Sesi dataSesi;
  const SesiCard({super.key, required this.dataSesi});

  @override
  State<SesiCard> createState() => _SesiCardState();
}

class _SesiCardState extends State<SesiCard> {
  final _topicController = TextEditingController();

  void doUpdateSesi(Sesi sesi) async {
    final topic = _topicController.text;

    final navigator = Navigator.of(context);

    PresensiRequest presensiRequest = PresensiRequest(
      pengampuId: "019e5a44-d9ff-744d-b4b0-ad809bd00ada",
      sesiId: sesi.id,
    );

    final provider = context.read<PresensiProvider>();
    final sesiProvider = context.read<SesiProvider>();

    UpdateSesiRequest updateSesiRequest = UpdateSesiRequest(
      status: "opened",
      topic: topic,
    );

    final updateSesi = await sesiProvider.updateSesi(
      updateSesiRequest,
      sesi.id,
    );

    if (updateSesi == true) {
      // final result = await provider.createPresensiMahasiswa(presensiRequest);

      Future.delayed(Duration.zero, () {
        navigator.push(
          MaterialPageRoute(builder: (context) => DetailSesiScreen(sesi: sesi)),
        );
      });

      // if (result == null) {
      //   debugPrint("Navigasi ke detail-sesi...");

      //   navigator.pop();

      //   Future.delayed(Duration.zero, () {
      //     navigator.push(
      //       MaterialPageRoute(
      //         builder: (context) => DetailSesiScreen(sesi: sesi),
      //       ),
      //     );
      //   });
      // }
    } else {
      debugPrint("Gagal update sesi");
    }
  }

  void _bukaSesi(Sesi dataSesi) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dataSesi.courseName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Sesi ${dataSesi.sessionNumber}",
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Topik Kelas",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _topicController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => doUpdateSesi(dataSesi),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      "Buka Sesi",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.dataSesi.id,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                // _buildInfoRow(
                //   Icons.access_time_filled_rounded,
                //   "${widget.dataSesi.startTime} - ${widget.dataSesi.endTime} WITA",
                // ),
                _buildInfoRow(
                  Icons.access_time_filled_rounded,
                  widget.dataSesi.sessionDate,
                ),
                const SizedBox(height: 4),
                _buildInfoRow(
                  Icons.person,
                  widget.dataSesi.lecturer.employeeName,
                ),
                const SizedBox(height: 4),
                _buildInfoRow(Icons.book, widget.dataSesi.className),
              ],
            ),
          ),
          if (widget.dataSesi.isAlreadyOpened != 1)
            ElevatedButton(
              onPressed: () => _bukaSesi(widget.dataSesi),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text("Buka Sesi"),
            )
          else
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailSesiScreen(sesi: widget.dataSesi),
                  ),
                ),
                // Navigator.pushNamed(context, "/upload-tugas"),
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text("Detail Sesi"),
            ),
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
