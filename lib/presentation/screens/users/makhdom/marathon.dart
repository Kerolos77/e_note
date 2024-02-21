import 'dart:core';

import 'package:e_note/presentation/widgets/global/default_button.dart';
import 'package:e_note/presentation/widgets/global/default_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constants/colors.dart';
import '../../../../data/firecase/firebase_reposatory.dart';
import '../../../../data/models/marathon_answer_model.dart';
import '../../../widgets/global/default_loading.dart';
import '../../../widgets/global/default_text/default_text.dart';
import '../../../widgets/global/default_text_field.dart';

class MakhdomMarathon extends StatefulWidget {
  const MakhdomMarathon({Key? key}) : super(key: key);

  @override
  State<MakhdomMarathon> createState() => _MakhdomMarathonState();
}

class _MakhdomMarathonState extends State<MakhdomMarathon> {
  FirebaseReposatory firebaseReposatory = FirebaseReposatory();
  List<MarathonAnswerModel> filteredNotoes = [];
  bool sorted = false;
  bool progressFlag = false;
  List<MarathonAnswerModel> sampleNotes = [];

  @override
  void initState() {
    super.initState();
    getMarathonData();
  }

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
    return Scaffold(
        backgroundColor: ConstColors.white,
        appBar: AppBar(
          backgroundColor: ConstColors.white,
          elevation: 0,
          title: TextField(
            onChanged: onSearchTextChange,
            style: const TextStyle(fontSize: 16, color: ConstColors.grey),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: "Search ...",
                hintStyle: const TextStyle(color: ConstColors.grey),
                prefixIcon: const Icon(Icons.search, color: ConstColors.grey),
                fillColor: ConstColors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Colors.transparent),
                )),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    filteredNotoes = sortNotesByModifiedTime(filteredNotoes);
                  });
                },
                padding: const EdgeInsets.all(0),
                icon: Icon(
                  sorted
                      ? FontAwesomeIcons.arrowDownWideShort
                      : FontAwesomeIcons.arrowDownShortWide,
                  color: ConstColors.primaryColor,
                )),
          ],
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: filteredNotoes.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredNotoes.length,
                      itemBuilder: (context, index) {
                        TextEditingController answerController =
                            TextEditingController();
                        answerController.text = filteredNotoes[index].answer;
                        return Card(
                            color: Colors.greenAccent.shade100,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: RichText(
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                          text:
                                              '${filteredNotoes[index].title} \n',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            height: 1.5,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  filteredNotoes[index].content,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11,
                                                height: 1.5,
                                              ),
                                            )
                                          ]),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        filteredNotoes[index].modifiedTime,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  DefaultTextField(
                                      control: answerController,
                                      type: TextInputType.multiline,
                                      maxLines: null,
                                      text: 'Type Your Answer'),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 0),
                                    child: Text(
                                      filteredNotoes[index].modifiedAnswerDate,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ),
                                  filteredNotoes[index].comment != ''
                                      ? ListTile(
                                          title: RichText(
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(
                                                text: 'Comment \n',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: filteredNotoes[index]
                                                        .comment,
                                                    style: const TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 12,
                                                    ),
                                                  )
                                                ]),
                                          ),
                                        )
                                      : const SizedBox(),
                                  defaultButton(
                                    text: 'Save',
                                    onPressed: () {
                                      if (answerController.text != '') {
                                        firebaseReposatory
                                            .createUserMarathonAnswer(
                                          marathonId: filteredNotoes[index].id,
                                          answer: answerController.text,
                                          comment:
                                              filteredNotoes[index].comment,
                                        )
                                            .then((value) {
                                          defaultSnackBar(
                                              message: 'Answer Saved',
                                              context: context);
                                        });
                                      }
                                    },
                                    width: MediaQuery.of(context).size.width,
                                  )
                                ],
                              ),
                            ));
                      },
                    )
                  : Center(
                      child: defaultText(
                        text: 'No Data Found',
                      ),
                    ),
            ),
            progressFlag
                ? Card(
                    elevation: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defaultText(text: 'wait until loading complete '),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultLoading(),
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ));
  }

  void getMarathonData() {
    progressFlag = true;

    MarathonAnswerModel marathonAnswerModel;
    sampleNotes = [];
    firebaseReposatory.getMarathonData().then((value) {
      firebaseReposatory.getUserMarathonAnswerData().then((answer) {
        for (int i = 0; i < value.docs.length; i++) {
          String ans = '', modifiedAnswerDate = '', comment = '';
          for (int j = 0; j < answer.docs.length; j++) {
            if (value.docs[i].data()['id'] == answer.docs[j].id) {
              ans = answer.docs[j].data()['answer'];
              modifiedAnswerDate = answer.docs[j].data()['modifiedTime'];
              comment = answer.docs[j].data()['comment'];
            }
          }
          marathonAnswerModel = MarathonAnswerModel(
            value.docs[i].data()['id'],
            value.docs[i].data()['title'],
            value.docs[i].data()['content'],
            value.docs[i].data()['modifiedTime'],
            modifiedAnswerDate,
            ans,
            comment,
          );
          sampleNotes.add(marathonAnswerModel);
        }
        filteredNotoes = sampleNotes;
        setState(() {
          progressFlag = false;
        });
      });
    });
  }
}
