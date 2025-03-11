import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingualift/common/app_images.dart';
import 'package:lingualift/cubit/new_word/new_word_cubit.dart';

class NewWordWrapperWidget extends StatelessWidget {
  const NewWordWrapperWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewWordCubit>(
      create: (_) => NewWordCubit()
        ..fetchData(),
      child: NewWordPage(),
    );
  }

}

class NewWordPage extends StatefulWidget {
  const NewWordPage({super.key});

  @override
  State<NewWordPage> createState() => _NewWordPageState();
}

class _NewWordPageState extends State<NewWordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.paperBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 79 - MediaQuery.of(context).padding.top,
                left: 159,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'New words',
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.25,
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: BlocBuilder<NewWordCubit, NewWordState>(
                        builder: (blocContext, state) {
                          if (state.status == LoadStatus.loading) {
                            return SizedBox.shrink();
                          }
                          if (state.status == LoadStatus.failure) {
                            return Center(
                              child: Text('Failure'),
                            );
                          }
                          if (state.status == LoadStatus.success) {
                            return Center(
                              child: Text('${state.listNewWord?.length ?? 0}'),
                            );
                          }
                          return Center(
                            child: Text('Init'),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 75 - MediaQuery.of(context).padding.top,
                left: 30,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      size: 30,
                      Icons.arrow_back_ios_outlined,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}