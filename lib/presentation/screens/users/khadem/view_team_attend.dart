import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/cubit/view_team_attend/view_team_attend_cubit.dart';
import '../../../../business_logic/cubit/view_team_attend/view_team_attend_states.dart';
import '../../../widgets/global/default_text/default_text.dart';

class ViewTeamAttend extends StatefulWidget {
  const ViewTeamAttend({super.key});

  @override
  State<ViewTeamAttend> createState() => _ViewTeamAttendState();
}

class _ViewTeamAttendState extends State<ViewTeamAttend> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocProvider(
        create: (BuildContext context) => ViewTeamAttendCubit()..getTeamUsers(),
        child: BlocConsumer<ViewTeamAttendCubit, ViewTeamAttendStates>(
          listener: (BuildContext context, ViewTeamAttendStates state) {},
          builder: (BuildContext context, ViewTeamAttendStates state) {
            ViewTeamAttendCubit cub = ViewTeamAttendCubit.get(context);
            return RefreshIndicator(
              onRefresh: () async {},
              child: Scaffold(
                backgroundColor: Colors.white,
                body: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      backgroundColor: Colors.white,
                      pinned: true,
                      snap: false,
                      floating: false,
                      expandedHeight: 200.0,
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Center(child: defaultText(text: 'Date')),
                            ),
                            Expanded(
                                child: Center(
                                    child: defaultText(text: 'lecture 1'))),
                            Expanded(
                                child: Center(
                                    child: defaultText(text: 'lecture 2'))),
                          ],
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  end: Alignment.topLeft,
                                  colors: <Color>[
                                Colors.white,
                                Colors.white,
                              ])),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: cub.names.isNotEmpty
                                  ? DropdownButtonFormField2<String>(
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
                                        print(
                                            "*************** ${cub.ids[value.toString()]}");
                                        cub.getUserAttend(cub.ids[value]!);
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
                                    )
                                  : CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ),
                      elevation: 9.0,
                    ),
                    cub.userAttendList.isEmpty
                        ? const SliverToBoxAdapter(
                            child: LinearProgressIndicator(),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) => buildList(
                                date: cub.userAttendList[index].date,
                                time1: cub.userAttendList[index].lecture1,
                                time2: cub.userAttendList[index].lecture2,
                              ),
                              childCount: cub.userAttendList.length,
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget buildList(
      {required String date, required String time1, required String time2}) {
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
            Expanded(
              child: Center(child: defaultText(text: date)),
            ),
            Expanded(child: Center(child: defaultText(text: time1))),
            Expanded(child: Center(child: defaultText(text: time2))),
          ],
        ),
      ),
    );

    return Stack(
      children: [
        Container(
          // color: ConstColors.coffeeLight,
          child: listItem,
        ),
      ],
    );
  }
}
