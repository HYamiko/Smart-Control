import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../controller/button_visibility_notifier.dart';
import '../kcolors.dart';
import '../storage.dart';

Future<dynamic> dialogAddress(BuildContext context) {
  TextEditingController textController = TextEditingController();
  textController.text = (Storage().getString('adresseIp') ?? '');
  String errorMessage = '';
  return showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateForDialog) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            scrollable: true,
            title: const Text(
              "Adresse IP",
              textAlign: TextAlign.center,
            ),
            contentPadding: const EdgeInsets.all(20),
            content: Column(
              children: [
                SizedBox(
                  height: 45.h,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    /*inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],*/
                    enableInteractiveSelection: false,
                    controller: textController,
                    decoration: InputDecoration(
                        counterText: '',
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.w),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.w),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)))),
                  ),
                ),
                Visibility(
                    visible: errorMessage == '' ? false : true,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          errorMessage,
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 15.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Kolors.kPrimary,
                    fixedSize:
                        Size(MediaQuery.of(context).size.width / 1.6.w, 50.h),
                  ),
                  onPressed: () {
                    setStateForDialog(() {
                      if (textController.text == '') {
                        errorMessage = "Entrez une adresse IP";
                      } else if (!validateIp(textController.text)) {
                        errorMessage = "Entrez une adresse IP valide";
                      } else {
                        //Storage().clear();
                        if (Storage().getString("adresseIp") == null) {
                          context
                              .read<ButtonVisibilityNotifier>()
                              .setIsVisible();
                        }
                        Storage().setString('adresseIp', textController.text);

                        Navigator.pop(context);
                      }
                    });
                  },
                  child: const Text(
                    'Valider',
                    style: TextStyle(
                        color: Colors.white, backgroundColor: Kolors.kPrimary),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Annuler"))
              ],
            ),
          );
        });
      });
}

bool validateIp(String ip) {
  final RegExp regex = RegExp(r'^(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.'
      r'(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.'
      r'(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.'
      r'(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])$');
  return regex.hasMatch(ip);
}
