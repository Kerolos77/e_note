import 'package:e_note/data/local/cache_helper.dart';
import 'package:e_note/presentation/widgets/global/default_button.dart';
import 'package:e_note/presentation/widgets/global/default_text/default_text.dart';
import 'package:e_note/presentation/widgets/global/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';

import '../../../../data/firecase/firebase_reposatory.dart';

class MakhdomKraat extends StatefulWidget {
  const MakhdomKraat({super.key});

  @override
  State<MakhdomKraat> createState() => _MakhdomKraatState();
}

class _MakhdomKraatState extends State<MakhdomKraat> {
  bool bakerState = false;
  bool taltaState = false;
  bool sataState = false;
  bool tas3aState = false;
  bool grobState = false;
  bool nomState = false;
  bool ertgalyBakerState = false;
  bool ertgalyNomState = false;
  bool odasState = false;
  bool tnawlState = false;
  bool aatrafState = false;
  bool oldBibleState = false;
  bool newBibleState = false;
  bool soomState = false;

  FirebaseReposatory firebaseReposatory = FirebaseReposatory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: defaultText(
                text: '..سجل قراتك اليوم',
                size: 35.0,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterSwitch(
                      value: bakerState,
                      borderRadius: 20.0,
                      padding: 5.0,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      onToggle: (value) {
                        bakerState = value;
                        setState(() {});
                      }),
                  defaultText(
                    text: 'باكر',
                    size: 25.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterSwitch(
                      value: taltaState,
                      borderRadius: 20.0,
                      padding: 5.0,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      onToggle: (value) {
                        taltaState = value;
                        setState(() {});
                      }),
                  defaultText(
                    text: 'تالته',
                    size: 25.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterSwitch(
                      value: sataState,
                      borderRadius: 20.0,
                      padding: 5.0,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      onToggle: (value) {
                        sataState = value;
                        setState(() {});
                      }),
                  defaultText(
                    text: 'سادسه',
                    size: 25.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterSwitch(
                      value: tas3aState,
                      borderRadius: 20.0,
                      padding: 5.0,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      onToggle: (value) {
                        tas3aState = value;
                        setState(() {});
                      }),
                  defaultText(
                    text: 'تاسعه',
                    size: 25.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterSwitch(
                      value: grobState,
                      borderRadius: 20.0,
                      padding: 5.0,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      onToggle: (value) {
                        grobState = value;
                        setState(() {});
                      }),
                  defaultText(
                    text: 'غروب',
                    size: 25.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterSwitch(
                      value: nomState,
                      borderRadius: 20.0,
                      padding: 5.0,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      onToggle: (value) {
                        nomState = value;
                        setState(() {});
                      }),
                  defaultText(
                    text: 'نوم',
                    size: 25.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterSwitch(
                      value: ertgalyBakerState,
                      borderRadius: 20.0,
                      padding: 5.0,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      onToggle: (value) {
                        ertgalyBakerState = value;
                        setState(() {});
                      }),
                  defaultText(
                    text: "ارتجالي باكر",
                    size: 25.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterSwitch(
                      value: ertgalyNomState,
                      borderRadius: 20.0,
                      padding: 5.0,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      onToggle: (value) {
                        ertgalyNomState = value;
                        setState(() {});
                      }),
                  defaultText(
                    text: 'ارتجالي نوم',
                    size: 25.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterSwitch(
                      value: odasState,
                      borderRadius: 20.0,
                      padding: 5.0,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      onToggle: (value) {
                        odasState = value;
                        setState(() {});
                      }),
                  defaultText(
                    text: 'قداس',
                    size: 25.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterSwitch(
                      value: tnawlState,
                      borderRadius: 20.0,
                      padding: 5.0,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      onToggle: (value) {
                        tnawlState = value;
                        setState(() {});
                      }),
                  defaultText(
                    text: 'تناول',
                    size: 25.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterSwitch(
                      value: aatrafState,
                      borderRadius: 20.0,
                      padding: 5.0,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      onToggle: (value) {
                        aatrafState = value;
                        setState(() {});
                      }),
                  defaultText(
                    text: 'اعتراف',
                    size: 25.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterSwitch(
                      value: oldBibleState,
                      borderRadius: 20.0,
                      padding: 5.0,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      onToggle: (value) {
                        oldBibleState = value;
                        setState(() {});
                      }),
                  defaultText(
                    text: 'عهد قديم',
                    size: 25.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterSwitch(
                      value: newBibleState,
                      borderRadius: 20.0,
                      padding: 5.0,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      onToggle: (value) {
                        newBibleState = value;
                        setState(() {});
                      }),
                  defaultText(
                    text: 'عهد جديد',
                    size: 25.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterSwitch(
                      value: soomState,
                      borderRadius: 20.0,
                      padding: 5.0,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      onToggle: (value) {
                        soomState = value;
                        setState(() {});
                      }),
                  defaultText(
                    text: 'صوم',
                    size: 25.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: defaultButton(
                text: 'SAVE',
                onTap: () {
                  var date = CacheHelper.getData(key: 'date');
                  if (date !=
                      DateFormat('yyyy - MM - dd').format(DateTime.now())) {
                    createUserKraat(
                      baker: bakerState,
                      talta: taltaState,
                      sata: sataState,
                      tas3a: tas3aState,
                      grob: grobState,
                      noom: nomState,
                      ertgalyBaker: ertgalyBakerState,
                      ertgalyNom: ertgalyNomState,
                      tnawel: tnawlState,
                      odas: odasState,
                      eatraf: aatrafState,
                      soom: soomState,
                      oldBible: oldBibleState,
                      newBible: newBibleState,
                    );
                  } else {
                    showToast(
                      message: 'لقد سجلت قراتك اليوم',
                    );
                  }
                },
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createUserKraat({
    required bool baker,
    required bool talta,
    required bool sata,
    required bool tas3a,
    required bool grob,
    required bool noom,
    required bool ertgalyBaker,
    required bool ertgalyNom,
    required bool tnawel,
    required bool odas,
    required bool eatraf,
    required bool soom,
    required bool oldBible,
    required bool newBible,
  }) {
    firebaseReposatory
        .createUserKraat(
      baker: baker,
      talta: talta,
      sata: sata,
      tas3a: tas3a,
      grob: grob,
      noom: noom,
      ertgalyBaker: ertgalyBaker,
      ertgalyNom: ertgalyNom,
      tnawel: tnawel,
      odas: odas,
      eatraf: eatraf,
      soom: soom,
      oldBible: oldBible,
      newBible: newBible,
    )
        .then((value) {
      CacheHelper.putData(
          key: 'date',
          value: DateFormat('yyyy - MM - dd').format(DateTime.now()));
      showToast(
        message: 'Done',
      );
    }).catchError((onError) {});
  }
}
