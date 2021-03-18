import 'package:aksestokomobile/model/zone.dart';
import 'package:aksestokomobile/util/my_util.dart';
import 'package:aksestokomobile/view_model/account/address_view_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:aksestokomobile/resource/my_image.dart';
import 'package:aksestokomobile/util/my_dimen.dart';
import 'package:flutter/services.dart';

class AddAddressScreen extends StatefulWidget {
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends AddressViewModel {
  // AddressController vm;

  Widget _formLayout() {
    /*selectProvince = Zone(name: "jawa selatan");*/
    return Container(
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
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
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
              child: complete == null ?
                Center(child: CircularProgressIndicator()) :
              SingleChildScrollView(
                padding: EdgeInsets.only(left: 60, right: 60, top: 50),
                child: Column(
                  children: <Widget>[
                    Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              onSaved: (value) {
                                // vm?.saveForm(namaPenerima: value);
                                saveForm(namaPenerima: value);
                              },
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
                                  borderSide:
                                  BorderSide(color: MyColor.txtField),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: MyColor.lineTxtField),
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
                              onSaved: (value) {
                                // vm?.saveForm(email: value);
                                saveForm(email: value);
                              },
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
                                  borderSide:
                                  BorderSide(color: MyColor.txtField),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: MyColor.lineTxtField),
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
                              controller: noTlpnController,
                              onChanged: (text){
                                noTlpnController = cursorToEnd(trimMobilePhoneNumber(text));
                                setState(() {});
                              },
                              onSaved: (value) {
                                      // vm?.saveForm(noTlpn: value);
                                      saveForm(noTlpn: value);
                                    },
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                      decimal: false,
                                      signed: true,
                                    ),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    maxLength: 13,
                                    decoration: InputDecoration(
                                      contentPadding: MyDimen.paddingTxtField(),
                                      labelText: 'No. Telepon',
                                      prefixText: '+62',
                                      labelStyle: TextStyle(
                                        color: MyColor.txtField,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: MyColor.txtField),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: MyColor.lineTxtField),
                                      ),
                                      errorText:
                                          'Gunakan No Telepon yang valid untuk menerima SMS Kode Aktivasi',
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
                              onSaved: (value) {
                                // vm?.saveForm(alamat: value);
                                saveForm(alamat: value);
                              },
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
                                  borderSide:
                                  BorderSide(color: MyColor.txtField),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                            color: MyColor.lineTxtField),
                                      ),
                                      errorText: 'Masukan Alamat Anda',
                                      errorStyle: TextStyle(
                                        color: MyColor.txtField,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ),
                                if (skenario == 1)
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      controller: kodePosController,
                                      // onEditingComplete: () {
                                      //   if (kodePosController.text != "")
                                      //     getRegionByPostalCode();
                                      //   /*nodeKodePos.nextFocus();*/
                                      // },
                                      focusNode: nodeKodePos,
                                      onSaved: (value) {
                                        // vm?.saveForm(email: value);
                                        saveForm(kodePos: value);
                                      },
                                      textInputAction: TextInputAction.done,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                        decimal: false,
                                        signed: true,
                                      ),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      maxLength: 6,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            MyDimen.paddingTxtField(),
                                        labelText: 'Kode Pos',
                                        labelStyle: TextStyle(
                                          color: MyColor.txtField,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyColor.txtField),
                                        ),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyColor.lineTxtField),
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
                                        margin:
                                            EdgeInsets.symmetric(vertical: 25),
                                        child: DropdownSearch<Zone>(
                                          items: province,
                                          enabled: (province?.length ?? 0) > 1,
                                          key: UniqueKey(),
                                          label: "Pilih Provinsi",
                                          hint: "Pilih Provinsi",
                                          onChanged: (Zone data) =>
                                              setZona(data, 1),
                                          onSaved: (Zone data) => {},
                                          /*showSelectedItem: true,*/
                                          selectedItem: selectProvince,
                                          showSearchBox: true,
                                          itemAsString: (Zone prov) =>
                                              prov.name,
                                    searchBoxDecoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding:
                                      EdgeInsets.fromLTRB(12, 12, 8, 0),
                                      labelText: "Pilih Provinsi",
                                    ),
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
                                  child: DropdownSearch<Zone>(
                                    items: district,
                                    enabled: selectProvince != null &&
                                        skenario == 2,
                                    key: UniqueKey(),
                                    label: "Pilih Kabupaten",
                                    hint: "Pilih Kabupaten",
                                    onChanged: (Zone data) => setZona(data, 2),
                                    onSaved: (Zone data) =>
                                    {
                                      // vm.saveForm(
                                      //     kabupatenName: data.name,
                                      //     kabupatenId: data.id)
                                    },
                                    showSearchBox: true,
                                    selectedItem: selectDistrict,
                                    itemAsString: (Zone kab) =>
                                    kab.name,
                                    searchBoxDecoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding:
                                      EdgeInsets.fromLTRB(12, 12, 8, 0),
                                      labelText: "Pilih Kabupaten",
                                    ),
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
                                  child: DropdownSearch<Zone>(
                                    items: subDistrict,
                                    enabled: selectDistrict != null &&
                                        skenario == 2,
                                    key: UniqueKey(),
                                    label: "Pilih Kecamatan",
                                    hint: "Pilih Kecamatan",
                                    onChanged: (Zone data) => setZona(data, 3),
                                    onSaved: (Zone data) =>
                                    {
                                      // vm.saveForm(
                                      //     kecamatanName: data.name,
                                      //     kecamatanId: data.id)
                                    },
                                    selectedItem: selectSubDistrict,
                                    showSearchBox: true,
                                    itemAsString: (Zone kec) =>
                                    kec.name,
                                    searchBoxDecoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding:
                                      EdgeInsets.fromLTRB(12, 12, 8, 0),
                                      labelText: "Pilih Kecamatan",
                                    ),
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
                                  child: DropdownSearch<Zone>(
                                    items: village,
                                    enabled: selectSubDistrict != null,
                                    key: UniqueKey(),
                                    label: "Pilih Desa",
                                    hint: "Pilih Desa",
                                    onChanged: (Zone data) => setZona(data, 4),
                                    onSaved: (Zone data) => {},
                                    selectedItem: selectVillage,
                                    showSearchBox: true,
                                    itemAsString: (Zone desa) =>
                                    desa.name,
                                    searchBoxDecoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding:
                                      EdgeInsets.fromLTRB(12, 12, 8, 0),
                                      labelText: "Pilih Desa",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (skenario == 2)
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 25),
                                    child: DropdownSearch<Zone>(
                                      items: postalCodes,
                                      enabled: selectVillage != null &&
                                          (postalCodes?.length ?? 0) != 1,
                                      key: UniqueKey(),
                                      label: "Pilih Kodepos",
                                      hint: "Pilih Kodepos",
                                      onChanged: (Zone data) =>
                                      {selectPostalCode = data},
                                      onSaved: (Zone data) => {},
                                      selectedItem: selectPostalCode,
                                      showSearchBox: true,
                                      itemAsString: (Zone postalCode) =>
                                      postalCode.name,
                                      searchBoxDecoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                        EdgeInsets.fromLTRB(12, 12, 8, 0),
                                        labelText: "Pilih Kodepos",
                                      ),
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
                                onPressed: () async {
                                  setState(() {
                                    // vm?.actionSubmit(context);
                                    actionSubmit(context);
                                  });
                                },
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(30.0))),
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
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getProvinsi();
  //   vm = Get.arguments as AddressController;
  // }
  //
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          bgLarge,
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
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
            child: _formLayout(),
          ),
        )
      ],
    );
  }
}
