import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/util/my_dimen.dart';
import 'package:aksestokomobile/screen/account/address_controller.dart';
import 'package:dropdownfield/dropdownfield.dart';

class AddAddressScreen extends StatefulWidget {
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends AddAddressController {
  @override
  Widget build(BuildContext context) {

    var formLayout = Container(
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * .1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    "Tambah Alamat Toko",
                    style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 60, right: 60, top: 50),
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), 
                  topRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 1),
                    color: Colors.black.withOpacity(0.40),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              onSaved: (value) => recipientsName = value,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: MyDimen.paddingTxtField(),
                                labelText: 'Nama Penerima',
                                labelStyle: TextStyle(
                                  color: MyColor.txtField,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: MyColor.txtField),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: MyColor.lineTxtField),
                                ),
                                errorText: 'Masukan Nama Penerima',
                                errorStyle: TextStyle(
                                  color: MyColor.txtField,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              onSaved: (value) => email = value,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                contentPadding: MyDimen.paddingTxtField(),
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  color: MyColor.txtField,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: MyColor.txtField),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: MyColor.lineTxtField),
                                ),
                                errorText: 'Masukan Email Anda',
                                errorStyle: TextStyle(
                                  color: MyColor.txtField,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              onSaved: (value) => tlp = value,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: MyDimen.paddingTxtField(),
                                labelText: 'No. Telepon',
                                labelStyle: TextStyle(
                                  color: MyColor.txtField,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: MyColor.txtField),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: MyColor.lineTxtField),
                                ),
                                errorText: 'Gunakan No Telepon yang valid untuk menerima SMS Kode Aktivasi',
                                errorStyle: TextStyle(
                                  color: MyColor.redAT,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              onSaved: (value) => address = value,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: MyDimen.paddingTxtField(),
                                labelText: 'Alamat',
                                labelStyle: TextStyle(
                                  color: MyColor.txtField,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: MyColor.txtField),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: MyColor.lineTxtField),
                                ),
                                errorText: 'Masukan Alamat Anda',
                                errorStyle: TextStyle(
                                  color: MyColor.txtField,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              onSaved: (value) => postalCode = value,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: MyDimen.paddingTxtField(),
                                labelText: 'Kode Pos',
                                labelStyle: TextStyle(
                                  color: MyColor.txtField,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: MyColor.txtField),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: MyColor.lineTxtField),
                                ),
                                errorText: 'Masukan Kode Pos',
                                errorStyle: TextStyle(
                                  color: MyColor.txtField,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 25),
                                  child: DropdownSearch(
                                    items: province,
                                    hint: "Pilih Provinsi",
//                                    onChanged: (String data) => _changeShipment(data, controller),
                                    showSearchBox: true,
                                    searchBoxDecoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                                      labelText: "Pilih Provinsi",
                                    ),
                                    validator: (String item) {
                                      if (item == null)
                                        return "Required field";
                                      else if (item == "Brazil")
                                        return "Invalid item";
                                      else
                                        return null;
                                    },

                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 25),
                                  child: DropDownField(
                                    controller: districtSelected,
                                    hintText: "Pilih Kabupaten",
                                    enabled: true,
                                    itemsVisibleInDropdown: 3,
                                    items: district,
                                    onValueChanged: (value) {
                                      setState(() {
                                        selectDistrict = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 25),
                                  child: DropDownField(
                                    controller: subDistrictSelected,
                                    hintText: "Pilih Kecamatan",
                                    enabled: true,
                                    itemsVisibleInDropdown: 3,
                                    items: subDistrict,
                                    onValueChanged: (value) {
                                      setState(() {
                                        selectSubDistrict = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 25),
                                  child: DropDownField(
                                    controller: villageSelected,
                                    hintText: "Pilih Desa",
                                    enabled: true,
                                    itemsVisibleInDropdown: 3,
                                    items: village,
                                    onValueChanged: (value) {
                                      setState(() {
                                        selectVillage = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: FlatButton(
                                color: MyColor.redAT,
                                child: Text(
                                  'Simpan',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: (){},
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(30.0))),
                          ),
                          Padding(padding: EdgeInsets.only(top: 30)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Stack(
      children: <Widget>[
        Image.asset(
          bgLarge,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: formLayout,
          ),
        )
      ],
    );

  }
}