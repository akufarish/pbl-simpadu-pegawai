import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pegawai/models/tugas.dart';
import 'package:pegawai/providers/tugas_provider.dart';
import 'package:pegawai/utils/app_colors.dart';
import 'package:provider/provider.dart';

class UploadTugas extends StatefulWidget {
  const UploadTugas({super.key});

  @override
  State<UploadTugas> createState() => _UploadTugasState();
}

class _UploadTugasState extends State<UploadTugas> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<TugasProvider>().getTugas();
      }
    });
  }

  void uploadFile() async {
    FilePickerResult? result = await FilePicker.pickFiles();

    if (result != null) {
      FilePickerResult? result = await FilePicker.pickFiles(
        allowMultiple: true,
      );
      List<File> files = result!.paths.map((path) => File(path!)).toList();
      debugPrint("upload_file: $files");
      if (!mounted) return;
      context.read<TugasProvider>().uploadTugas(files);
    } else {
      debugPrint("Samting wong");
    }
  }

  void _showConfirmDialog(Tugas tugas) {
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
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      "Upload file",
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
    TugasProvider tugasProvider = context.watch<TugasProvider>();
    return Scaffold(
      body: tugasProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.75,
                ),
                itemCount: tugasProvider.data.length,
                itemBuilder: (context, index) {
                  final Tugas tugas = tugasProvider.data[index];

                  return SizedBox(
                    width: 100,
                    height: 100,
                    child: Card(
                      child: InkWell(
                        onTap: () => _showConfirmDialog(tugas),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.file_copy_rounded, size: 50),
                            SizedBox(height: 12),
                            Text(
                              tugas.originaFileName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: uploadFile,
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
