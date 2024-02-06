import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_socialpulse/models/question.dart';
import 'package:mobile_socialpulse/providers/question_provicer.dart';
import 'package:provider/provider.dart';

import '../models/search_result.dart';
import '../utils/utils.dart';

class QnaPage extends StatefulWidget {
  const QnaPage({super.key});

  @override
  State<QnaPage> createState() => _QnaPageState();
}

class _QnaPageState extends State<QnaPage> {

  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();

  late QuestionProvider _questionProvider = QuestionProvider();
  SearchResult<Question>? questionResult;
  List<Question>? questions;

  final TextEditingController _questionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _questionProvider = context.read<QuestionProvider>();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      questionResult= await _questionProvider.getPaged(
          filter: {"pageSize": 50, "userId": int.parse(Authentification.tokenDecoded?["Id"])});
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        alertBoxMoveBack(context, "Error", e.toString());
      }
    }
    questions = questionResult!.items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Questions"),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),
      backgroundColor: const Color.fromARGB(255, 234, 242, 245),
      body:
      isLoading ?  const SpinKitFadingCircle(color: Colors.lightGreen) :
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child:
              Column(
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _questionController,
                    validator: (value){
                      if(value==null || value.isEmpty)
                        {
                          return "Please enter question text";
                        }
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      labelText: "Ask a question",
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FilledButton(
                  onPressed:
                      () async {

                      if(_formKey.currentState!.validate()) {
                        int userID = int.parse(
                            Authentification.tokenDecoded?["Id"]);
                        Question? newQuestion = Question(
                            null, _questionController.text, userID, null);

                        try {
                          await _questionProvider.insert(newQuestion);
                        } catch (e) {
                          if (mounted) {
                            alertBoxMoveBack(context, "Error", e.toString());
                          }
                        }

                        fetchData();
                        _questionController.clear();
                      }
                  },

                  child: const Text("Submit",style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 30),

                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: questions!.length,
                    itemBuilder: (context,index){
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Q: ${questions![index].text!}", style: const TextStyle(fontSize: 20)),
                            const SizedBox(height: 15),
                            questions![index].answer==null ?
                            const Text("Please wait for the answer", style: TextStyle(fontSize: 20))
                                : Text("A: ${questions![index].answer!.text}", style: const TextStyle(fontSize: 20)),
                            const SizedBox(height: 25),
                          ]);
                    }
                ),
              ],
            ),
        ),
      ),
    );
  }
}
