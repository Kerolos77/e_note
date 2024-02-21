import 'package:e_note/data/local/cache_helper.dart';
import 'package:e_note/presentation/widgets/global/default_button.dart';
import 'package:e_note/presentation/widgets/global/default_snack_bar.dart';
import 'package:e_note/presentation/widgets/global/default_text/default_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants/colors.dart';
import '../../../../data/firecase/firebase_reposatory.dart';
import '../../../widgets/keraat/keraat_row.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: defaultText(
                text: '..سجل قراتك اليوم',
                size: 20.0,
                color: ConstColors.grey,
              ),
            ),
            keraatRow(
              text: 'باكر',
              onToggle: (value) {
                bakerState = value;
                setState(() {});
              },
              state: bakerState,
            ),
            keraatRow(
              text: 'تالته',
              onToggle: (value) {
                taltaState = value;
                setState(() {});
              },
              state: taltaState,
            ),
            keraatRow(
              text: 'سادسه',
              onToggle: (value) {
                sataState = value;
                setState(() {});
              },
              state: sataState,
            ),
            keraatRow(
              text: 'تاسعه',
              onToggle: (value) {
                tas3aState = value;
                setState(() {});
              },
              state: tas3aState,
            ),
            keraatRow(
              text: 'غروب',
              onToggle: (value) {
                grobState = value;
                setState(() {});
              },
              state: grobState,
            ),
            keraatRow(
              text: 'نوم',
              onToggle: (value) {
                nomState = value;
                setState(() {});
              },
              state: nomState,
            ),
            keraatRow(
              text: 'ارتجالي باكر',
              onToggle: (value) {
                ertgalyBakerState = value;
                setState(() {});
              },
              state: ertgalyBakerState,
            ),
            keraatRow(
              text: 'ارتجالي نوم',
              onToggle: (value) {
                ertgalyNomState = value;
                setState(() {});
              },
              state: ertgalyNomState,
            ),
            keraatRow(
              text: 'قداس',
              onToggle: (value) {
                odasState = value;
                setState(() {});
              },
              state: odasState,
            ),
            keraatRow(
              text: 'تناول',
              onToggle: (value) {
                tnawlState = value;
                setState(() {});
              },
              state: tnawlState,
            ),
            keraatRow(
              text: 'اعتراف',
              onToggle: (value) {
                aatrafState = value;
                setState(() {});
              },
              state: aatrafState,
            ),
            keraatRow(
              text: 'عهد جديد',
              onToggle: (value) {
                newBibleState = value;
                setState(() {});
              },
              state: newBibleState,
            ),
            keraatRow(
              text: 'صوم',
              onToggle: (value) {
                soomState = value;
                setState(() {});
              },
              state: soomState,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: defaultButton(
                text: 'SAVE',
                onPressed: () {
                  var date = CacheHelper.getData(key: 'date');
                  if (date != DateFormat('yyyy-MM-dd').format(DateTime.now())) {
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
                        context: context);
                  } else {
                    defaultSnackBar(
                        message: 'لقد سجلت قراتك اليوم', context: context);
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
    required BuildContext context,
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
          key: 'date', value: DateFormat('yyyy-MM-dd').format(DateTime.now()));
      defaultSnackBar(message: 'Done', context: context);
    }).catchError((onError) {
      defaultSnackBar(message: onError, context: context);
    });
  }
}
