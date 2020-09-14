import 'package:aksestokomobile/screen/home/payment_screen.dart';
import 'package:aksestokomobile/util/my_color.dart';
import 'package:flutter/material.dart';

abstract class PaymentController extends State<PaymentScreen> {

  bool CashOnDelivery = false;
  bool CashBeforeDelivery = false;
  bool KreditPro = false;
  bool TempoDistributor = false;
  int currentTab = 0;


  GlobalKey<ScaffoldState> _key ;
  List<String> _dynamicBank;
  List<String> _dynamicTempo;
  List<Color> _colorBank;
  int _value;
  int _tempo;

  @override
  void initState() {
    super.initState();
    // _key = GlobalKey<ScaffoldState> ();
    _dynamicBank = ['Mandiri', 'BCA', 'BNI', 'BRI'];
    _dynamicTempo = ['30 Hari', '45 Hari', '60 Hari'];
    _colorBank = [Color(0xFFff8a65), Color(0xFF4fc3f7), Color(0xFF9575cd), Color(0xFF4db6ac)];
    _value = 0;
    _tempo = 0;
  }



  listBank(){
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: List<Widget>.generate(_dynamicBank.length, (int index) {
        return Container(
          margin: EdgeInsets.only(left: 4, right: 8, top:0, bottom: 8,),
          child: ChoiceChip(
            backgroundColor: _colorBank[index],
            labelPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            label:  Text(_dynamicBank[index], style: TextStyle(color: _value != index ? Colors.black : Colors.white ),),
            avatar: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 15,
              child: _value!= index ? Text('') : Icon(Icons.check, color: Colors.green,),
            ),
            selected: _value == index,
            selectedColor: _colorBank[index],
            onSelected: (bool selected){
              setState(() {
                _value = selected ? index : null;
                print(_value);
              });
            },
          ),
        );
      }),
    );
  }

  listTempo(){
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: List<Widget>.generate(_dynamicTempo.length, (int index) {
        return Container(
          margin: EdgeInsets.only(left: 4, right: 8, top:0, bottom: 8,),
          child: ChoiceChip(
            labelPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            label:  Text(_dynamicTempo[index], style: TextStyle(color: _tempo != index ? Colors.black : Colors.white ),),
            avatar: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 15,
              child: _tempo!= index ? Text('') : Icon(Icons.check, color: Colors.green,),
            ),
            selected: _tempo == index,
            selectedColor: MyColor.redAT,
            onSelected: (bool selected){
              setState(() {
                _tempo = selected ? index : null;
                print(_tempo);
              });
            },
          ),
        );
      }),
    );
  }

}