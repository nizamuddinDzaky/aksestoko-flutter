import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckPermissionScreen extends StatefulWidget {
  @override
  _CheckPermissionScreenState createState() => _CheckPermissionScreenState();
}

class _CheckPermissionScreenState extends State<CheckPermissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Periksa Izin'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              var hasOpened = openAppSettings();
              debugPrint('App Settings opened: ' + hasOpened.toString());
            },
          ),
        ],
      ),
      body: Center(
        child: ListView(
            children: [
          Permission.notification,
          // Permission.camera,
          // Permission.photos,
          // Permission.mediaLibrary,
          Permission.storage,
        ].map((permission) => PermissionWidget(permission)).toList()),
      ),
    );
  }
}

class PermissionWidget extends StatefulWidget {
  /// Constructs a [PermissionWidget] for the supplied [Permission].
  const PermissionWidget(this._permission);

  final Permission _permission;

  @override
  _PermissionState createState() => _PermissionState(_permission);
}

class _PermissionState extends State<PermissionWidget> {
  _PermissionState(this._permission);

  final Permission _permission;
  PermissionStatus _permissionStatus = PermissionStatus.undetermined;

  String get permissionStatus => {
        PermissionStatus.undetermined: 'Belum pernah diakses',
        PermissionStatus.granted: 'Diizinkan',
        PermissionStatus.denied: 'Tidak diizinkan',
        PermissionStatus.restricted: 'Dibatasi',
        PermissionStatus.permanentlyDenied: 'Ditolak permanen',
      }[_permissionStatus];

  String get permission => {
        Permission.notification: 'Menerima Notifikasi',
        Permission.camera: 'Akses Kamera',
        Permission.photos: 'Akses Foto',
        Permission.mediaLibrary: 'Akses Media',
        Permission.storage: 'Akses Penyimpanan',
      }[_permission];

  @override
  void initState() {
    super.initState();

    _listenForPermissionStatus();
  }

  void _listenForPermissionStatus() async {
    final status = await _permission.status;
    setState(() => _permissionStatus = status);
  }

  Color getPermissionColor() {
    switch (_permissionStatus) {
      case PermissionStatus.denied:
        return Colors.red;
      case PermissionStatus.granted:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(permission ?? ''),
      subtitle: Text(
        permissionStatus,
        style: TextStyle(color: getPermissionColor()),
      ),
      // trailing: IconButton(
      //     icon: const Icon(Icons.info),
      //     onPressed: () {
      //       checkServiceStatus(context, _permission);
      //     }),
      onTap: () {
        requestPermission(_permission);
      },
    );
  }

  void checkServiceStatus(BuildContext context, Permission permission) async {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text((await permission.status).toString()),
    ));
  }

  Future<void> requestPermission(Permission permission) async {
    var before = await permission.status;
    final status = await permission.request();

    if (before == status && before.isUndetermined) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Belum memerlukan izin'),
      ));
      return;
    }

    setState(() {
      _permissionStatus = status;
    });
  }
}
