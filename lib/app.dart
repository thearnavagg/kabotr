import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:kabotr/core/local_db/shared_pref_manager.dart';
import 'package:kabotr/features/onboarding/ui/onboarding_screen.dart';
import 'package:kabotr/features/patr/ui/patr_page.dart';
import 'package:kabotr/themes/splash_screen.dart';

class DecidePage extends StatefulWidget {
  static final StreamController<String?> authStream =
      StreamController<String?>.broadcast();
  const DecidePage({super.key});

  @override
  State<DecidePage> createState() => _DecidePageState();
}

class _DecidePageState extends State<DecidePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUid();
  }

  Future<void> getUid() async {
    log('Fetching UID...');
    try {
      String? uid = await SharedPreferencesManager.getUid();
      log('UID fetched: $uid');
      if (uid == null || uid.isEmpty) {
        DecidePage.authStream.add(null);
        log('Added null to authStream');
      } else {
        DecidePage.authStream.add(uid);
        log('Added $uid to authStream');
      }
    } catch (e) {
      log('Error fetching UID: $e');
      DecidePage.authStream.add(null);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: DecidePage.authStream.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return FutureBuilder(
            future:
                Future.delayed(const Duration(seconds: 5)), 
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen(); 
              } else {
                return const OnboardingScreen();
              }
            },
          );
        }
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.isNotEmpty) {
          return const PatrPage();
        } else {
          return const OnboardingScreen();
        }
      },
    );
  }

  @override
  void dispose() {
    DecidePage.authStream
        .close();
    super.dispose();
  }
}
