import 'dart:io';

import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final path = (await getExternalStorageDirectory())?.path;
  const newPath = '/storage/emulated/0/Heven2';
  if (await Permission.contacts.request().isGranted) {
    Directory(newPath)
        .create()
        // The created directory is returned as a Future.
        .then((Directory directory) {
      print('--------${directory.path}');
    });
  }

  // print ("+++++++++++${path}");// /storage/emulated/0/
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$fileName');
}

Future<File> getFile(String fileName) async {
  final path = (await getExternalStorageDirectory())?.path;
  final file = File('$path/$fileName');
  return file;
}

Future<void> shareFile() async {
  final path = (await getExternalStorageDirectory())?.path;
  final file = File(
      '$path/Attend Repo(${DateFormat('yyyy-MM-dd').format(DateTime.now())}) MnAlwPHS.pdf');
  String? response;
  // final FlutterShareMe flutterShareMe = FlutterShareMe();
  // if (file != null) {
  //   response = await flutterShareMe.shareToWhatsApp(
  //     imagePath: file.path,
  //     fileType: FileType.image,
  //     phoneNumber: "+201225536602",
  //   );
  // } else {
  //   response = await flutterShareMe.shareToWhatsApp(msg: "PDF");
  // }
}
