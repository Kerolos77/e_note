import 'package:e_note/data/local/cache_helper.dart';
import 'package:e_note/presentation/widgets/global/default_button.dart';
import 'package:e_note/presentation/widgets/global/default_text/default_text.dart';
import 'package:e_note/presentation/widgets/global/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';

import '../../../../constants/colors.dart';
import '../../../../data/firecase/firebase_reposatory.dart';

class MakhdomAdd extends StatefulWidget {
  const MakhdomAdd({super.key});

  @override
  State<MakhdomAdd> createState() => _MakhdomAddState();
}

class _MakhdomAddState extends State<MakhdomAdd> {

bool bakerState=false;
bool nomState=false;
bool odasState=false;
bool tnawlState=false;
bool aatrafState=false;

FirebaseReposatory firebaseReposatory = FirebaseReposatory();


  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      body:
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: defaultText(
                text: '..سجل قراتك اليوم',
                size: 35.0,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  FlutterSwitch(
                      value: bakerState,
                      borderRadius: 30.0,
                      padding: 5.0,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      onToggle: (value)
                      {
                        bakerState = value;
                        setState(() {

                        });
                      }),
                  defaultText(
                      text: 'باكر',
                    size: 35.0,

                  ),

                ],

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  FlutterSwitch(
                      value: nomState,
                      borderRadius: 30.0,
                      padding: 5.0,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      onToggle: (value)
                      {
                        nomState = value;
                        setState(() {

                        });
                      }),
                  defaultText(
                    text: 'نوم',
                    size: 35.0,

                  ),

                ],

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  FlutterSwitch(
                      value: odasState,
                      borderRadius: 30.0,
                      padding: 5.0,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      onToggle: (value)
                      {
                        odasState = value;
                        setState(() {

                        });
                      }),
                  defaultText(
                    text: 'قداس',
                    size: 35.0,

                  ),

                ],

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  FlutterSwitch(
                      value: tnawlState,
                      borderRadius: 30.0,
                      padding: 5.0,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      onToggle: (value)
                      {
                        tnawlState = value;
                        setState(() {

                        });
                      }),
                  defaultText(
                    text: 'تناول',
                    size: 35.0,

                  ),

                ],

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  FlutterSwitch(
                      value: aatrafState,
                      borderRadius: 30.0,
                      padding: 5.0,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      onToggle: (value)
                      {
                        aatrafState = value;
                        setState(() {

                        });
                      }),
                  defaultText(
                    text: 'اعتراف',
                    size: 35.0,

                  ),

                ],

              ),
            ),
             Padding(
               padding: const EdgeInsets.all(15.0),
               child: defaultButton(
                   text: 'SAVE',
                   onTap: ()
                   {
                    var date = CacheHelper.getData(key: 'date');
                    if(date != DateFormat('yyyy - MM - dd').format(DateTime.now())) {
                      createUserKraat(
                     baker: bakerState,
                       noom: nomState,
                       tnawel: tnawlState,
                       odas: odasState,
                       eatraf: aatrafState,
                   );
                    }
                    else
                    {
                      showToast(message: 'لقد سجلت قراتك اليوم',);
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
  required bool noom,
  required bool tnawel,
  required bool odas,
  required bool eatraf,}) {
    firebaseReposatory
        .createUserKraat(
     baker: baker,
      noom: noom,
      tnawel: tnawel,
      odas: odas,
      eatraf: eatraf,
    )
        .then((value) {
          CacheHelper.putData(key: 'date',
              value: DateFormat('yyyy - MM - dd').format(DateTime.now()));
          showToast(message: 'Done',);
    }).catchError((onError) {
    });
}
}
