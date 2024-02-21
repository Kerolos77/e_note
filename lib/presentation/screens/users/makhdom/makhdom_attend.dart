import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:e_note/constants/conestant.dart';
import 'package:e_note/presentation/widgets/global/default_text/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scan/scan.dart';

import '../../../../constants/colors.dart';

class MakhdomAttend extends StatefulWidget {
  const MakhdomAttend({super.key});

  @override
  State<MakhdomAttend> createState() => _MakhdomAttendState();
}

class _MakhdomAttendState extends State<MakhdomAttend> {
  String _platformVersion = 'Unknown';
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Scan.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
          return Scaffold(
            backgroundColor: ConstColors.white,
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: SafeArea(
          child: Center(
            child: constUid != null || constUid != ''
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      defaultText(
                          text: 'Scan This to Attend',
                          color: ConstColors.primaryColor,
                          size: 20),
                      const SizedBox(
                        height: 20,
                      ),
                      QrImageView(
                        data: constUid ?? '',
                        version: QrVersions.auto,
                        size: 200,
                      ),
                    ],
                  )
                : defaultText(
                      text: 'Refresh The App To Get Qr Code',
                    color: ConstColors.primaryColor,
                    size: 20),
          ),
        ),
            ),
          );
  }
}
