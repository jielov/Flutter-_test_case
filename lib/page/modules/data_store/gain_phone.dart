import 'dart:html';

import 'package:flutter/material.dart';

import 'package:device_info/device_info.dart';

class GainPhone extends StatefulWidget {
  @override
  _GainPhoneState createState() => _GainPhoneState();
}

class _GainPhoneState extends State<GainPhone> {
  @override
  void initState() async {
    // TODO: implement initState
    super.initState();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"

    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    print('Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('data'),
    );
  }

}
