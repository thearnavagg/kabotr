import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kabotr/core/local_db/shared_pref_manager.dart';
import 'package:kabotr/features/onboarding/ui/onboarding_screen.dart';
import 'package:kabotr/features/patr/ui/patr_page.dart';

class DecidePage extends StatefulWidget {
  static final StreamController<String?> authStream =
      StreamController<String?>.broadcast();
  const DecidePage({super.key});

  @override
  State<DecidePage> createState() => _DecidePageState();
}

class _DecidePageState extends State<DecidePage> {
  @override
  void initState() {
    super.initState();
    getUid();
  }

  Future<void> getUid() async {
    String? uid = await SharedPreferencesManager
        .getUid(); // Ensure this method is async and returns Future<String?>
    if (uid == null || uid.isEmpty) {
      DecidePage.authStream.add(null);
    } else {
      DecidePage.authStream.add(uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: DecidePage.authStream.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child:
                  CircularProgressIndicator()); // Show a loading indicator while waiting for data
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
        .close(); // Close the stream when the widget is disposed
    super.dispose();
  }
}
