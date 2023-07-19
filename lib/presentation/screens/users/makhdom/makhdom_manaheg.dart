import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_note/presentation/widgets/global/default_text/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../business_logic/cubit/manaheg/manaheg_cubit.dart';
import '../../../../business_logic/cubit/manaheg/manaheg_states.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../widgets/global/toast.dart';
import '../../regisation_screen.dart';

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
      create: (BuildContext context) => ManahegCubit(),
      child: BlocConsumer<ManahegCubit, ManahegStates>(
          listener: (BuildContext context, ManahegStates state) {
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
          body: ConditionalBuilder(
            condition: (!progressFlag),
            builder: (BuildContext context) {
              return Center(
                child: defaultText(text: 'manaheg'),
              );
            },
            fallback: (BuildContext context) {
              return Center(child: CircularProgressIndicator());
            },
          ),
        );
      }),
    );
  }
}
