import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class VersionScreen extends StatefulWidget {
  @override
  _VersionScreenState createState() => _VersionScreenState();
}

class _VersionScreenState extends State<VersionScreen> {
  PackageInfo packageInfo;

  getVersionApp() {
    PackageInfo.fromPlatform().then((packageInfo) {
      setState(() {
        this.packageInfo = packageInfo;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getVersionApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            packageInfo == null
                ? ''
                : 'v ${packageInfo?.version ?? ''}.${packageInfo.buildNumber}',
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
