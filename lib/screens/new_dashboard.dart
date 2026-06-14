import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pegawai/models/presensi.dart';
import 'package:pegawai/models/sesi.dart';
import 'package:pegawai/models/user.dart';
import 'package:pegawai/providers/presensi_provider.dart';
import 'package:pegawai/providers/sesi_provider.dart';
import 'package:pegawai/providers/user_provider.dart';
import 'package:pegawai/screens/detail_sesi_screen.dart';
import 'package:pegawai/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewDashboard extends StatefulWidget {
  const NewDashboard({super.key});

  @override
  State<NewDashboard> createState() => _NewDashboardState();
}

class _NewDashboardState extends State<NewDashboard> {
  DateTime _focusedDay = DateTime.now();
  final List<String> _listStatusPresensi = ["Hadir", "Sakit", "Alpha"];
  String? _selectedStatusPresensi;

  late TextEditingController _topicController;

  @override
  void initState() {
    super.initState();
    _selectedStatusPresensi = _listStatusPresensi[0];
    _topicController = TextEditingController();

    Future.microtask(() {
      if (mounted) {
        context.read<UserProvider>().profile();
        context.read<PresensiProvider>().getDataPresensiPegawai();
        _getDataSesi(_focusedDay);
        context.read<PresensiProvider>().getPresensiHariIni();
      }
    });
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    String year = date.year.toString();
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');
    return "$year-$month-$day";
  }

  void _getDataSesi(DateTime date) {
    final startDate = DateTime(date.year, date.month, 1);
    final endDate = DateTime(date.year, date.month + 1, 0);

    context.read<SesiProvider>().getDataSesi(
      _formatDate(startDate),
      _formatDate(endDate),
    );
  }

  void _prosesBukaSesi({
    required BuildContext dialogContext,
    required Sesi sesi,
    required String topic,
  }) async {
    final dialogNavigator = Navigator.of(dialogContext);
    final rootNavigator = Navigator.of(context);
    final sesiProvider = context.read<SesiProvider>();
    final presensiProvider = context.read<PresensiProvider>();

    UpdateSesiRequest updateSesiRequest = UpdateSesiRequest(
      status: "opened",
      topic: topic,
    );

    final isSuccess = await sesiProvider.updateSesi(updateSesiRequest, sesi.id);

    PresensiRequest presensiRequest = PresensiRequest(
      pengampuId: sesi.pengampuId,
      sesiId: sesi.id,
    );

    if (isSuccess == true) {
      final result = await presensiProvider.createPresensiMahasiswa(
        presensiRequest,
      );

      if (result == null) {
        dialogNavigator.pop();

        if (mounted) {
          _topicController.clear();
        }

        rootNavigator.push(
          MaterialPageRoute(builder: (context) => DetailSesiScreen(sesi: sesi)),
        );
      }
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal memperbarui status sesi.")),
      );
    }
  }

  void _tampilkanDialogBukaSesi(Sesi dataSesi) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
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
                    hintText: "Masukkan topik kelas...",
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      _prosesBukaSesi(
                        dialogContext: dialogContext,
                        sesi: dataSesi,
                        topic: _topicController.text.trim(),
                      );
                    },
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
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final UserResponse? user = userProvider.data;
    final sesiProvider = context.watch<SesiProvider>();
    final presensiProvider = context.watch<PresensiProvider>();
    final dataPresensi = presensiProvider.presensiHariIni;

    void doCreatePresensi() async {
      if (user?.detailId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("ID Pegawai tidak ditemukan.")),
        );
        return;
      }

      final String statusTerpilih =
          _selectedStatusPresensi ?? _listStatusPresensi[0];
      DetailUpdatePresensiMahassiwa payload = DetailUpdatePresensiMahassiwa(
        detailId: user!.detailId!,
        status: statusTerpilih,
      );

      bool isSuccess = await presensiProvider.updatePresensiPegawai(payload);

      if (!mounted) return;

      if (isSuccess) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Presensi berhasil dilakukan")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Presensi gagal dilakukan")),
        );
      }
    }

    void _openPresensiDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setStateDialog) {
              return Dialog(
                backgroundColor: AppColors.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const SizedBox(height: 11),
                      const Text(
                        "Status Kehadiran",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 11),
                      DropdownButtonFormField<String>(
                        value: _selectedStatusPresensi,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: _listStatusPresensi.map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setStateDialog(() {
                            _selectedStatusPresensi = value;
                          });
                        },
                      ),
                      const SizedBox(height: 11),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: presensiProvider.isLoading
                              ? null
                              : doCreatePresensi,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text("Presensi"),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: CustomScrollView(
          slivers: [
            // Header Section
            SliverPadding(
              padding: const EdgeInsets.only(top: 28, left: 12, right: 12),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selamat Datang, ${user?.name ?? "Joy"}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          (sesiProvider.data == null ||
                                  sesiProvider.data!.isEmpty)
                              ? "Tidak ada kelas hari ini"
                              : "Kamu ada ngajar ${sesiProvider.data!.length} kelas hari ini",
                          style: const TextStyle(
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
              padding: const EdgeInsets.only(top: 15),
              sliver: SliverSkeletonizer(
                enabled: presensiProvider.isLoading,
                child: SliverToBoxAdapter(
                  child: dataPresensi == null
                      ? const SizedBox.shrink()
                      : InkWell(
                          onTap: dataPresensi.status == "alpha"
                              ? _openPresensiDialog
                              : () {},
                          child: Container(
                            width: double.infinity,
                            height: 86,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Icon(
                                    dataPresensi.status != "alpha"
                                        ? Icons.verified
                                        : Icons.close,
                                    color: dataPresensi.status != "alpha"
                                        ? Colors.green
                                        : Colors.redAccent,
                                    size: 64,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    dataPresensi.status != "alpha"
                                        ? "Kamu sudah presensi hari ini"
                                        : "Kamu belum presensi hari ini",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.only(top: 15),
              sliver: SliverSkeletonizer(
                enabled: sesiProvider.isLoading,
                child: SliverToBoxAdapter(
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
                        ),
                        const SizedBox(height: 20),
                        if (sesiProvider.data != null &&
                            sesiProvider.data!.isNotEmpty)
                          ListView.separated(
                            padding: const EdgeInsets.only(bottom: 20),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: sesiProvider.data!.length,
                            itemBuilder: (context, index) {
                              final sesi = sesiProvider.data![index];
                              final bool isOpened = sesi.status == "opened";

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12.0,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                            if (sesi.status == "opened")
                                              const Text(
                                                "Sesi sedang berjalan",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            const SizedBox(height: 8),
                                            _inlineInfoRow(
                                              Icons.access_time_filled_rounded,
                                              sesi.sessionDate,
                                            ),
                                            const SizedBox(height: 4),
                                            _inlineInfoRow(
                                              Icons.person,
                                              sesi.lecturer.employeeName,
                                            ),
                                            const SizedBox(height: 4),
                                            _inlineInfoRow(
                                              Icons.book,
                                              sesi.className,
                                            ),
                                          ],
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (isOpened) {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailSesiScreen(
                                                      sesi: sesi,
                                                    ),
                                              ),
                                            );

                                            _getDataSesi(_focusedDay);
                                          } else {
                                            _tampilkanDialogBukaSesi(sesi);
                                          }
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
                                        child: Text(
                                          isOpened
                                              ? "Detail Sesi"
                                              : "Buka Sesi",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(height: 32, thickness: 1),
                          )
                        else
                          const Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 50),
                            child: Center(
                              child: Text("Tidak ada kelas hari ini"),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inlineInfoRow(IconData icon, String text) {
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
