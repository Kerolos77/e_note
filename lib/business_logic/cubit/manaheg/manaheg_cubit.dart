import 'dart:async';
import 'dart:io';

import 'package:e_note/constants/conestant.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'manaheg_states.dart';

class ManahegCubit extends Cubit<ManahegStates> {
  ManahegCubit() : super(InitialManahegState());

  static ManahegCubit get(context) => BlocProvider.of(context);
  final FirebaseStorage _storage = FirebaseStorage.instance;
  bool envFlag = true;
  bool showContainerFlag = false;

  Map<String, dynamic>? user;

  List<String> pdfNames = [];
  List<String> pdfUrl = [];

  void changeEnvFlag(flag) {
    envFlag = flag;
    emit(ChangeManahegState());
  }

  void changeShowContainerFlag(flag) {
    showContainerFlag = flag;
    emit(ChangeManahegState());
  }

  void getMnaheg() {
    pdfNames = [];
    pdfUrl = [];
    Future(() {}).then((value) {
      emit(GetManahegLoadingManahegState());
    });

    _storage.ref(payId).listAll().then((v) {
      for (var ref in v.items) {
        ref.getDownloadURL().then((value) {
          pdfNames.add(ref.name);
          pdfUrl.add(value);
          if (v.items.last == ref) {
            emit(GetManahegSuccessManahegState());
          }
        });
      }
    }).catchError((error) {});
  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    try {
      var url = "";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  getApplicationDocumentsDirectory() {}
}
