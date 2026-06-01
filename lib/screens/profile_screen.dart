import 'package:flutter/material.dart';
import 'package:dice_bear/dice_bear.dart';
import 'package:intl/intl.dart';
import 'package:pegawai/models/user.dart';
import 'package:pegawai/providers/user_provider.dart';
import 'package:pegawai/utils/app_colors.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<UserProvider>().profile();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.watch<UserProvider>();
    final UserResponse? user = userProvider.data;
    final dataPegawai = userProvider.dataPegawai;

    return Scaffold(
      body: userProvider.isLoading || user == null || dataPegawai == null
          ? Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            )
          : CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.only(top: 48, left: 23, right: 23),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      "Profile",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsetsGeometry.only(
                    top: 14,
                    right: 23,
                    left: 23,
                    bottom: 14,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: _profileCard(
                      userProvider.data!.name,
                      userProvider.dataPegawai?.nik ?? "joy",
                    ),
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
                              tabs: [
                                Tab(text: "Informasi Umum"),
                                Tab(text: "Informasi akun"),
                                Tab(text: "Domisili"),
                              ],
                            ),
                            SizedBox(
                              height: 700,
                              child: TabBarView(
                                children: [
                                  // informasi umum
                                  _buildTabContent([
                                    CardInfo(
                                      dataPegawai!.employeeName,
                                      "Nama:",
                                    ),
                                    const SizedBox(height: 12),
                                    const Divider(),
                                    const SizedBox(height: 12),
                                    CardInfo(dataPegawai.nik, "NIK:"),
                                    const Divider(),
                                    const SizedBox(height: 12),
                                    CardInfo(dataPegawai.nip, "NIP:"),
                                    const Divider(),
                                    const SizedBox(height: 12),
                                    CardInfo(dataPegawai.gender!, "Gender:"),
                                    const Divider(),
                                    const SizedBox(height: 12),
                                    CardInfo(
                                      dataPegawai.phoneNumber?.toString() ??
                                          "Harap diisi",
                                      "Phone Number:",
                                    ),
                                    const Divider(),
                                    const SizedBox(height: 12),
                                    CardInfo(
                                      DateFormat("EEEE, MMMM d, yyyy").format(
                                        DateTime.parse(
                                          dataPegawai.birthDate ??
                                              DateTime.now().toString(),
                                        ),
                                      ),
                                      "Tanggal Lahir:",
                                    ),
                                  ]),
                                  // Informasi akun
                                  _buildTabContent([
                                    CardInfo(
                                      userProvider.data!.email,
                                      "Email:",
                                    ),
                                    const Divider(),
                                    const SizedBox(height: 12),
                                    CardInfo(
                                      userProvider.data!.roleName,
                                      "Role:",
                                    ),
                                    const Divider(),
                                    const SizedBox(height: 12),
                                  ]),
                                  // Domisili
                                  _buildTabContent([
                                    CardInfo(
                                      dataPegawai.city?.name ?? "Harap diisi",
                                      "Kota:",
                                    ),
                                    const Divider(),
                                    const SizedBox(height: 12),
                                    CardInfo(
                                      dataPegawai.province?.name ??
                                          "Harap diisi",
                                      "Provinsi:",
                                    ),
                                    const Divider(),
                                    const SizedBox(height: 12),
                                    CardInfo(
                                      dataPegawai.province?.name ??
                                          "Harap diisi",
                                      "Provinsi:",
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
}

Card _profileCard(String nama, String email) {
  final request = DiceBearRequest(
    style: DiceBearStyle.initials,
    coreOptions: DiceBearCoreOptions(seed: nama),
  );

  Widget avatar = request.toImage(width: 80, height: 80);

  return Card(
    color: Colors.white,
    elevation: 3,
    child: Padding(
      padding: EdgeInsetsGeometry.fromLTRB(13, 17, 13, 17),
      child: Row(
        children: [
          // Icon(Icons.account_circle, size: 80),
          ClipOval(child: avatar),
          SizedBox(width: 22),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(nama), Text(email)],
            ),
          ),
          Spacer(),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Icon(Icons.edit, color: Colors.white)),
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

Column CardInfo(String data, String label) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontSize: 20, color: Colors.grey)),
      SizedBox(height: 12),
      Text(data, style: TextStyle(fontSize: 20)),
    ],
  );
}
