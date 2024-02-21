import 'package:e_note/constants/colors.dart';
import 'package:e_note/presentation/widgets/global/default_text/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../business_logic/cubit/manaheg/manaheg_cubit.dart';
import '../../../../business_logic/cubit/manaheg/manaheg_states.dart';
import '../../../widgets/global/default_loading.dart';

class MakhdomManaheg extends StatefulWidget {
  const MakhdomManaheg({super.key});

  @override
  State<MakhdomManaheg> createState() => _MakhdomManahegState();
}

class _MakhdomManahegState extends State<MakhdomManaheg> {
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
      create: (BuildContext context) => ManahegCubit()..getMnaheg(),
      child: BlocConsumer<ManahegCubit, ManahegStates>(
          listener: (BuildContext context, ManahegStates state) {
        if (state is GetManahegLoadingManahegState) {
          progressFlag = true;
        }
        if (state is GetManahegSuccessManahegState) {
          progressFlag = false;
        }
      }, builder: (BuildContext context, ManahegStates state) {
        cub = ManahegCubit.get(context);
        return Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: cub.pdfNames.isNotEmpty
                    ? ListView.separated(
                        itemBuilder: (context, index) => Card(
                          child: GestureDetector(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.picture_as_pdf,
                                    size: 30,
                                    color: ConstColors.primaryColor,
                                  ),
                                ),
                                Expanded(
                                    child: defaultText(
                                        text: cub.pdfNames[index],
                                        overflow: false))
                              ],
                            ),
                            onTap: () async {
                              final Uri _url = Uri.parse(cub.pdfUrl[index]);
                              // await launchUrl(_url);
                              await launch(cub.pdfUrl[index]);
                            },
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: cub.pdfNames.length,
                      )
                    : Center(
                        child: defaultText(
                          text: 'No Manaheg Found',
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
          ),
        );
      }),
    );
  }
}
