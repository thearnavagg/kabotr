import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kabotr/core/local_db/shared_pref_manager.dart';
import 'package:kabotr/features/onboarding/ui/onboarding_screen.dart';
import 'package:kabotr/features/patr/ui/patr_page.dart';

class DecidePage extends StatefulWidget {
  static StreamController<String> authStream = StreamController.broadcast();
  const DecidePage({super.key});

  @override
  State<DecidePage> createState() => _DecidePageState();
}

class _DecidePageState extends State<DecidePage> {
  @override
  void initState() {
    super.initState();
  }

  getUid() {
    String uid = SharedPreferencesManager.getUid();
    if (uid.isEmpty) {
      DecidePage.authStream.add("");
    } else {
      DecidePage.authStream.add(uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: DecidePage.authStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data == null || (snapshot.data?.isEmpty ?? true)) {
            return OnboardingScreen();
          } else {
            return PatrPage();
          }
        });
  }
}
