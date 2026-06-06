import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dice_bear/dice_bear.dart';
import 'package:pegawai/models/pegawai.dart';
import 'package:pegawai/models/user.dart';
import 'package:pegawai/models/wilayah.dart';
import 'package:pegawai/providers/pegawai_provider.dart';
import 'package:pegawai/providers/user_provider.dart';
import 'package:pegawai/providers/wilayah_provider.dart';
import 'package:pegawai/utils/app_colors.dart';
import 'package:provider/provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final Map<String, TextEditingController> _controllers = {};

  File? _selectedImageFile;
  bool _isControllersInitialized = false;
  Domisili? _selectedProvince;
  Domisili? _selectedCountries;
  Wilayah? _selectedCity;
  Wilayah? _selectedDistrict;
  Wilayah? _selectedVillage;
  List<Wilayah> _cities = [];
  List<Wilayah> _districts = [];
  List<Wilayah> _villages = [];
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (mounted) {
        await context.read<UserProvider>().profile();
        await context.read<WilayahProvider>().getProvinsi();
        await context.read<WilayahProvider>().getNegara();
        await _initializeControllers();
      }
    });
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      initialDate: selectedDate ?? DateTime(2000, 1, 1),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _initializeControllers() async {
    final userProvider = context.read<UserProvider>();
    final wilayahProvider = context.read<WilayahProvider>();

    final dataPegawai = userProvider.dataPegawai;
    final listCountries = wilayahProvider.dataNegara ?? [];
    final listProvinsi = wilayahProvider.dataProvinsi ?? [];

    if (dataPegawai == null) return;

    final fields = {
      'employee_name': dataPegawai.employeeName,
      'nik': dataPegawai.nik,
      'nip': dataPegawai.nip,
      'gender': dataPegawai.gender,
      'phone_number': dataPegawai.phoneNumber?.toString(),
      'birth_place': dataPegawai.birthPlace,
      'address': dataPegawai.address,
      'study_program_id': dataPegawai.studyProgramId,
      'study_program_name': dataPegawai.address,
    };

    fields.forEach((key, value) {
      _controllers[key] = TextEditingController(text: value ?? "");
    });

    if (dataPegawai.birthDate != null && dataPegawai.birthDate!.isNotEmpty) {
      try {
        selectedDate = DateTime.parse(dataPegawai.birthDate!);
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    if (dataPegawai.citizenCode != null && listCountries.isNotEmpty) {
      try {
        _selectedCountries = listCountries.firstWhere(
          (e) => e.code.toString() == dataPegawai.citizenCode.toString(),
        );
      } catch (e) {
        _selectedCountries = null;
      }
    }

    if (dataPegawai.provinceCode != null && listProvinsi.isNotEmpty) {
      try {
        _selectedProvince = listProvinsi.firstWhere(
          (e) => e.code.toString() == dataPegawai.provinceCode.toString(),
        );

        await wilayahProvider.getKota(dataPegawai.provinceCode!);
        _cities = wilayahProvider.dataKota ?? [];

        if (dataPegawai.cityCode != null && _cities.isNotEmpty) {
          _selectedCity = _cities.firstWhere(
            (e) => e.code.toString() == dataPegawai.cityCode.toString(),
          );

          await wilayahProvider.getKecamatan(dataPegawai.cityCode!);
          _districts = wilayahProvider.dataKecamatan ?? [];

          if (dataPegawai.districtCode != null && _districts.isNotEmpty) {
            _selectedDistrict = _districts.firstWhere(
              (e) => e.code.toString() == dataPegawai.districtCode.toString(),
            );

            await wilayahProvider.getKelurahan(dataPegawai.districtCode!);
            _villages = wilayahProvider.dataKelurahan ?? [];

            if (dataPegawai.villageCode != null && _villages.isNotEmpty) {
              _selectedVillage = _villages.firstWhere(
                (e) => e.code.toString() == dataPegawai.villageCode.toString(),
              );
            }
          }
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    setState(() {
      _isControllersInitialized = true;
    });
  }

  void _saveProfile() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final dataPegawai = context.read<UserProvider>().dataPegawai;
    if (dataPegawai == null) {
      if (mounted) Navigator.pop(context);
      return;
    }

    String? formattedBirthDate;
    if (selectedDate != null) {
      formattedBirthDate = selectedDate!.toIso8601String().split('T')[0];
    }

    final requestData = UpdatePegawaiRequest(
      employeeName: _controllers['employee_name']?.text.isNotEmpty == true
          ? _controllers['employee_name']!.text
          : dataPegawai.employeeName,
      nik: _controllers['nik']?.text.isNotEmpty == true
          ? _controllers['nik']!.text
          : dataPegawai.nik,
      nip: _controllers['nip']?.text.isNotEmpty == true
          ? _controllers['nip']!.text
          : dataPegawai.nip,
      gender: _controllers['gender']?.text.isNotEmpty == true
          ? _controllers['gender']!.text
          : dataPegawai.gender,
      phoneNumber: _controllers['phone_number']?.text.isNotEmpty == true
          ? _controllers['phone_number']!.text
          : (dataPegawai.phoneNumber?.toString() ?? ""),
      birthDate: formattedBirthDate ?? dataPegawai.birthDate,
      birthPlace: _controllers['birth_place']?.text.isNotEmpty == true
          ? _controllers['birth_place']!.text
          : dataPegawai.birthPlace,
      address: _controllers['address']?.text.isNotEmpty == true
          ? _controllers['address']!.text
          : dataPegawai.address,
      studyProgramName:
          _controllers['study_program_name']?.text.isNotEmpty == true
          ? _controllers['study_program_name']!.text
          : "",
      provinceCode:
          _selectedProvince?.code?.toString() ?? dataPegawai.provinceCode ?? "",
      cityCode: _selectedCity?.code?.toString() ?? dataPegawai.cityCode ?? "",
      districtCode:
          _selectedDistrict?.code?.toString() ?? dataPegawai.districtCode ?? "",
      villageCode:
          _selectedVillage?.code?.toString() ?? dataPegawai.villageCode ?? "",
      studyProgramId: _controllers['study_program_id']?.text.isNotEmpty == true
          ? _controllers['study_program_id']!.text
          : dataPegawai.studyProgramId ?? "",
      citizenCode:
          _selectedCountries?.code?.toString() ?? dataPegawai.citizenCode ?? "",
      imageUrl: _selectedImageFile?.path,
    );

    try {
      final success = await context.read<PegawaiProvider>().updatePegawai(
        requestData,
        dataPegawai.id,
      );

      if (mounted) Navigator.pop(context);
      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Biodata berhasil diperbarui!"),
              backgroundColor: Colors.green,
            ),
          );
          await context.read<UserProvider>().profile();
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Gagal memperbarui biodata"),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Terjadi kesalahan: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  void _uploadPhoto() async {
    FilePickerResult? result = await FilePicker.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedImageFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.watch<UserProvider>();
    final WilayahProvider wilayahProvider = context.watch<WilayahProvider>();
    final UserResponse? user = userProvider.data;
    final dataPegawai = userProvider.dataPegawai;

    final List<Domisili> listProvinsi = wilayahProvider.dataProvinsi ?? [];
    final List<Domisili> listCountries = wilayahProvider.dataNegara ?? [];

    if (userProvider.isLoading ||
        wilayahProvider.isLoading ||
        user == null ||
        dataPegawai == null ||
        !_isControllersInitialized) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.only(top: 48, left: 23, right: 23),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Profile",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 23),
            sliver: SliverToBoxAdapter(
              child: _buildProfileCard(user.name, dataPegawai.nik),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 18, left: 23, right: 23),
            sliver: SliverToBoxAdapter(
              child: Card(
                color: Colors.white,
                elevation: 3,
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      TabBar(
                        tabAlignment: TabAlignment.start,
                        isScrollable: true,
                        labelColor: AppColors.primaryColor,
                        unselectedLabelColor: Colors.grey,
                        tabs: const [
                          Tab(text: "Informasi Umum"),
                          Tab(text: "Informasi Akun"),
                          Tab(text: "Domisili"),
                        ],
                      ),
                      SizedBox(
                        height: 750,
                        child: TabBarView(
                          children: [
                            _buildTabContent([
                              _buildInputField(
                                "Nama:",
                                _controllers['employee_name']!,
                              ),
                              const SizedBox(height: 12),
                              _buildInputField("NIK:", _controllers['nik']!),
                              const SizedBox(height: 12),
                              _buildInputField("NIP:", _controllers['nip']!),
                              const SizedBox(height: 12),
                              _buildInputField(
                                "Gender:",
                                _controllers['gender']!,
                              ),
                              const SizedBox(height: 12),
                              _buildInputField(
                                "Phone Number:",
                                _controllers['phone_number']!,
                                keyboardType: TextInputType.phone,
                              ),
                              const SizedBox(height: 12),
                              _buildInputField(
                                "Tempat Lahir:",
                                _controllers['birth_place']!,
                              ),
                              const SizedBox(height: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Tanggal Lahir:",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  InkWell(
                                    onTap: pickDate,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            selectedDate == null
                                                ? "Pilih tanggal"
                                                : selectedDate.toString().split(
                                                    " ",
                                                  )[0],
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.calendar_today,
                                            size: 18,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              _buildInputField(
                                "Study Program ID:",
                                _controllers['study_program_id']!,
                              ),
                              const SizedBox(height: 12),
                              _buildWilayahDropdown(
                                label: "Kewarganegaraan (Citizen Code):",
                                value: _selectedCountries,
                                items: listCountries,
                                onChanged: (Domisili? newValue) {
                                  setState(() {
                                    _selectedCountries = newValue;
                                  });
                                },
                              ),
                              const SizedBox(height: 12),
                              _buildInputField(
                                "Study Program:",
                                _controllers['study_program_name']!,
                              ),
                            ]),
                            _buildTabContent([
                              _buildDisabledField("Email:", user.email),
                              const Divider(),
                              const SizedBox(height: 12),
                              _buildDisabledField("Role:", user.roleName),
                            ]),
                            _buildTabContent([
                              _buildInputField(
                                "Alamat Lengkap:",
                                _controllers['address']!,
                              ),
                              const SizedBox(height: 12),
                              _buildWilayahDropdown(
                                label: "Provinsi:",
                                value: _selectedProvince,
                                items: listProvinsi,
                                onChanged: (Domisili? newValue) async {
                                  setState(() {
                                    _selectedProvince = newValue;
                                    _cities = [];
                                    _districts = [];
                                    _villages = [];
                                    _selectedCity = null;
                                    _selectedDistrict = null;
                                    _selectedVillage = null;
                                  });

                                  if (newValue != null) {
                                    await context
                                        .read<WilayahProvider>()
                                        .getKota(newValue.code);
                                    setState(() {
                                      _cities =
                                          context
                                              .read<WilayahProvider>()
                                              .dataKota ??
                                          [];
                                    });
                                  }
                                },
                              ),
                              const SizedBox(height: 12),
                              _buildWilayahDropdown(
                                label: "Kota / Kabupaten:",
                                value: _selectedCity,
                                items: _cities,
                                onChanged: (Domisili? newValue) async {
                                  setState(() {
                                    _selectedCity = newValue as Wilayah?;
                                    _districts = [];
                                    _villages = [];
                                    _selectedDistrict = null;
                                    _selectedVillage = null;
                                  });
                                  if (newValue != null) {
                                    await context
                                        .read<WilayahProvider>()
                                        .getKecamatan(newValue.code);
                                    setState(() {
                                      _districts =
                                          context
                                              .read<WilayahProvider>()
                                              .dataKecamatan ??
                                          [];
                                    });
                                  }
                                },
                              ),
                              const SizedBox(height: 12),
                              _buildWilayahDropdown(
                                label: "Kecamatan:",
                                value: _selectedDistrict,
                                items: _districts,
                                onChanged: (Domisili? newValue) async {
                                  setState(() {
                                    _selectedDistrict = newValue as Wilayah?;
                                    _villages = [];
                                    _selectedVillage = null;
                                  });
                                  if (newValue != null) {
                                    await context
                                        .read<WilayahProvider>()
                                        .getKelurahan(newValue.code);
                                    setState(() {
                                      _villages =
                                          context
                                              .read<WilayahProvider>()
                                              .dataKelurahan ??
                                          [];
                                    });
                                  }
                                },
                              ),
                              const SizedBox(height: 12),
                              _buildWilayahDropdown(
                                label: "Kelurahan:",
                                value: _selectedVillage,
                                items: _villages,
                                onChanged: (Domisili? newValue) {
                                  setState(() {
                                    _selectedVillage = newValue as Wilayah?;
                                  });
                                },
                              ),
                            ]),
                          ],
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
    );
  }

  Widget _buildProfileCard(String nama, String subTitle) {
    final diceBearRequest = DiceBearRequest(
      style: DiceBearStyle.initials,
      coreOptions: DiceBearCoreOptions(seed: nama),
    );

    return Card(
      color: Colors.white,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(13, 17, 13, 17),
        child: Row(
          children: [
            InkWell(
              onTap: _uploadPhoto,
              child: Stack(
                children: [
                  ClipOval(
                    child: _selectedImageFile != null
                        ? Image.file(
                            _selectedImageFile!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          )
                        : diceBearRequest.toImage(width: 80, height: 80),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      radius: 12,
                      child: const Icon(
                        Icons.camera_alt,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 22),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(subTitle, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            SizedBox(
              width: 50,
              height: 50,
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: AppColors.primaryColor,
                ),
                child: const Icon(Icons.save, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(List<Widget> children) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDisabledField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildWilayahDropdown({
    required String label,
    required Domisili? value,
    required List<Domisili> items,
    required ValueChanged<Domisili?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        DropdownSearch<Domisili>(
          items: (filter, loadProps) => items,
          selectedItem: items.contains(value) ? value : null,
          onSelected: onChanged,
          filterFn: (Domisili item, String filter) {
            return item.name.toLowerCase().contains(filter.toLowerCase());
          },
          compareFn: (item1, item2) => item1.id == item2.id,
          itemAsString: (Domisili item) => item.name,
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
          popupProps: PopupProps.bottomSheet(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                hintText: "Cari ${label.replaceAll(':', '')}...",
                prefixIcon: const Icon(Icons.search),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            bottomSheetProps: const BottomSheetProps(
              elevation: 16,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
            ),
            itemBuilder: (context, item, isDisabled, isSelected) {
              return ListTile(
                title: Text(item.name),
                selected: isSelected,
                dense: true,
              );
            },
          ),
        ),
      ],
    );
  }
}
