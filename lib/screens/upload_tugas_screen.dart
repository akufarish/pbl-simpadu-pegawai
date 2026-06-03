import 'dart:collection';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pegawai/models/tugas.dart';
import 'package:pegawai/providers/materi_provider.dart';
import 'package:pegawai/providers/pengampu_provider.dart';
import 'package:pegawai/providers/sesi_provider.dart';
import 'package:pegawai/providers/tugas_provider.dart';
import 'package:pegawai/utils/app_colors.dart';
import 'package:provider/provider.dart';

class UploadTugas extends StatefulWidget {
  const UploadTugas({super.key});

  @override
  State<UploadTugas> createState() => _UploadTugasState();
}

class _UploadTugasState extends State<UploadTugas> {
  HashSet selectedItem = new HashSet();
  bool isMultiSelectEnabled = false;
  String? selectedPoli;
  String? selectedSesi;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<TugasProvider>().getTugas();
        context.read<PengampuProvider>().getPengampu();
      }
    });
  }

  void doMultiSelection(String path) {
    if (isMultiSelectEnabled) {
      setState(() {
        if (selectedItem.contains(path)) {
          selectedItem.remove(path);
        } else {
          selectedItem.add(path);
        }
      });
    } else {}
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

  void _showConfirmDialog() {
    final pengampuList = context.read<PengampuProvider>().data;

    if (pengampuList == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data pengampu belum siap atau kosong")),
      );
      return;
    }

    selectedSesi = null;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                key: const Key('dialog_padding'),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedPoli,
                      decoration: const InputDecoration(
                        labelText: "Pilih Mata Kuliah",
                        border: OutlineInputBorder(),
                      ),
                      items: pengampuList.map((item) {
                        return DropdownMenuItem<String>(
                          value: item.pengampuId.toString(),
                          child: Text(item.mataKuliah.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setStateDialog(() {
                          selectedPoli = value;
                          selectedSesi = null;
                        });

                        if (value != null) {
                          context.read<SesiProvider>().getDataSesiByPengampu(
                            value,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    Consumer<SesiProvider>(
                      builder: (context, sesiProvider, child) {
                        final sesiList = sesiProvider.data;

                        if (sesiProvider.isLoading) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        return DropdownButtonFormField<String>(
                          value: selectedSesi,
                          disabledHint: const Text(
                            "Pilih mata kuliah terlebih dahulu",
                          ),
                          decoration: const InputDecoration(
                            labelText: "Pilih Sesi",
                            border: OutlineInputBorder(),
                          ),
                          items: selectedPoli == null || sesiList == null
                              ? null
                              : sesiList.map((sesi) {
                                  return DropdownMenuItem<String>(
                                    value: sesi.id.toString(),
                                    child: Text("Sesi ${sesi.sessionNumber}"),
                                  );
                                }).toList(),
                          onChanged: selectedPoli == null
                              ? null
                              : (value) {
                                  setStateDialog(() {
                                    selectedSesi = value;
                                  });
                                },
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: selectedPoli != null && selectedSesi != null
                            ? () async {
                                List<String> materiIds = selectedItem
                                    .cast<String>()
                                    .toList();

                                if (materiIds.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Silahkan pilih materi terlebih dahulu",
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                Navigator.pop(context);

                                final scaffoldMessenger = ScaffoldMessenger.of(
                                  context,
                                );
                                bool isSuccess = await context
                                    .read<MateriProvider>()
                                    .uploadMateri(selectedSesi!, materiIds);

                                if (isSuccess) {
                                  scaffoldMessenger.showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Materi berhasil diupload!",
                                      ),
                                    ),
                                  );
                                  setState(() {
                                    selectedItem.clear();
                                    isMultiSelectEnabled = false;
                                  });
                                } else {
                                  scaffoldMessenger.showSnackBar(
                                    const SnackBar(
                                      content: Text("Gagal mengupload materi"),
                                    ),
                                  );
                                }
                              }
                            : null,
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
      },
    );
  }

  void simpanFile() {
    debugPrint("upload file: $selectedItem");
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
                        onTap: () => {doMultiSelection(tugas.id)},
                        onLongPress: () {
                          if (!isMultiSelectEnabled) {
                            isMultiSelectEnabled = true;
                          }
                          doMultiSelection(tugas.id);
                        },
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.file_copy_rounded, size: 50),
                            ),
                            SizedBox(height: 12),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                tugas.originaFileName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Visibility(
                              visible: selectedItem.contains(tugas.id),
                              child: Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {},
            backgroundColor: AppColors.primaryColor,
            label: Text("Upload Tugas", style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 20),
          FloatingActionButton.extended(
            onPressed: _showConfirmDialog,
            backgroundColor: AppColors.primaryColor,
            label: Text("Upload Materi", style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            onPressed: uploadFile,
            backgroundColor: AppColors.primaryColor,
            child: Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
