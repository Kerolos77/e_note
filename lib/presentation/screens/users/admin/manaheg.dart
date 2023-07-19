import 'package:e_note/presentation/widgets/global/default_text/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../business_logic/cubit/manaheg/manaheg_cubit.dart';
import '../../../../business_logic/cubit/manaheg/manaheg_states.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../widgets/global/toast.dart';
import '../../regisation_screen.dart';

class Manaheg extends StatefulWidget {
  const Manaheg({super.key});

  @override
  State<Manaheg> createState() => _ManahegState();
}

class _ManahegState extends State<Manaheg> {
  bool progressFlag = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    late ManahegCubit cub;
    return BlocProvider(
      create: (BuildContext context) =>
      ManahegCubit()
        ..getMnaheg(),
      child: BlocConsumer<ManahegCubit, ManahegStates>(
          listener: (BuildContext context, ManahegStates state) {
            print('--------------------------- $state');

            if (state is LogOutSuccessManahegState) {
              showToast(
                message: 'Log out Successfully',
              );
              CacheHelper.removeData(key: "user");
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Registration(),
                  ));
            }
            if (state is GetManahegLoadingManahegState) {
              progressFlag = true;
            }
            if (state is GetManahegSuccessManahegState) {
              progressFlag = false;
              showToast(message: 'Done');
            }
            if (state is UploadFileLoadingManahegState) {
              progressFlag = true;
            }
            if (state is UploadFileSuccessManahegState) {
              progressFlag = false;
              showToast(message: 'Done');
            }
            if (state is UploadFileErrorManahegState) {
              progressFlag = false;
              showToast(message: state.error);
            }
          }, builder: (BuildContext context, ManahegStates state) {
        cub = ManahegCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  cub.logout();
                },
                icon: const Icon(
                  FontAwesomeIcons.signOutAlt,
                  size: 20,
                  color: Colors.green,
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              cub.uploadPic();
            },
            child: const Icon(FontAwesomeIcons.add),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: cub.pdfNames.isNotEmpty
                    ? ListView.separated(
                  itemBuilder: (context, index) =>
                      Card(
                        child: GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(
                                Icons.picture_as_pdf,
                                size: 60,
                              ),
                              defaultText(text: cub.pdfNames[index])
                            ],
                          ),
                          onTap: () async {
                            // final Uri _url = Uri.parse(cub.pdfUrl[index]);
                            // await launchUrl(_url);
                          },
                        ),
                      ),
                  separatorBuilder: (context, index) =>
                  const SizedBox(height: 10),
                  itemCount: cub.pdfNames.length,
                )
                    : Center(
                  child: defaultText(
                    text: 'No Coupons Found',
                  ),
                ),
              ),
              progressFlag
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  defaultText(text: 'wait until loading complete '),
                  const SizedBox(
                    height: 30,
                  ),
                  const CircularProgressIndicator(),
                ],
              )
                  : SizedBox(),
            ],
          ),
        );
      }),
    );
  }

// Future<void> _launchUrl() async {
//   if (!await launchUrl(_url)) {
//     throw Exception('Could not launch $_url');
//   }
// }
}