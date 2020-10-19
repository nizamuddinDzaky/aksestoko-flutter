import 'package:aksestokomobile/resource/my_image.dart';

class Principal {
  int principalId;
  String name;
  String iconPrincipal1;
  String iconPrincipal2;
  String iconPrincipal3;

  Principal(
      {this.principalId,
      this.name,
      this.iconPrincipal1,
      this.iconPrincipal2,
      this.iconPrincipal3});

  static List<Principal> getPrincipals() {
    return <Principal>[
      Principal(
          principalId: 1,
          name: "SIG",
          iconPrincipal1: sgIcon,
          iconPrincipal2: stIcon,
          iconPrincipal3: spIcon),
      Principal(principalId: 2, name: "SBI", iconPrincipal1: dynamixIcon),
    ];
  }
}
