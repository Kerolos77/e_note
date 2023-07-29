import 'dart:core';

import 'package:e_note/constants/conestant.dart';
import 'package:e_note/presentation/widgets/global/default_button.dart';
import 'package:e_note/presentation/widgets/global/toast.dart';
import 'package:flutter/material.dart';

import '../../../../data/firecase/firebase_reposatory.dart';
import '../../../../data/models/marathon_answer_model.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: defaultText(text: 'Marathon', size: 30),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  filteredNotoes = sortNotesByModifiedTime(filteredNotoes);
                });
              },
              padding: const EdgeInsets.all(0),
              icon: const Icon(
                Icons.sort,
                color: Colors.green,
              )),
        ],
      ),
      body: Column(
        children: [
          TextField(
            onChanged: onSearchTextChange,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: "Search ...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                fillColor: Colors.white,
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
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 30),
              itemCount: filteredNotoes.length,
              itemBuilder: (context, index) {
                TextEditingController answerController =
                    TextEditingController();
                answerController.text = filteredNotoes[index].answer;
                return Card(
                    margin: const EdgeInsets.only(bottom: 20),
                    color: Colors.greenAccent.shade100,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: RichText(
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                  text: '${filteredNotoes[index].title} \n',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    height: 1.5,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: filteredNotoes[index].content,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          height: 1.5),
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
                          defaultTextField(
                              control: answerController,
                              type: TextInputType.text,
                              text: 'Type Your Answer'),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Text(
                              filteredNotoes[index].modifiedAnswerDate,
                              style: TextStyle(
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ),
                          defaultButton(
                            text: 'Save',
                            onTap: () {
                              if (answerController.text != '') {
                                firebaseReposatory
                                    .createUserMarathonAnswer(
                                        marathonId: filteredNotoes[index].id,
                                        answer: answerController.text)
                                    .then((value) {
                                  showToast(message: 'Answer Saved');
                                });
                              }
                            },
                            width: MediaQuery.of(context).size.width,
                          )
                        ],
                      ),
                    ));
              },
            ),
          ))
        ],
      ),
    );
  }

  void getMarathonData() {
    MarathonAnswerModel marathonAnswerModel;
    sampleNotes = [];
    firebaseReposatory.getMarathonData().then((value) {
      firebaseReposatory
          .getUserMarathonAnswerData(userId: constUid)
          .then((answer) {
        for (int i = 0; i < value.docs.length; i++) {
          String ans = '', modifiedAnswerDate = '';
          for (int j = 0; j < answer.docs.length; j++) {
            if (value.docs[i].data()['id'] == answer.docs[j].id) {
              ans = answer.docs[j].data()['answer'];
              modifiedAnswerDate = answer.docs[j].data()['modifiedTime'];
            }
          }
          marathonAnswerModel = MarathonAnswerModel(
            value.docs[i].data()['id'],
            value.docs[i].data()['title'],
            value.docs[i].data()['content'],
            value.docs[i].data()['modifiedTime'],
            modifiedAnswerDate,
            ans,
          );
          sampleNotes.add(marathonAnswerModel);
        }
        filteredNotoes = sampleNotes;
        setState(() {});
      });
    });
  }
}
