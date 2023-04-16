import 'package:flutter/material.dart';
import 'package:translator_clone/core/coustem_sizedbox.dart';

import 'package:translator_clone/data/api/translation_api.dart';
import '../../core/bottom_style.dart';
import '../../core/box_style.dart';
import '../../data/api/detect_language.dart';
import '../components/bottom_sheet.dart';
import '../components/language_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String currentLanguage = 'en';
  String targetLanguage = 'ml';
  TextEditingController currentLanguageController = TextEditingController();
  String translatedText = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Translator'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              coustemBox(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          shape: roundedRectangleBorder,
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                child: LanguageSelectionScreen(
                                  onLanguageSelected: (language) {
                                    setState(() {
                                      currentLanguage = language;
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        languagNames[currentLanguage]!,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  coustemBox(40),
                  SizedBox(
                    height: 50,
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          shape: roundedRectangleBorder,
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                child: LanguageSelectionScreen(
                                  onLanguageSelected: (language) {
                                    setState(() {
                                      targetLanguage = language;
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        languagNames[targetLanguage]!,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              coustemBox(20),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, bottom: 7),
                child:
                    Text("Translate From | ${languagNames[currentLanguage]}"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: boxDecoration,
                  height: 200,
                  child: TextField(
                    onChanged: (value) async {
                      final String detect =
                          await detectLanguage(currentLanguageController.text);
                      setState(() {
                        currentLanguage = detect.toString();
                      });
                    },
                    maxLines: null,
                    controller: currentLanguageController,
                    decoration: const InputDecoration(
                      hintText: 'Text here...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              coustemBox(10),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                height: 40,
                width: 150,
                child: ElevatedButton(
                    onPressed: () async {
                      if (currentLanguageController.text.isEmpty ||
                          currentLanguage.isEmpty ||
                          targetLanguage.isEmpty) {
                        setState(() {
                          translatedText =
                              'Please select a language and enter some text.';
                        });
                      } else {
                        final String transl = await translate(
                            currentLanguageController.text,
                            currentLanguage,
                            targetLanguage);
                        setState(() {
                          translatedText = transl.toString();
                        });
                      }
                    },
                    child: const Text(
                      "Translate",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    )),
              ),
              coustemBox(10),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, bottom: 7),
                child: Text("Translate To | ${languagNames[targetLanguage]}"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: boxDecoration,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Text(translatedText)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
