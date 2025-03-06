import 'dart:developer';
import 'package:event_app/core/localization/l10n/l10n.dart';
import 'package:event_app/core/services/secure_storage_service.dart';
import 'package:event_app/features/auth/data/models/response_model/login_response_model.dart';
import 'package:event_app/utils/extension/context_extension.dart';
import 'package:event_app/utils/navigation/app_navigation.dart';
import 'package:event_app/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<LoginResponseModel?> _userDataFuture;
  final _storageService = SecureStorageService();
  String docName = '';

  @override
  void initState() {
    super.initState();
    _userDataFuture = _getUserData();
    getUserName();
  }

  Future<void> getUserName() async {
    final user = await _storageService.getUserData();
    setState(() {
      docName = user?.doctorName ?? '';
    });
  }

  Future<LoginResponseModel?> _getUserData() async {
    try {
      final user = await _storageService.getUserData();
      return user;
    } catch (e) {
      log('Error loading user data: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.primary,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded, size: 30),
          color: Colors.white,
          onPressed: () {},
        ),
        title: Text(
          '${context.l10n.welcome}, $docName',
          style: AppTextStyles().titleMediumTextStyle(
            context: context,
            textColor: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, size: 30),
            color: Colors.white,
            onPressed: () async {
              await _storageService.clearUserData().whenComplete(() {
                if (context.mounted) {
                  AppNavigation().navigateToSignIn(context: context);
                }
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<LoginResponseModel?>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading data: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text('No user data found. Please log in again.'),
            );
          }

          // User data is available
          final userData = snapshot.data!;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Doctor: ${userData.doctorName}',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text('Email: ${userData.email}'),
                  const SizedBox(height: 8),
                  Text('User ID: ${userData.userUniqueId}'),
                  const SizedBox(height: 8),
                  Text('QR Code: ${userData.qrCode}'),
                  const SizedBox(height: 16),
                  const Text('Full data:'),
                  const SizedBox(height: 8),
                  Text(userData.toJson().toString()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// import 'package:event_app/core/localization/l10n/l10n.dart';
// import 'package:event_app/core/services/secure_storage_service.dart';
// import 'package:event_app/utils/extension/context_extension.dart';
// import 'package:event_app/utils/navigation/app_navigation.dart';
// import 'package:event_app/utils/theme/app_text_styles.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final _storageService = SecureStorageService();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: context.colorScheme.primary,
//         leading: IconButton(
//           icon: const Icon(Icons.menu_rounded, size: 30),
//           color: Colors.white,
//           onPressed: () {},
//         ),
//         title: Text(
//           '${context.l10n.welcome}, Kashif Hafeez',
//           style: AppTextStyles().titleMediumTextStyle(
//             context: context,
//             textColor: Colors.white,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout_rounded, size: 30),
//             color: Colors.white,
//             onPressed: () async {
//               await _storageService.clearUserData().whenComplete(() {
//                 if (context.mounted) {
//                   AppNavigation().navigateToSignIn(context: context);
//                 }
//               });
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: List.generate(
//             20,
//             (i) => Container(
//               color: Colors.red,
//               margin: const EdgeInsets.all(12),
//               width: double.infinity,
//               height: 150,
//             ),
//           ).toList(),
//         ),
//       ),
//     );
//   }
// }
