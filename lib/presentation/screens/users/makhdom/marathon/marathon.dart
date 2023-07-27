import 'dart:core';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../data/models/marathon_model.dart';
import '../../../../widgets/global/default_text/default_text.dart';
import 'marathon_edit.dart';

class MakhdomMarathon extends StatefulWidget {
  const MakhdomMarathon({Key? key}) : super(key: key);

  @override
  State<MakhdomMarathon> createState() => _MakhdomMarathonState();
}

class _MakhdomMarathonState extends State<MakhdomMarathon> {
  List<MarathonModel> filteredNotoes = [];
  bool sorted = false;
  List<MarathonModel> sampleNotes = [
    MarathonModel(
      '0',
      'سؤال الماراثون',
      'ماذا كانت نهاية ابيمالك اذكر الآية و الشاهد من الاصحاح ؟',
      DateTime(2022, 1, 1, 34, 5).toString(),
    ),
    MarathonModel(
      '1',
      'سؤال الماراثون',
      '1. Chicken Alfredo\n2. Vegan chili\n3. Spaghetti carbonara\n4. Chocolate lava cake',
      DateTime(2022, 1, 1, 34, 5).toString(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    filteredNotoes = sampleNotes;
  }

  List<MarathonModel> sortNotesByModifiedTime(List<MarathonModel> notes) {
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

  void deleteNote(int index) {
    setState(() {
      MarathonModel note = filteredNotoes[index];
      sampleNotes.remove(note);
      filteredNotoes.removeAt(index);
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
              child: ListView.builder(
            padding: const EdgeInsets.only(top: 30),
            itemCount: filteredNotoes.length,
            itemBuilder: (context, index) {
              return Card(
                  margin: const EdgeInsets.only(bottom: 20),
                  color: Colors.green.shade50,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MarathonEdit.MarathonEdit(
                                    note: filteredNotoes[index]),
                          ),
                        );
                        if (result != null) {
                          setState(() {
                            int oraginalIndex =
                                sampleNotes.indexOf(filteredNotoes[index]);
                            sampleNotes[oraginalIndex] = MarathonModel(
                                sampleNotes[oraginalIndex].id,
                                result[0],
                                result[1],
                                DateTime.now().toString());
                            filteredNotoes[index] = MarathonModel(
                                filteredNotoes[index].id,
                                result[0],
                                result[1],
                                DateTime.now().toString());
                          });
                        }
                      },
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
                                text: '${filteredNotoes[index].content}',
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
                          'Edited:${DateFormat('EEE MMM  d, yyy  h:mm a').format(DateTime.parse(filteredNotoes[index].modifiedTime))}',
                          style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ),
                  ));
            },
          ))
        ],
      ),
    );
  }
}
