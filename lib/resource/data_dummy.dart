import 'dart:math';

class DataDummy {
  static Map<String, dynamic> getProvinsi({status, data}) {
    return {
      "code": 200,
      "success": true,
      "data": [
        {"id": 13, "name": "SUMATERA BARAT"},
        {"id": 31, "name": "DKI JAKARTA"},
        {"id": 35, "name": "JAWA TIMUR"},
      ]
    };
  }

  static Map<String, dynamic> getKabupaten({status, data}) {
    return {
      "code": 200,
      "success": true,
      "data": [
        {"id": 3525, "name": "KABUPATEN Gresik"},
        {"id": 3526, "name": "KABUPATEN Bangkalan"},
        {"id": 3578, "name": "Kota Surabaya"},
      ]
    };
  }

  static Map<String, dynamic> getKecamatan({status, data}) {
    return {
      "code": 200,
      "success": true,
      "data": [
        {"id": 3526010, "name": "KAMAL"},
        {"id": 3526110, "name": "BANGKALAN"},
        {"id": 3526130, "name": "AROSBAYA"},
        {"id": 3525040, "name": "MENGANTI"}
      ]
    };
  }

  static Map<String, dynamic> getDesa({status, data}) {
    return {
      "code": 200,
      "success": true,
      "data": [
        {"id": 3526110001, "name": "UJUNG PIRING"},
        {"id": 3526110002, "name": "SEMBILANGAN"},
        {"id": 3526110006, "name": "KEMAYORAN"},
        {"id": 3526110008, "name": "DEMANGAN"},
        {"id": 3525040004, "name": "MENGANTI"},
      ]
    };
  }

  static Map<String, dynamic> getPostalcode({status, data}) {
    var rand = Random().nextDouble();
    print('cek rand $rand');
    return {
      "status": "success",
      "code": 200,
      "message": "Get Postal Code success",
      "request_time": "2021-01-21 15:01:47",
      "response_time": "2021-01-21 15:01:55",
      "rows": 3,
      "data": {
        "success": true,
        "message": "success",
        "data": [
          if (rand > 0.3)
            {
              "province": "Jawa Timur",
              "city": "Bangkalan",
              "subdistrict": "Bangkalan",
              "urban": "Kemayoran",
              "postalcode": "69118"
            },
          {
            "province": "Jawa Timur",
            "city": "Bangkalan",
            "subdistrict": "Bangkalan",
            "urban": "Kemayoran",
            "postalcode": "69116"
          },
        ]
      }
    };
  }
}
