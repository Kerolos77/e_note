import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/cubit/view_kraat_team/view_kraat_team_cubit.dart';
import '../../../../business_logic/cubit/view_kraat_team/view_kraat_team_states.dart';
import '../../../widgets/global/default_text/default_text.dart';

class ViewKraatTeam extends StatefulWidget {
  const ViewKraatTeam({super.key});

  @override
  State<ViewKraatTeam> createState() => _ViewKraatTeamState();
}

class _ViewKraatTeamState extends State<ViewKraatTeam> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocProvider(
        create: (BuildContext context) => ViewKraatTeamCubit()..getTeamUsers(),
        child: BlocConsumer<ViewKraatTeamCubit, ViewKraatTeamStates>(
          listener: (BuildContext context, ViewKraatTeamStates state) {},
          builder: (BuildContext context, ViewKraatTeamStates state) {
            ViewKraatTeamCubit cub = ViewKraatTeamCubit.get(context);
            return RefreshIndicator(
              onRefresh: () async {},
              child: Scaffold(
                backgroundColor: Colors.white,
                body: SizedBox(
                  height: height,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              defaultText(text: 'Attendance', size: 30),
                              cub.names.isNotEmpty
                                  ? SizedBox(
                                      width: width * 2,
                                      child: DropdownButtonFormField2<String>(
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        hint: const Text(
                                          'Select Your Team Member',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        items: cub.names
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Please select Team Member.';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          print(value);
                                          cub.getUserKraat(cub.ids[value]!);
                                        },
                                        onSaved: (value) {
                                          selectedValue = value.toString();
                                        },
                                        buttonStyleData: const ButtonStyleData(
                                          padding: EdgeInsets.only(right: 8),
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black45,
                                          ),
                                          iconSize: 24,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                        ),
                                      ),
                                    )
                                  : const CircularProgressIndicator(),
                              SizedBox(
                                width: width * 3,
                                child: Card(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 6.0),
                                  color: Colors.white,
                                  child: Container(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        defaultText(text: 'التاريخ'),
                                        const SizedBox(
                                          width: 35,
                                        ),
                                        defaultText(text: '|'),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        defaultText(text: 'باكر'),
                                        const SizedBox(
                                          width: 23,
                                        ),
                                        defaultText(text: '|'),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        defaultText(text: 'تالته'),
                                        const SizedBox(
                                          width: 19,
                                        ),
                                        defaultText(text: '|'),
                                        const SizedBox(
                                          width: 12.5,
                                        ),
                                        defaultText(text: 'سادسه'),
                                        const SizedBox(
                                          width: 12.5,
                                        ),
                                        defaultText(text: '|'),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        defaultText(text: 'تاسعه'),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        defaultText(text: '|'),
                                        const SizedBox(
                                          width: 15.5,
                                        ),
                                        defaultText(text: 'غروب'),
                                        const SizedBox(
                                          width: 15.5,
                                        ),
                                        defaultText(text: '|'),
                                        const SizedBox(
                                          width: 21,
                                        ),
                                        defaultText(text: 'نوم'),
                                        const SizedBox(
                                          width: 21,
                                        ),
                                        defaultText(text: '|'),
                                        const SizedBox(
                                          width: 4.5,
                                        ),
                                        defaultText(text: 'ارتجالي ب'),
                                        const SizedBox(
                                          width: 4.5,
                                        ),
                                        defaultText(text: '|'),
                                        const SizedBox(
                                          width: 4.5,
                                        ),
                                        defaultText(text: 'ارتجالي ن'),
                                        const SizedBox(
                                          width: 4.5,
                                        ),
                                        defaultText(text: '|'),
                                        const SizedBox(
                                          width: 17,
                                        ),
                                        defaultText(text: 'تناول'),
                                        const SizedBox(
                                          width: 17,
                                        ),
                                        defaultText(text: '|'),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        defaultText(text: 'قداس'),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        defaultText(text: '|'),
                                        const SizedBox(
                                          width: 11.5,
                                        ),
                                        defaultText(text: 'اعتراف'),
                                        const SizedBox(
                                          width: 11.5,
                                        ),
                                        defaultText(text: '|'),
                                        const SizedBox(
                                          width: 18,
                                        ),
                                        defaultText(text: 'صوم'),
                                        const SizedBox(
                                          width: 18,
                                        ),
                                        defaultText(text: '|'),
                                        const SizedBox(
                                          width: 14,
                                        ),
                                        defaultText(text: 'ععد ق'),
                                        const SizedBox(
                                          width: 14,
                                        ),
                                        defaultText(text: '|'),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        defaultText(text: 'عهد ج'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              cub.kraatList.isEmpty
                                  ? SizedBox(
                                      width: width,
                                      child: const LinearProgressIndicator())
                                  : SizedBox(
                                      height: height,
                                      width: width * 3,
                                      child: ListView.builder(
                                        itemBuilder: (BuildContext context,
                                                int index) =>
                                            buildList(
                                                date: cub.kraatList[index].date,
                                                baker:
                                                    cub.kraatList[index].baker,
                                                talta:
                                                    cub.kraatList[index].talta,
                                                sata: cub.kraatList[index].sata,
                                                tas3a:
                                                    cub.kraatList[index].tas3a,
                                                grob: cub.kraatList[index].grob,
                                                noom: cub.kraatList[index].noom,
                                                ertgalyBaker: cub
                                                    .kraatList[index]
                                                    .ertgalyBaker,
                                                ertgalyNom: cub.kraatList[index]
                                                    .ertgalyNom,
                                                tnawel:
                                                    cub.kraatList[index].tnawel,
                                                odas: cub.kraatList[index].odas,
                                                eatraf:
                                                    cub.kraatList[index].eatraf,
                                                soom: cub.kraatList[index].soom,
                                                oldBible: cub
                                                    .kraatList[index].oldBible,
                                                newBible: cub
                                                    .kraatList[index].newBible),
                                        itemCount: cub.kraatList.length,
                                      ),
                                    ),
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  Widget buildList({
    required String date,
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
    Color? color = Colors.white;

    Widget listItem;
    listItem = Card(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      color: color,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            defaultText(text: date.toString()),
            defaultText(text: '|'),
            icon(baker),
            defaultText(text: '|'),
            icon(talta),
            defaultText(text: '|'),
            icon(sata),
            defaultText(text: '|'),
            icon(tas3a),
            defaultText(text: '|'),
            icon(grob),
            defaultText(text: '|'),
            icon(noom),
            defaultText(text: '|'),
            icon(ertgalyBaker),
            defaultText(text: '|'),
            icon(ertgalyNom),
            defaultText(text: '|'),
            icon(tnawel),
            defaultText(text: '|'),
            icon(odas),
            defaultText(text: '|'),
            icon(eatraf),
            defaultText(text: '|'),
            icon(soom),
            defaultText(text: '|'),
            icon(oldBible),
            defaultText(text: '|'),
            icon(newBible),
          ],
        ),
      ),
    );

    return Stack(
      children: [
        Container(
          child: listItem,
        ),
      ],
    );
  }

  Widget icon(bool flag) {
    return Icon(
      flag ? Icons.done : Icons.close,
      color: flag ? Colors.green : Colors.red,
    );
  }
}
