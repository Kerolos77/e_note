// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';
//
// import '../business_logic/cubit/attendance_cubit/view_marathon_team_cubit.dart';
// import 'mobile.dart';
//
// class PdfHelper {
//   static Future<void> createPDF(
//       AttendCubit attendCub, String name, String id) async {
//     PDF(attendCub, name, id, []);
//   }
//
//   static Future<void> PDF(AttendCubit attendCub, String name, String id,
//       List<int> totalTime) async {
//     final pdf = pw.Document();
//     var data = await rootBundle.load("fonts/cairoFont/Cairo-Black.ttf");
//     var myFont = Font.ttf(data);
//     pdf.addPage(pw.MultiPage(
//         pageFormat: PdfPageFormat.a4,
//         margin: const pw.EdgeInsets.all(10), // This is the page margin
//         build: (pw.Context context) {
//           return <pw.Widget>[
//             pw.Header(
//                 level: 0,
//                 child: pw.Container(
//                     width: double.infinity,
//                     child: pw.Column(
//                         crossAxisAlignment: pw.CrossAxisAlignment.end,
//                         children: <pw.Widget>[
//                           pw.Text('تقرير الحضور والغياب \n\nالاسم : $name\n',
//                               style: pw.TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: pw.FontWeight.bold,
//                                 height: 1.5,
//                                 font: myFont,
//                               ),
//                               textDirection: pw.TextDirection.rtl),
//                         ]))),
//             pw.Table.fromTextArray(
//               context: context,
//               data: [
//                 [
//                   '23 - 12',
//                   '23 - 12',
//                   '23 - 12',
//                   '23 - 12',
//                   '23 - 12',
//                   '23 - 12',
//                   '23 - 12'
//                 ],
//                 // for (var i = 0; i < attendCub.attendModelList.length; i++)
//                 //   [
//                 //     i + 1,
//                 //     attendCub.attendModelList[i]['date'],
//                 //     attendCub.attendModelList[i]['startTime'],
//                 //     attendCub.attendModelList[i]['endTime'],
//                 //     attendCub.attendModelList[i]['timeInDay'],
//                 //   ],
//               ],
//               cellAlignment: pw.Alignment.center,
//               cellStyle: const pw.TextStyle(fontSize: 12),
//             ),
//             pw.SizedBox(height: 20),
//             // pw.Table.fromTextArray(
//             //   context: context,
//             //   data: [
//             //     ['Salary', 'Count', 'price', 'Total'],
//             //     [
//             //       'Days',
//             //       '${totalTime[0]}',
//             //       '${totalTime[3]}',
//             //       '${totalTime[6]}'
//             //     ],
//             //     [
//             //       'Hours',
//             //       '${totalTime[1]}',
//             //       '${totalTime[4]}',
//             //       '${totalTime[7]}'
//             //     ],
//             //     [
//             //       'Minutes',
//             //       '${totalTime[2]}',
//             //       '${totalTime[5]}',
//             //       '${totalTime[8]}'
//             //     ],
//             //     ['', '', '', '${totalTime[6] + totalTime[7] + totalTime[8]}'],
//             //   ],
//             //   cellAlignment: pw.Alignment.center,
//             //   cellStyle: pw.TextStyle(
//             //     fontSize: 12,
//             //     color: PdfColor.fromHex('#ff0000'),
//             //   ),
//             // ),
//           ];
//         }));
//     saveAndLaunchFile(await pdf.save(),
//         'Attend Repo(${DateFormat('yyyy-MM-dd').format(DateTime.now())}) $id.pdf');
//   }
// }
