import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:smart_control/controller/lampe_notifier.dart';
import 'package:smart_control/storage.dart';
import 'package:smart_control/widgets/error_modal.dart';

class Services {
  void changeLampeEtat(bool etat, BuildContext ctx) async {
    var url;
    if (etat) {
      url =
          Uri.parse('http://${Storage().getString('adresseIp')}/app/LAMPE=ON');
    } else {
      url =
          Uri.parse('http://${Storage().getString('adresseIp')}/app/LAMPE=OFF');
    }

    try {
      var response =
          await http.get(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        print(response.body);
        ctx.read<LampeNotifier>().setIsOn();
      } else if (response.statusCode == 400) {
        var data = jsonDecode(response.body);
        print(data);
        showErrorPopup(
            ctx, "Erreur lors de la requête", "Erreur de connexion", null);
      }
    } catch (e) {
      print(e);
      showErrorPopup(
          ctx, "Vérifier votre connexion au réseau.", "Erreur de connexion", null);
    }
  }
}
