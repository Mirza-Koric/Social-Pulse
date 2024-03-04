import 'package:admin_socialpulse/models/question.dart';
import 'package:admin_socialpulse/providers/answer_provider.dart';
import 'package:admin_socialpulse/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class QuestionDetails extends StatefulWidget {
  final Question question;
  const QuestionDetails({required this.question, super.key});

  @override
  State<QuestionDetails> createState() => _QuestionDetailsState();
}

class _QuestionDetailsState extends State<QuestionDetails> {
  final _formKey = GlobalKey<FormBuilderState>();

  late AnswerProvider _answerProvider = AnswerProvider();

  @override
  void initState() {
    super.initState();
    _answerProvider = context.read<AnswerProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(20),
        child: FormBuilder(
          key: _formKey,
          child: Column(children: [
            const Text("Question", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            FormBuilderTextField(
              decoration: customInputDecoration(hint: "Question"),
              name: "question",
              initialValue: widget.question.text,
              enabled: false,
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              decoration: customInputDecoration(hint: "Answer"),
              name: "answer",
              initialValue: widget.question.answer == null
                  ? ""
                  : widget.question.answer!.text,
              maxLines: 6,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Must input answer";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 10),
            Row(children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close")),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      _formKey.currentState?.save();
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> formValues =
                            Map.of(_formKey.currentState!.value);

                        var request = {
                          'id': widget.question.answer == null
                              ? 0
                              : widget.question.answer!.id,
                          'text': formValues['answer'],
                          'adminId': Authentification.tokenDecoded?['Id'],
                          'questionId': widget.question.id
                        };

                        //print(request);

                        if (widget.question.answer == null) {
                          await _answerProvider.insert(request);
                        } else if (widget.question.answer != null) {
                          await _answerProvider.update(request);
                        }

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Successfully added/updated answer")));
                          Navigator.pop(context, "refresh");
                        }
                      }
                    } catch (e) {
                      if (mounted) {
                        alertBox(context, "Error", e.toString());
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen),
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.black),
                  ))
            ])
          ]),
        ),
      ),
    );
  }
}
