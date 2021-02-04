import 'package:aksestokomobile/resource/my_image.dart';

class Principal {
  int principalId;
  String name;
  String value;
  String iconPrincipal1;
  String iconPrincipal2;
  String iconPrincipal3;

  Principal(
      {this.principalId,
      this.name,
      this.value,
      this.iconPrincipal1,
      this.iconPrincipal2,
      this.iconPrincipal3});

  static List<Principal> getPrincipals() {
    return <Principal>[
      Principal(
          principalId: 1,
          name: "SIG",
          value: "SMI",
          iconPrincipal1: sgIcon,
          iconPrincipal2: stIcon,
          iconPrincipal3: spIcon),
      Principal(principalId: 2, name: "SBI", iconPrincipal1: dynamixIcon),
      Principal(principalId: 3, name: "SBA", iconPrincipal1: andalasIcon),
    ];
  }
}
