import 'package:flutter/material.dart';
import 'package:dice_bear/dice_bear.dart';
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

    return Scaffold(
      body: userProvider.isLoading
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
