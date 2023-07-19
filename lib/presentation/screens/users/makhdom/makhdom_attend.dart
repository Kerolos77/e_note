import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:e_note/constants/conestant.dart';
import 'package:e_note/presentation/widgets/global/default_text/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scan/scan.dart';

import '../../../../business_logic/cubit/manaheg/manaheg_cubit.dart';
import '../../../../business_logic/cubit/manaheg/manaheg_states.dart';
import '../../../widgets/global/toast.dart';

class MakhdomAttend extends StatefulWidget {
  const MakhdomAttend({super.key});

  @override
  State<MakhdomAttend> createState() => _MakhdomAttendState();
}

class _MakhdomAttendState extends State<MakhdomAttend> {
  String _platformVersion = 'Unknown';
  String qrcode = 'Unknown';
  ScanController controller = ScanController();
  String qrcode1 = 'Unknown';
  bool lightFlag = false;
  bool progressFlag = false;
  TextEditingController descriptionController = TextEditingController();
  Map<String, dynamic>? barcode;

  var formKey = GlobalKey<FormState>();

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    late ManahegCubit cub;
    return BlocProvider(
        create: (BuildContext context) => ManahegCubit(),
        child: BlocConsumer<ManahegCubit, ManahegStates>(
            listener: (BuildContext context, ManahegStates state) {
          print('***************************************$state');

          if (state is CreateBarcodeLoadingManahegState) {
            cub.changeShowContainerFlag(false);
            progressFlag = true;
          }

          if (state is CreateBarcodeSuccessManahegState) {
            controller.resume();
            cub.changeShowContainerFlag(false);
            progressFlag = false;
            showToast(message: 'Done');
          }

          if (state is CreateBarcodeErrorManahegState) {
            progressFlag = false;
            cub.changeShowContainerFlag(true);
            showToast(message: state.error);
          }
        }, builder: (BuildContext context, ManahegStates state) {
          cub = ManahegCubit.get(context);
          if (barcode != null) {
            descriptionController.text = barcode?['description'];
          } else {}
          return Scaffold(
            backgroundColor: Colors.white,
            body: DoubleBackToCloseApp(
              snackBar: const SnackBar(
                content: Text('Tap back again to leave'),
              ),
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      defaultText(
                          text: 'Scan This to Attend',
                          color: Colors.green,
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
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
