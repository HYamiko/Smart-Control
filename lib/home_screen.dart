import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';
import 'package:smart_control/controller/lampe_notifier.dart';
import 'package:smart_control/services.dart';
import 'package:smart_control/widgets/dialog_widget.dart';

import 'controller/button_visibility_notifier.dart';
import 'kcolors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kolors.kPrimary,
        title: const Text(
          'Smart Control',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Image.asset(
                context.watch<LampeNotifier>().isOn
                    ? 'assets/images/lampe_on.png'
                    : 'assets/images/lampe_off.png',
                height: 400.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              Visibility(
                  visible: context.watch<ButtonVisibilityNotifier>().isVisible,
                  child: LiteRollingSwitch(
                    value: false,
                    animationDuration: const Duration(milliseconds: 400),
                    textOn: "ON",
                    textOff: "OFF",
                    colorOn: Colors.green,
                    colorOff: Colors.red,
                    textOnColor: Colors.white,
                    iconOn: Icons.lightbulb_outline,
                    iconOff: Icons.power_settings_new,
                    onTap: () {},
                    onDoubleTap: () {},
                    onSwipe: () {},
                    onChanged: (v) {
                      print(v);
                      Services().changeLampeEtat(v, context);
                    },
                  ))
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dialogAddress(context);
        },
        tooltip: 'Editer',
        backgroundColor: Kolors.kPrimary,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}
