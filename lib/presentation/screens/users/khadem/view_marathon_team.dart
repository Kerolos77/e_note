import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/cubit/view_team_attend/view_team_attend_cubit.dart';
import '../../../../business_logic/cubit/view_team_attend/view_team_attend_states.dart';
import '../../../../data/firecase/firebase_reposatory.dart';
import '../../../../data/models/marathon_answer_model.dart';
import '../../../widgets/global/default_text/default_text.dart';

class ViewTeamMaraton extends StatefulWidget {
  const ViewTeamMaraton({super.key});

  @override
  State<ViewTeamMaraton> createState() => _ViewTeamMaratonState();
}

class _ViewTeamMaratonState extends State<ViewTeamMaraton> {
  String? selectedValue;
  FirebaseReposatory firebaseReposatory = FirebaseReposatory();
  List<MarathonAnswerModel> filteredNotoes = [];
  bool sorted = false;
  List<MarathonAnswerModel> sampleNotes = [];

  List<MarathonAnswerModel> sortNotesByModifiedTime(
      List<MarathonAnswerModel> notes) {
    if (sorted) {
      notes.sort((a, b) => a.modifiedTime.compareTo(b.modifiedTime));
    } else {
      notes.sort((b, a) => a.modifiedTime.compareTo(b.modifiedTime));
    }
    sorted = !sorted;
    return notes;
  }

  void onSearchTextChange(String searchText) {
    setState(() {
      filteredNotoes = sampleNotes
          .where((note) =>
              note.content.toLowerCase().contains(searchText.toLowerCase()) ||
              note.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

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
                      pinned: false,
                      snap: false,
                      floating: false,
                      expandedHeight: 160.0,
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(2.0),
                        child: TextField(
                          onChanged: onSearchTextChange,
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 12),
                              hintText: "Search ...",
                              hintStyle: const TextStyle(color: Colors.grey),
                              prefixIcon:
                                  const Icon(Icons.search, color: Colors.grey),
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              )),
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
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        defaultText(text: 'Marathon', size: 30),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                filteredNotoes =
                                                    sortNotesByModifiedTime(
                                                        filteredNotoes);
                                              });
                                            },
                                            padding: const EdgeInsets.all(0),
                                            icon: const Icon(
                                              Icons.sort,
                                              color: Colors.green,
                                            )),
                                      ],
                                    ),
                                    cub.names.isNotEmpty
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
                                              // cub.getUserAttend(cub.ids[value]!);
                                              getMarathonData(cub.ids[value]!);
                                            },
                                            onSaved: (value) {
                                              selectedValue = value.toString();
                                            },
                                            buttonStyleData:
                                                const ButtonStyleData(
                                              padding:
                                                  EdgeInsets.only(right: 8),
                                            ),
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black45,
                                              ),
                                              iconSize: 24,
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
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
                                        : const CircularProgressIndicator(),
                                  ],
                                )),
                          ),
                        ),
                      ),
                      elevation: 9.0,
                    ),
                    filteredNotoes.isEmpty
                        ? const SliverToBoxAdapter(
                            child: LinearProgressIndicator(),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                                childCount: filteredNotoes.length,
                                (BuildContext context, int index) {
                              TextEditingController answerController =
                                  TextEditingController();
                              answerController.text =
                                  filteredNotoes[index].answer;
                              return Card(
                                  margin: const EdgeInsets.only(
                                      bottom: 5, right: 5, left: 5),
                                  color: Colors.greenAccent.shade100,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          title: RichText(
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(
                                                text:
                                                    '${filteredNotoes[index].title} \n',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.5,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: filteredNotoes[index]
                                                        .content,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 14,
                                                        height: 1.5),
                                                  )
                                                ]),
                                          ),
                                          subtitle: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              filteredNotoes[index]
                                                  .modifiedTime,
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.grey.shade800,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        defaultText(text: 'Answer'),
                                        defaultText(
                                            text: filteredNotoes[index].answer),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8),
                                          child: Text(
                                            filteredNotoes[index]
                                                .modifiedAnswerDate,
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.grey.shade800,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            }),
                          ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  void getMarathonData(String userId) {
    MarathonAnswerModel marathonAnswerModel;
    sampleNotes = [];
    firebaseReposatory.getMarathonData().then((value) {
      firebaseReposatory
          .getUserMarathonAnswerData(userId: userId)
          .then((answer) {
        for (int i = 0; i < value.docs.length; i++) {
          String ans = '', modifiedAnswerDate = '';
          for (int j = 0; j < answer.docs.length; j++) {
            if (value.docs[i].data()['id'] == answer.docs[j].id) {
              marathonAnswerModel = MarathonAnswerModel(
                value.docs[i].data()['id'],
                value.docs[i].data()['title'],
                value.docs[i].data()['content'],
                value.docs[i].data()['modifiedTime'],
                answer.docs[j].data()['modifiedTime'],
                answer.docs[j].data()['answer'],
              );
              sampleNotes.add(marathonAnswerModel);
            }
          }
        }
        filteredNotoes = sampleNotes;
        setState(() {});
      });
    });
  }
}
