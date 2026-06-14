import 'package:pegawai_bloc/core/components/card_info.dart';
import 'package:pegawai_bloc/core/constants/app_colors.dart';
import 'package:pegawai_bloc/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dice_bear/dice_bear.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AuthCubit>().profile();
      }
    });
  }

  void _logout() {
    context.read<AuthCubit>().logout();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.pushNamedAndRemoveUntil(context, "login", (route) => false);
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 40, 16, 40),
        child: SingleChildScrollView(
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return Skeletonizer(
                  enabled: true,
                  child: ProfileCard(email: "joy@gmail.com", nama: "joy"),
                );
              }

              if (state is ProfileSuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Profile"),
                    SizedBox(height: 25),
                    ProfileCard(
                      email: state.userResponseEntity.email,
                      nama: state.userResponseEntity.name,
                    ),
                    SizedBox(height: 35),
                    Text("Informasi Akun", style: TextStyle(fontSize: 20)),
                    SizedBox(height: 15),
                    Card(
                      elevation: 3,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsetsGeometry.fromLTRB(13, 30, 13, 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            cardInfo(state.userResponseEntity.name, "Nama:"),
                            SizedBox(height: 12),
                            Divider(),
                            SizedBox(height: 12),
                            cardInfo(state.userResponseEntity.email, "Email:"),
                            Divider(),
                            SizedBox(height: 12),
                            cardInfo(
                              state.userResponseEntity.roleName,
                              "Role:",
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: state is AuthLoading ? null : _logout,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(5),
                            ),
                          ),
                          child: state is AuthLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  "Logout",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              if (state is ProfileError) {
                return Center(child: Text(state.errorMessage));
              }

              return Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String nama;
  final String email;
  const ProfileCard({super.key, required this.email, required this.nama});

  @override
  Widget build(BuildContext context) {
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
            IconButton.filled(
              style: IconButton.styleFrom(
                minimumSize: Size(50, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
                backgroundColor: AppColors.primaryColor,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  "/ubah-password",
                  arguments: email,
                );
              },
              icon: Icon(Icons.edit, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
